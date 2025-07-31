# /security

TRIGGER: security audit request
FOCUS: vulnerabilities, risks, remediation
SCOPE: full codebase security analysis

ENHANCED_ACTIONS:
1. coordinate enhanced parallel security specialist clusters:
   - **Primary Security Analysis Cluster**: foundation-patterns + foundation-criticism + specialist-constraint-solver + foundation-research (comprehensive security analysis with intelligence validation)
   - **Threat Intelligence Cluster**: foundation-research + foundation-patterns + specialist-options-analyzer + foundation-context (CVE intelligence, pattern recognition, threat modeling, system understanding)
   - **Architectural Security Cluster**: specialist-options-analyzer + specialist-constraint-solver + foundation-principles + specialist-stack-advisor (alternative security approaches, boundary validation, design integrity, fundamental security principles)
   - **Risk Assessment Cluster**: foundation-criticism + specialist-code-cleaner + specialist-performance-optimizer + specialist-stack-advisor (risk validation, completeness assessment, performance impact, analysis)
   - **Implementation Validation Cluster**: specialist-test-strategist + foundation-principles + specialist-stack-advisor + specialist-code-cleaner (security testing, principle compliance, documentation, technology-specific guidance)
2. synthesize findings into prioritized risk assessment validated by foundation-conflicts + foundation-criticism + foundation-principles agents
3. generate comprehensive remediation roadmap with specialist-constraint-solver + specialist-code-cleaner + specialist-stack-advisor analysis

PARAMETERS:
--focus [auth|injection|crypto|deps|config]
--severity [critical|high|medium|low]
--fix (auto-fix simple issues)
--quick (critical only)
--deps-only (dependency scan only)
--output [json|sarif|html]

ENHANCED_AGENT_CLUSTERS:
Primary Security Analysis: foundation-patterns + foundation-criticism + specialist-constraint-solver + foundation-research
Threat Intelligence: foundation-research + foundation-patterns + specialist-options-analyzer + foundation-context
Architectural Security: specialist-options-analyzer + specialist-constraint-solver + foundation-principles + specialist-stack-advisor
Risk Assessment: foundation-criticism + specialist-code-cleaner + specialist-performance-optimizer + foundation-conflicts
Implementation Validation: specialist-test-strategist + foundation-principles + specialist-stack-advisor + specialist-code-cleaner
Synthesis & Remediation: foundation-conflicts + foundation-criticism + foundation-principles + specialist-constraint-solver + specialist-stack-advisor
Coordination: All enhanced clusters execute in parallel for comprehensive multi-dimensional security coverage

VULNERABILITY_CHECKS:
- injections: SQL, XSS, command, LDAP, XML
- auth: weak auth, missing checks, privilege escalation
- crypto: weak algorithms, hardcoded secrets
- deps: CVE database matching
- config: headers, CORS, TLS

OUTPUT:
- severity categorized vulnerabilities
- CVSS scores where applicable
- specific remediation code
- prioritized fix order
- CWE/OWASP references

```
## Security Audit Report

**Scan Date**: 2024-01-20
**Files Scanned**: 127
**Critical Issues**: 3
**High Issues**: 8
**Medium Issues**: 15
**Low Issues**: 22

### CRITICAL Vulnerabilities

1. **SQL Injection** [OWASP A03:2021]
   - **File**: `src/api/user.py:45`
   - **Severity**: Critical (CVSS: 9.8)
   - **Evidence**:
   ```python
   # VULNERABLE CODE
   query = f"SELECT * FROM users WHERE id = {user_id}"
   cursor.execute(query)
   ```
   - **Attack Vector**: Attacker can execute arbitrary SQL
   - **Fix**:
   ```python
   # SECURE CODE
   query = "SELECT * FROM users WHERE id = ?"
   cursor.execute(query, (user_id,))
   ```
   - **References**: CWE-89, OWASP SQL Injection

2. **Hardcoded API Key** [OWASP A07:2021]
   - **File**: `src/config.py:12`
   - **Severity**: Critical (CVSS: 8.6)
   - **Evidence**:
   ```python
   API_KEY = "sk-1234567890abcdef"  # EXPOSED SECRET
   ```
   - **Fix**:
   ```python
   import os
   API_KEY = os.environ.get('API_KEY')
   if not API_KEY:
       raise ValueError("API_KEY environment variable not set")
   ```

### HIGH Risk Issues

1. **Missing Authentication**
   - **File**: `src/api/admin.py:23`
   - **Severity**: High (CVSS: 7.5)
   - **Evidence**: Admin endpoint lacks authentication
   ```python
   @app.route('/admin/users', methods=['DELETE'])
   def delete_user():  # No auth check!
       User.query.filter_by(id=request.json['id']).delete()
   ```
   - **Fix**: Add authentication decorator

### Dependency Vulnerabilities (foundation-research agent)

| Package | Current | Secure | CVE | Severity |
|---------|---------|--------|-----|----------|
| flask | 1.1.2 | 2.3.3 | CVE-2023-30861 | High |
| requests | 2.25.0 | 2.31.0 | CVE-2023-32681 | Medium |
| pyyaml | 5.3 | 6.0.1 | CVE-2020-14343 | High |

### Security Principles Analysis (foundation-principles agent)

1. **Least Privilege Violation**
   - Database user has DROP privileges
   - API tokens don't expire
   - No role-based access control

2. **Defense in Depth Missing**
   - No rate limiting
   - No input sanitization layer
   - Single point of failure in auth

### Attack Surface Map

```
Internet → Load Balancer → Web Server → Application → Database
            ↓                ↓            ↓            ↓
         [No WAF]      [Weak TLS]   [No Auth]    [SQL Injection]
