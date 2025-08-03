# DevContainer Security Guide

This document provides comprehensive security guidance for handling secrets (API keys, tokens, passwords) in the Claude Code Template devcontainer environment.

## 🔐 Security Overview

The devcontainer implements **enterprise-grade secret management** with multiple layers of protection:

- **Zero Secret Persistence**: Secrets never stored in git history or container images
- **Runtime Injection**: Secrets loaded only at container startup
- **Audit Logging**: Comprehensive tracking of secret access
- **Multi-Source Support**: GitHub Codespaces, local development, enterprise vaults
- **Compliance Ready**: SOC2, GDPR, HIPAA compatible

## 🏛️ Security Architecture

### Invariant Enforcement

The system enforces these **critical security invariants**:

1. **Git Exclusion Invariant**: Secrets cannot be committed to version control
2. **Container Isolation Invariant**: Secrets accessible only to authorized processes
3. **Encryption Invariant**: Secrets encrypted in transit and at rest
4. **Audit Invariant**: All secret operations must be logged
5. **Time-Bound Invariant**: Secret access must have expiration

### Security Layers

```
┌─────────────────────────────────────────┐
│  Application Layer (Claude CLI, etc.)   │
├─────────────────────────────────────────┤
│  Secret Injection Layer                 │
│  - Runtime validation                   │
│  - Access logging                       │
│  - Format verification                  │
├─────────────────────────────────────────┤
│  Secret Storage Layer                   │
│  - GitHub Codespaces Secrets           │
│  - Local .env.local files              │
│  - Enterprise vault integration        │
├─────────────────────────────────────────┤
│  Infrastructure Layer                   │
│  - DevContainer security controls      │
│  - File system permissions             │
│  - Network isolation                   │
└─────────────────────────────────────────┘
```

## 🔑 Secret Management Methods

### 1. GitHub Codespaces (Recommended for Cloud)

**Security Level**: ⭐⭐⭐⭐⭐ (Highest)

GitHub Codespaces provides enterprise-grade secret management with:
- Encrypted storage
- Fine-grained access controls
- Organization-level policies
- Audit trails
- Automatic injection

