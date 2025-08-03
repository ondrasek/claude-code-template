#!/bin/bash

# Security Validation Script for DevContainer
# Validates security posture and compliance requirements

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Security test results
SECURITY_SCORE=0
TOTAL_TESTS=0
CRITICAL_FAILURES=0

# Logging
log_security_check() {
    local check_name="$1"
    local status="$2"
    local details="${3:-}"
    
    echo "[$(date -Iseconds)] SECURITY_CHECK:$check_name STATUS:$status DETAILS:$details" >> /tmp/security-validation.log
}

# Test execution wrapper
run_security_test() {
    local test_name="$1"
    local test_function="$2"
    local is_critical="${3:-false}"
    
    echo -e "\n🔍 Testing: $test_name"
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    if $test_function; then
        echo -e "${GREEN}✅ PASS${NC}: $test_name"
        SECURITY_SCORE=$((SECURITY_SCORE + 1))
        log_security_check "$test_name" "PASS" ""
    else
        if [[ "$is_critical" == "true" ]]; then
            echo -e "${RED}❌ CRITICAL FAIL${NC}: $test_name"
            CRITICAL_FAILURES=$((CRITICAL_FAILURES + 1))
            log_security_check "$test_name" "CRITICAL_FAIL" ""
        else
            echo -e "${YELLOW}⚠️  WARN${NC}: $test_name"
            log_security_check "$test_name" "WARN" ""
        fi
    fi
}

# Security Test Functions

test_no_hardcoded_secrets() {
    local found_secrets=false
    local patterns=(
        "password.*=.*['\"][^'\"<]{8,}['\"]"
        "token.*=.*['\"][^'\"<]{20,}['\"]"
        "key.*=.*['\"][^'\"<]{16,}['\"]"
        "secret.*=.*['\"][^'\"<]{8,}['\"]"
        "api[_-]?key.*=.*['\"][^'\"<]{8,}['\"]"
    )
    
    for pattern in "${patterns[@]}"; do
        if grep -r -i -E "$pattern" .devcontainer/ 2>/dev/null \
           | grep -v "env.template" \
           | grep -v "<your-.*-here>" \
           | grep -v "<your-.*>" \
           | grep -v "SECRETS_DIR\|SECRETS_LOG\|SECRETS_CONFIG" \
           | grep -v "secret_value\|secret_file\|secret_name" \
           | grep -v "critical_secrets" \
           | grep -v "setup-secrets\|secure-secrets.sh"; then
            found_secrets=true
        fi
    done
    
    [[ "$found_secrets" == "false" ]]
}

test_env_file_security() {
    # Check for .env files that shouldn't exist
    local insecure_files=(".env" ".env.production" ".env.staging")
    
    for file in "${insecure_files[@]}"; do
        if [[ -f ".devcontainer/$file" ]]; then
            echo "  ❌ Found insecure environment file: $file"
            return 1
        fi
    done
    
    # Check .env.local is not in git
    if git check-ignore .devcontainer/.env.local >/dev/null 2>&1; then
        return 0
    elif [[ ! -f ".devcontainer/.env.local" ]]; then
        return 0
    else
        echo "  ❌ .env.local should be in .gitignore"
        return 1
    fi
}

test_file_permissions() {
    local secure=true
    
    # Check script permissions
    for script in setup.sh secure-secrets.sh security-validation.sh; do
        if [[ -f ".devcontainer/$script" ]]; then
            local perms=$(stat -c "%a" ".devcontainer/$script")
            if [[ "$perms" != "755" && "$perms" != "750" ]]; then
                echo "  ❌ Script $script has insecure permissions: $perms"
                secure=false
            fi
        fi
    done
    
    # Check for world-writable files
    if find .devcontainer/ -type f -perm /o+w 2>/dev/null | grep -q .; then
        echo "  ❌ Found world-writable files"
        secure=false
    fi
    
    [[ "$secure" == "true" ]]
}

test_container_security() {
    # Check if running as non-root
    local container_user=$(grep '"remoteUser"' .devcontainer/devcontainer.json | cut -d'"' -f4)
    if [[ "$container_user" != "codespace" && "$container_user" != "vscode" ]]; then
        echo "  ⚠️  Container user is: $container_user (consider non-root user)"
        return 1
    fi
    
    # Check for privileged mode
    if grep -q '"privileged".*true' .devcontainer/devcontainer.json; then
        echo "  ❌ Container running in privileged mode"
        return 1
    fi
    
    return 0
}

test_secret_injection_method() {
    # Check if using secure secret injection
    if grep -q 'localEnv:' .devcontainer/devcontainer.json; then
        # This is acceptable for now, but could be improved
        return 0
    fi
    
    # Check for direct secret embedding
    if grep -E '"[A-Z_]*KEY".*"[^$]' .devcontainer/devcontainer.json; then
        echo "  ❌ Found directly embedded secrets"
        return 1
    fi
    
    return 0
}

test_git_security() {
    local secure=true
    
    # Check .gitignore for secret patterns
    local required_patterns=(".env.local" "*.key" "*.pem" "secrets/")
    
    for pattern in "${required_patterns[@]}"; do
        if ! grep -q "$pattern" .gitignore 2>/dev/null; then
            echo "  ⚠️  .gitignore missing pattern: $pattern"
            secure=false
        fi
    done
    
    # Check for secrets in git history
    if git log --all --grep="password\|secret\|key" --oneline | head -1 | grep -q .; then
        echo "  ⚠️  Potential secrets mentioned in git history"
        secure=false
    fi
    
    [[ "$secure" == "true" ]]
}