```

### Remediation Priority

1. **Immediate** (24 hours)
   - Fix SQL injection vulnerabilities
   - Remove hardcoded secrets
   - Add authentication to admin endpoints

2. **Short-term** (1 week)
   - Update vulnerable dependencies
   - Implement input validation
   - Add security headers

3. **Long-term** (1 month)
   - Implement RBAC
   - Add rate limiting
   - Set up security monitoring
```

## Security Scanners Integration

The command can invoke external tools:
- **SAST**: Static analysis with semgrep/bandit
- **Dependency Check**: safety/npm audit/bundler-audit
- **Secret Scanning**: truffleHog/gitleaks
- **Container Scanning**: trivy/grype

## Parameters

- `--focus <area>`: Focus on specific security domain
  - `auth`, `injection`, `crypto`, `deps`, `config`
- `--severity <level>`: Minimum severity to report
  - `critical`, `high`, `medium`, `low`
- `--fix`: Attempt to auto-fix simple issues
- `--quick`: Fast scan for critical issues only
- `--deps-only`: Only scan dependencies
- `--output <format>`: Output format (json, sarif, html)

## Common Vulnerability Patterns

### SQL Injection Prevention
```python
# Bad - String concatenation
query = f"SELECT * FROM users WHERE name = '{name}'"

# Good - Parameterized queries
query = "SELECT * FROM users WHERE name = ?"
cursor.execute(query, (name,))

# Good - ORM with parameterization
user = User.query.filter_by(name=name).first()
```

### XSS Prevention
```javascript
// Bad - Direct HTML insertion
element.innerHTML = userInput;

// Good - Text content
element.textContent = userInput;

// Good - Sanitization
element.innerHTML = DOMPurify.sanitize(userInput);
```

### Authentication Best Practices
```python
# Bad - Plain text password
if user.password == request.form['password']:

# Good - Hashed password
if bcrypt.checkpw(request.form['password'].encode('utf-8'), 
                  user.password_hash):

# Good - With rate limiting
@limiter.limit("5 per minute")
def login():
    # Login logic
```

## Agent Integration

**Enhanced Specialized Security Integration**:

**Primary Security Analysis Cluster** (foundation-patterns + foundation-criticism + specialist-constraint-solver + foundation-research):
- Code-level security flaw detection with research-validated pattern matching
- Attack surface analysis with constraint-based security validation and risk assessment
- Comprehensive security assessment with latest CVE database integration

**Threat Intelligence Cluster** (foundation-research + foundation-patterns + specialist-options-analyzer + foundation-context):
- CVE database intelligence with comprehensive threat analysis
- Security anti-pattern recognition with system context understanding
- Attack vector analysis with multiple threat landscape assessment approaches

**Architectural Security Cluster** (specialist-options-analyzer + specialist-constraint-solver + foundation-principles + specialist-stack-advisor):
- Security solution alternatives with fundamental principle validation
- Access control design with constraint-aware security state management
- Defense strategy optimization within architectural constraints and technology guidance

**Risk Assessment Cluster** (foundation-criticism + specialist-code-cleaner + specialist-performance-optimizer + foundation-conflicts):
- Security assumption validation with performance impact analysis
- Completeness assessment with code quality risk pattern analysis
- Conflict resolution in competing security requirements

**Implementation Validation Cluster** (specialist-test-strategist + foundation-principles + specialist-stack-advisor + specialist-code-cleaner):
- Security testing with technology-specific guidance
- Principle-based validation with comprehensive documentation
- Implementation gap identification with completeness verification

**Enhanced Advanced Multi-Dimensional Coordination**: Security analysis coordinates through foundation-conflicts + foundation-criticism + foundation-principles integration for comprehensive, validated, and actionable security analysis with universal agent support

## Memory Integration

**Before Security Analysis**: Use `mcp__memory__search_nodes()` to check for:
- Previous security assessments and vulnerability patterns
- Historical threat modeling outcomes
- Known compliance requirements and audit findings
- Security improvement success/failure patterns

**After Security Analysis**: Store findings with `mcp__memory__create_entities()` and `mcp__memory__create_relations()`:
- Vulnerability patterns and remediation effectiveness
- Threat model evolution and attack surface changes
- Compliance requirement mappings and audit outcomes
- Security architecture decisions and their long-term impact

## Related Commands

- `/review` - General code review including security validation
- `/test` - Add security test cases and penetration testing
- `/refactor` - Implement security improvements with architectural changes
- `/agent-ecosystem-review` - Include security agent effectiveness analysis

## Best Practices

1. **Shift Left**: Run security scans early and often
2. **Automate**: Integrate into CI/CD pipeline
3. **Prioritize**: Fix critical issues first
4. **Verify Fixes**: Re-scan after remediation
5. **Document**: Keep security documentation updated
6. **Train Team**: Share security findings with developers
7. **Monitor**: Set up runtime security monitoring