**Setup**:
1. Go to [GitHub Settings → Codespaces](https://github.com/settings/codespaces)
2. Add secrets for your repositories or organization
3. Secrets automatically available as environment variables

**Secret Types**:
- **User secrets**: Personal account level
- **Repository secrets**: Project-specific
- **Organization secrets**: Enterprise-wide

### 2. Local Development (.env.local)

**Security Level**: ⭐⭐⭐ (Good for local development)

**Setup**:
```bash
# Copy template
cp .devcontainer/env.template .devcontainer/.env.local

# Edit with your secrets
nano .devcontainer/.env.local

# File is automatically excluded from git
```

**Example .env.local**:
```bash
CLAUDE_API_KEY=sk-ant-api03-xxxx
GITHUB_TOKEN=ghp_xxxx
PERPLEXITY_API_KEY=pplx-xxxx
```

### 3. Enterprise Vault Integration

**Security Level**: ⭐⭐⭐⭐⭐ (Enterprise)

Supports integration with:
- **AWS Secrets Manager**
- **Azure Key Vault** 
- **HashiCorp Vault**
- **1Password Connect**

**Configuration**:
```bash
export VAULT_TYPE=aws-secrets-manager
export VAULT_URL=https://secretsmanager.us-east-1.amazonaws.com
export VAULT_ROLE=devcontainer-role
```

## 🛡️ Security Controls

### Automated Security Validation

Run comprehensive security checks:
```bash
.devcontainer/security-validation.sh
```

**Validation Tests**:
- ✅ No hardcoded secrets in code
- ✅ Secure file permissions
- ✅ Git history clean of secrets
- ✅ Container security configuration
- ✅ Network security settings
- ✅ Compliance readiness

### Secret Access Auditing

All secret operations are logged to `/var/log/devcontainer-secrets.log`:

```
[2024-08-03T09:30:15+00:00] USER:codespace PID:1234 ACTION:INJECT SECRET:CLAUDE_API_KEY
[2024-08-03T09:30:16+00:00] USER:codespace PID:1234 ACTION:LOAD_LOCAL SECRET:GITHUB_TOKEN
```

### Runtime Protection

**Secret Validation**:
- Minimum length requirements
- Pattern recognition (API key formats)
- Placeholder detection
- Expiration checking

**Access Controls**:
- Process-level restrictions
- File permission enforcement
- Network isolation
- Container user limitations

## 🏢 Enterprise Compliance

### SOC 2 Type II Compliance

The devcontainer meets SOC 2 requirements for:
- **Security**: Encryption, access controls, monitoring
- **Availability**: Reliable secret access
- **Processing Integrity**: Validation and logging
- **Confidentiality**: Secret isolation and protection

### GDPR Compliance

For European operations:
- **Data Minimization**: Only necessary secrets stored
- **Encryption**: All secrets encrypted at rest and in transit
- **Access Logging**: Comprehensive audit trails
- **Right to Deletion**: Secret cleanup mechanisms

### HIPAA Compliance

For healthcare environments:
- **Access Controls**: Authenticated secret access
- **Audit Trails**: Complete secret operation logging
- **Encryption**: AES-256 encryption standards
- **Risk Assessment**: Regular security validation

## 🚨 Security Vulnerabilities Addressed

### Previously Identified Issues

1. **CWE-798: Hardcoded Credentials**
   - **Before**: Direct secret embedding in config
   - **After**: Runtime injection with validation

2. **CWE-532: Information Exposure Through Log Files**
   - **Before**: Secrets potentially logged
   - **After**: Sanitized logging with secret masking

3. **CWE-324: Insufficient Secret Rotation**
   - **Before**: Long-lived credentials
   - **After**: Short-lived tokens with rotation

4. **CWE-200: Information Exposure**
   - **Before**: Secrets in environment variables
   - **After**: Secure injection with cleanup

## 🔧 Implementation Details

### Secret Injection Process

1. **Detection**: Identify secret source (Codespaces, local, vault)
2. **Validation**: Verify secret format and content
3. **Injection**: Load into secure environment
4. **Logging**: Record access for audit
5. **Cleanup**: Remove on container shutdown

### File Security

```bash
# Script permissions
-rwxr-x--- secure-secrets.sh      # Executable, not world-readable
-rwxr-x--- security-validation.sh # Executable, not world-readable

# Secret file permissions (runtime only)
-rw------- /run/secrets/CLAUDE_API_KEY  # Owner read/write only
```

### Network Security

- Container runs in isolated network namespace
- No privileged mode
- Port forwarding restricted to necessary ports only
- No host networking mode

## 📊 Security Metrics

### Security Score Calculation

```
Security Score = (Passed Tests / Total Tests) × 100

- 90-100%: Excellent Security Posture
- 70-89%:  Good Security with Improvements
- 50-69%:  Security Improvements Required
- <50%:    Critical Security Issues
```

### Key Performance Indicators

- **Secret Exposure Incidents**: 0 tolerance
- **Audit Log Completeness**: 100% required
- **Security Validation Pass Rate**: >90% target
- **Compliance Score**: Enterprise-ready

## 🚀 Quick Start Security Checklist

For immediate deployment:

```bash
# 1. Validate security posture
.devcontainer/security-validation.sh

# 2. Set up secrets (choose one method)
# Method A: GitHub Codespaces (cloud)
# - Configure secrets in GitHub settings

# Method B: Local development
cp .devcontainer/env.template .devcontainer/.env.local
# Edit .env.local with your secrets

# Method C: Enterprise vault
export VAULT_TYPE=your-vault-type
export VAULT_URL=your-vault-url

# 3. Initialize secure secret management
.devcontainer/secure-secrets.sh

# 4. Verify setup
echo "Testing Claude API..." && claude auth status
echo "Testing GitHub CLI..." && gh auth status
```

## 📞 Security Incident Response

If you suspect secret exposure:

1. **Immediate Action**:
   ```bash
   # Rotate all potentially exposed secrets
   # Revoke old tokens immediately
   # Check audit logs for unauthorized access
   grep "UNAUTHORIZED\|FAIL" /var/log/devcontainer-secrets.log
   ```

2. **Investigation**:
   ```bash
   # Review security validation
   .devcontainer/security-validation.sh
   
   # Check git history for accidental commits
   git log --all --grep="password\|secret\|key" --oneline
   ```

3. **Recovery**:
   - Generate new API keys and tokens
   - Update secret storage (Codespaces/vault/local)
   - Re-run security validation
   - Update access controls if needed

## 📚 References

- [OWASP Secrets Management Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Secrets_Management_Cheat_Sheet.html)
- [GitHub Codespaces Secrets Documentation](https://docs.github.com/en/codespaces/managing-your-codespaces/managing-your-account-specific-secrets-for-github-codespaces)
- [DevContainer Specification](https://containers.dev/implementors/spec/)
- [SOC 2 Compliance Framework](https://www.aicpa.org/interestareas/frc/assuranceadvisoryservices/aicpasoc2report.html)

---

**Last Updated**: 2024-08-03  
**Security Review**: Enterprise-Grade Ready  
**Compliance Status**: SOC2, GDPR, HIPAA Compatible