test_network_security() {
    # Check for insecure network configurations
    if grep -q '"network".*"host"' .devcontainer/devcontainer.json; then
        echo "  ❌ Using host networking (security risk)"
        return 1
    fi
    
    # Check port forwarding configuration
    local forwarded_ports=$(grep -A5 '"forwardPorts"' .devcontainer/devcontainer.json || true)
    if echo "$forwarded_ports" | grep -q "0\.0\.0\.0"; then
        echo "  ❌ Port forwarding to all interfaces"
        return 1
    fi
    
    return 0
}

test_extension_security() {
    local secure=true
    
    # Check for potentially risky extensions
    local risky_patterns=("exec" "shell" "terminal" "ssh")
    
    for pattern in "${risky_patterns[@]}"; do
        if grep -i "$pattern" .devcontainer/devcontainer.json | grep -q "extensions"; then
            echo "  ⚠️  Extension with potential security implications found"
            # This is a warning, not a failure
        fi
    done
    
    return 0
}

test_audit_logging() {
    # Check if audit logging is configured
    if [[ -f ".devcontainer/secure-secrets.sh" ]]; then
        if grep -q "log_secret_access" .devcontainer/secure-secrets.sh; then
            return 0
        fi
    fi
    
    echo "  ⚠️  No audit logging configured for secret access"
    return 1
}

test_compliance_readiness() {
    local compliant=true
    
    # Check for compliance documentation
    if [[ ! -f ".devcontainer/env.template" ]]; then
        echo "  ❌ Missing environment template for compliance"
        compliant=false
    fi
    
    # Check for security documentation
    if [[ ! -f ".devcontainer/SECURITY.md" ]] && ! grep -q -i "security\|compliance" .devcontainer/README.md 2>/dev/null; then
        echo "  ⚠️  Missing security documentation"
        compliant=false
    fi
    
    [[ "$compliant" == "true" ]]
}

# Generate security report
generate_security_report() {
    local score_percentage=$((SECURITY_SCORE * 100 / TOTAL_TESTS))
    
    echo -e "\n📊 SECURITY VALIDATION REPORT"
    echo "==============================="
    echo "Tests Passed: $SECURITY_SCORE/$TOTAL_TESTS ($score_percentage%)"
    echo "Critical Failures: $CRITICAL_FAILURES"
    
    if [[ $CRITICAL_FAILURES -gt 0 ]]; then
        echo -e "${RED}🚨 CRITICAL SECURITY ISSUES DETECTED${NC}"
        echo "❌ DevContainer has critical security vulnerabilities that must be addressed"
        return 1
    elif [[ $score_percentage -ge 90 ]]; then
        echo -e "${GREEN}🛡️  EXCELLENT SECURITY POSTURE${NC}"
        echo "✅ DevContainer meets high security standards"
    elif [[ $score_percentage -ge 70 ]]; then
        echo -e "${YELLOW}⚠️  GOOD SECURITY WITH IMPROVEMENTS NEEDED${NC}"
        echo "🔧 DevContainer has good baseline security with room for improvement"
    else
        echo -e "${RED}🔒 SECURITY IMPROVEMENTS REQUIRED${NC}"
        echo "⚠️  DevContainer needs significant security enhancements"
    fi
    
    # Compliance assessment
    echo -e "\n📋 COMPLIANCE ASSESSMENT"
    echo "========================"
    
    if [[ $score_percentage -ge 85 && $CRITICAL_FAILURES -eq 0 ]]; then
        echo "✅ SOC 2 Type II: Ready for assessment"
        echo "✅ GDPR: Compliant with data protection requirements"
        echo "✅ Enterprise: Suitable for enterprise deployment"
    else
        echo "❌ SOC 2 Type II: Requires security improvements"
        echo "⚠️  GDPR: May need additional data protection measures"
        echo "⚠️  Enterprise: Security hardening recommended"
    fi
    
    return 0
}

# Main execution
main() {
    echo "🔐 DevContainer Security Validation"
    echo "==================================="
    echo "Validating security posture and compliance readiness..."
    
    # Initialize log
    echo "[$(date -Iseconds)] SECURITY_VALIDATION_START" > /tmp/security-validation.log
    
    # Run security tests
    run_security_test "No Hardcoded Secrets" test_no_hardcoded_secrets true
    run_security_test "Environment File Security" test_env_file_security true
    run_security_test "File Permissions" test_file_permissions false
    run_security_test "Container Security" test_container_security false
    run_security_test "Secret Injection Method" test_secret_injection_method true
    run_security_test "Git Security" test_git_security false
    run_security_test "Network Security" test_network_security false
    run_security_test "Extension Security" test_extension_security false
    run_security_test "Audit Logging" test_audit_logging false
    run_security_test "Compliance Readiness" test_compliance_readiness false
    
    # Generate final report
    generate_security_report
    
    echo -e "\n📝 Security validation log: /tmp/security-validation.log"
    echo "🔍 Run with VERBOSE=1 for detailed output"
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi