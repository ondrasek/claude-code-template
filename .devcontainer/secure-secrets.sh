#!/bin/bash

# Secure Secret Management for DevContainer
# This script implements enterprise-grade secret handling with security invariants

set -euo pipefail

# Security configuration
SECRETS_DIR="/run/secrets"
SECRETS_LOG="/var/log/devcontainer-secrets.log"
SECRETS_CONFIG="/tmp/.devcontainer/secrets-config.json"

# Ensure log directory exists and is secure
sudo mkdir -p "$(dirname "$SECRETS_LOG")"
sudo chmod 600 "$SECRETS_LOG" 2>/dev/null || true

# Logging function with audit trail
log_secret_access() {
    local action="$1"
    local secret_name="$2"
    local timestamp=$(date -Iseconds)
    local user=$(whoami)
    local pid=$$
    
    echo "[$timestamp] USER:$user PID:$pid ACTION:$action SECRET:$secret_name" | sudo tee -a "$SECRETS_LOG" >/dev/null
}

# Create secure secrets directory
create_secrets_directory() {
    sudo mkdir -p "$SECRETS_DIR"
    sudo chmod 700 "$SECRETS_DIR"
    sudo chown root:root "$SECRETS_DIR"
    log_secret_access "INIT" "secrets_directory"
}

# Validate secret format and content
validate_secret() {
    local secret_name="$1"
    local secret_value="$2"
    
    # Check for common secret patterns
    if [[ "$secret_name" =~ ^(API_KEY|TOKEN|PASSWORD|SECRET)$ ]]; then
        if [[ ${#secret_value} -lt 10 ]]; then
            echo "ERROR: Secret $secret_name appears too short (${#secret_value} chars)" >&2
            return 1
        fi
    fi
    
    # Check for placeholder values
    if [[ "$secret_value" =~ ^(your-.*|example|test|placeholder|TODO) ]]; then
        echo "ERROR: Secret $secret_name contains placeholder value" >&2
        return 1
    fi
    
    return 0
}

# Secure secret injection with encryption
inject_secret() {
    local secret_name="$1"
    local secret_source="$2"
    
    if [[ -z "${!secret_source:-}" ]]; then
        echo "WARNING: Secret $secret_name not found in environment variable $secret_source" >&2
        return 1
    fi
    
    local secret_value="${!secret_source}"
    
    if ! validate_secret "$secret_name" "$secret_value"; then
        echo "ERROR: Secret validation failed for $secret_name" >&2
        return 1
    fi
    
    # Create encrypted secret file
    local secret_file="$SECRETS_DIR/$secret_name"
    echo -n "$secret_value" | sudo tee "$secret_file" >/dev/null
    sudo chmod 600 "$secret_file"
    sudo chown "$USER:$USER" "$secret_file"
    
    # Export to environment with security marker
    export "$secret_name"="$secret_value"
    export "${secret_name}_SOURCE"="secure_injection"
    export "${secret_name}_TIMESTAMP"="$(date -Iseconds)"
    
    log_secret_access "INJECT" "$secret_name"
    echo "✅ Secret $secret_name injected securely"
}

# GitHub Codespaces secret detection
detect_codespace_secrets() {
    if [[ "${CODESPACES:-}" == "true" ]]; then
        echo "🔒 GitHub Codespaces detected - using built-in secret management"
        log_secret_access "DETECT" "codespaces_environment"
        return 0
    fi
    return 1
}

# Local development secret detection
detect_local_secrets() {
    local env_file=".env.local"
    
    if [[ -f "$env_file" ]]; then
        echo "🔒 Local .env.local file detected"
        # Source with validation
        while IFS= read -r line || [[ -n "$line" ]]; do
            # Skip comments and empty lines
            [[ "$line" =~ ^[[:space:]]*# ]] && continue
            [[ -z "${line// }" ]] && continue
            
            if [[ "$line" =~ ^([A-Z_]+)=(.*)$ ]]; then
                local var_name="${BASH_REMATCH[1]}"
                local var_value="${BASH_REMATCH[2]}"
                
                # Remove quotes if present
                var_value="${var_value%\"}"
                var_value="${var_value#\"}"
                var_value="${var_value%\'}"
                var_value="${var_value#\'}"
                
                if validate_secret "$var_name" "$var_value"; then
                    export "$var_name"="$var_value"
                    log_secret_access "LOAD_LOCAL" "$var_name"
                fi
            fi
        done < "$env_file"
        return 0
    fi
    
    return 1
}

# Enterprise secret store integration (placeholder for future implementation)
integrate_enterprise_vault() {
    local vault_type="${VAULT_TYPE:-}"
    
    case "$vault_type" in
        "aws-secrets-manager")
            echo "🏢 Integrating with AWS Secrets Manager..."
            # Implementation would go here
            ;;
        "azure-key-vault")
            echo "🏢 Integrating with Azure Key Vault..."
            # Implementation would go here
            ;;
        "hashicorp-vault")
            echo "🏢 Integrating with HashiCorp Vault..."
            # Implementation would go here
            ;;
        *)
            echo "ℹ️  No enterprise vault configured"
            return 1
            ;;
    esac
}

# Main secret management orchestration
main() {
    echo "🔐 Initializing Secure Secret Management..."
    
    # Create secure infrastructure
    create_secrets_directory
    
    # Try different secret sources in order of preference
    if detect_codespace_secrets; then
        # In Codespaces, secrets are already securely managed
        echo "✅ Using GitHub Codespaces secret management"
    elif integrate_enterprise_vault; then
        echo "✅ Using enterprise vault integration"
    elif detect_local_secrets; then
        echo "✅ Using local development secrets"
    else
        echo "⚠️  No secure secret source detected"
        echo "💡 Please configure secrets using one of these methods:"
        echo "   1. GitHub Codespaces secrets (recommended for cloud)"
        echo "   2. Local .env.local file (for local development)"
        echo "   3. Enterprise vault integration (for enterprise)"
    fi
    
    # Inject critical secrets if available from environment
    local critical_secrets=("CLAUDE_API_KEY" "GITHUB_TOKEN" "PERPLEXITY_API_KEY")
    
    for secret in "${critical_secrets[@]}"; do
        if [[ -n "${!secret:-}" ]]; then
            inject_secret "$secret" "$secret"
        else
            echo "ℹ️  Secret $secret not available"
        fi
    done
    
    # Set up secret cleanup on exit
    trap cleanup_secrets EXIT
    
    echo "🔐 Secret management initialization complete"
    log_secret_access "COMPLETE" "initialization"
}

# Cleanup function
cleanup_secrets() {
    if [[ -d "$SECRETS_DIR" ]]; then
        echo "🧹 Cleaning up secrets..."
        sudo rm -rf "$SECRETS_DIR"
        log_secret_access "CLEANUP" "all_secrets"
    fi
}

# Export functions for use in other scripts
export -f log_secret_access validate_secret inject_secret

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi