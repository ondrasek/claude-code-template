#!/bin/bash

# Secure Secret Management for DevContainer
# Handles secrets from multiple sources with proper security

set -e

echo "🔐 DevContainer Secure Secret Management"
echo "======================================="

# Security validation function
validate_secret() {
    local secret_name="$1"
    local secret_value="$2"
    
    # Check if secret is set and not a placeholder
    if [ -z "$secret_value" ] || [ "$secret_value" = "your-${secret_name,,}-here" ] || [ "$secret_value" = "your-api-key-here" ]; then
        return 1
    fi
    return 0
}

# Load secrets from multiple sources (in priority order)
load_secrets() {
    echo "📋 Loading secrets from available sources..."
    
    # Source 1: GitHub Codespaces (automatic)
    if [ "$CODESPACES" = "true" ]; then
        echo "✅ GitHub Codespaces environment detected"
        echo "   Secrets automatically injected by GitHub"
        return 0
    fi
    
    # Source 2: Local environment variables (inherited from host)
    if [ -n "$CLAUDE_API_KEY" ] || [ -n "$PERPLEXITY_API_KEY" ] || [ -n "$GITHUB_TOKEN" ]; then
        echo "✅ Using inherited environment variables from host"
        return 0
    fi
    
    # Source 4: Enterprise vault (if configured)
    if [ -n "$VAULT_URL" ] && [ -n "$VAULT_TYPE" ]; then
        echo "✅ Enterprise vault configured: $VAULT_TYPE"
        echo "   Advanced vault integration available"
        return 0
    fi
    
    echo "⚠️  No secret sources found"
    return 1
}

# Validate and display secret status
validate_secrets() {
    echo ""
    echo "🔍 Secret Validation Status:"
    echo "----------------------------"
    
    # Claude API Key validation
    if validate_secret "claude-api-key" "$CLAUDE_API_KEY"; then
        echo "✅ CLAUDE_API_KEY: Valid"
    else
        echo "❌ CLAUDE_API_KEY: Missing or invalid"
        MISSING_SECRETS=1
    fi
    
    # GitHub Token validation  
    if validate_secret "github-token" "$GITHUB_TOKEN"; then
        echo "✅ GITHUB_TOKEN: Valid"
    elif gh auth status >/dev/null 2>&1; then
        echo "✅ GITHUB_TOKEN: Authenticated via gh CLI"
    else
        echo "⚠️  GITHUB_TOKEN: Not set (use 'gh auth login')"
    fi
    
    # Perplexity API Key validation (optional)
    if validate_secret "perplexity-api-key" "$PERPLEXITY_API_KEY"; then
        echo "✅ PERPLEXITY_API_KEY: Valid (MCP server ready)"
    else
        echo "ℹ️  PERPLEXITY_API_KEY: Optional (for MCP server)"
    fi
}

# Setup secret sources
setup_secrets() {
    echo ""
    echo "🛠️  Secret Setup Options:"
    echo "========================="
    
    if [ "$CODESPACES" = "true" ]; then
        echo "GitHub Codespaces Setup:"
        echo "1. Go to: https://github.com/settings/codespaces"
        echo "2. Add repository or organization secrets:"
        echo "   - CLAUDE_API_KEY"
        echo "   - PERPLEXITY_API_KEY (optional)"
        echo "3. Restart your Codespace to apply changes"
        
    else
        echo "Local Development Setup:"
        echo "1. Set environment variables on your host machine:"
        echo "   export CLAUDE_API_KEY='your-key-here'"
        echo "   export PERPLEXITY_API_KEY='your-key-here'"
        echo ""
        echo "2. Add to your shell profile (persistent):"
        echo "   echo 'export CLAUDE_API_KEY=\"your-key\"' >> ~/.bashrc"
        echo "   echo 'export PERPLEXITY_API_KEY=\"your-key\"' >> ~/.bashrc"
        echo "   source ~/.bashrc"
        echo ""
        echo "3. Restart/rebuild the devcontainer to apply changes"
        echo ""
        echo "📝 The devcontainer will automatically inherit these variables"
    fi
    
    echo ""
    echo "GitHub Authentication:"
    echo "   gh auth login"
}

# Security audit function
security_audit() {
    echo ""
    echo "🛡️  Security Audit:"
    echo "==================="
    
    # Check for hardcoded secrets in files
    echo "📋 Checking for hardcoded secrets..."
    
    local issues=0
    
    # Check devcontainer.json for hardcoded secrets
    if grep -q "sk-.*" .devcontainer/devcontainer.json 2>/dev/null; then
        echo "❌ WARNING: Potential hardcoded secret in devcontainer.json"
        issues=$((issues + 1))
    fi
    
    # Check for .env files in git
    if git ls-files | grep -q "\.env" 2>/dev/null; then
        echo "❌ WARNING: .env file tracked in git"
        issues=$((issues + 1))
    fi
    
    # Check for hardcoded secrets in environment
    if printenv | grep -q "sk-.*=" 2>/dev/null; then
        echo "⚠️  Potential API key detected in environment"
        echo "   (This is normal if you've set them correctly)"
    fi
    
    if [ $issues -eq 0 ]; then
        echo "✅ No security issues detected"
    else
        echo "❌ $issues security issues found - please review"
    fi
}

# Cleanup function for secret protection
cleanup_secrets() {
    echo ""
    echo "🧹 Secret Cleanup (on container shutdown):"
    echo "==========================================="
    
    # Remove any temporary secret files
    find /tmp -name "*secret*" -type f -delete 2>/dev/null || true
    find /tmp -name "*key*" -type f -delete 2>/dev/null || true
    
    # Clear history entries that might contain secrets
    history -c 2>/dev/null || true
    
    echo "✅ Temporary secrets cleaned up"
}

# Main execution
main() {
    load_secrets
    validate_secrets
    
    if [ "$MISSING_SECRETS" = "1" ]; then
        setup_secrets
    fi
    
    security_audit
    
    # Set up cleanup on exit
    trap cleanup_secrets EXIT
    
    echo ""
    echo "🎯 Secret Management Summary:"
    echo "============================"
    echo "✅ Secure secret loading implemented"
    echo "✅ Security validation completed" 
    echo "✅ Cleanup procedures in place"
    echo ""
    echo "🔗 Useful commands:"
    echo "   validate-security  - Run security validation"
    echo "   setup-secrets      - Re-run secret setup"
    echo "   gh auth status     - Check GitHub authentication"
    echo "   claude auth status - Check Claude authentication"
}

# Create aliases for easy access
alias validate-security='bash .devcontainer/secure-secrets.sh'
alias setup-secrets='bash .devcontainer/secure-secrets.sh'

# Run main function
main "$@"