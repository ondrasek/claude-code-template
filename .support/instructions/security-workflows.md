# Multi-Agent Security Workflow Combinations

This document outlines powerful multi-agent workflow combinations enabled by the specialized security agents with extended thinking pattern integration.

## Core Security Agents

### 🔍 **vulnerability-scanner**
- **Pattern**: Security pattern matching/scanning
- **Focus**: Code-level security flaw detection using OWASP/CVE
- **Integrations**: researcher (CVE lookup) + patterns (anti-patterns) + critic (risk validation)

### 🎯 **threat-modeling**  
- **Pattern**: Attack surface analysis/systems thinking
- **Focus**: Architectural security risk assessment
- **Integrations**: context (architecture) + researcher (threat intel) + constraints (trade-offs) + critic (validation)

### ✅ **compliance-checker**
- **Pattern**: Rule-based compliance assessment  
- **Focus**: Regulatory standard evaluation (SOC2, GDPR, HIPAA)
- **Integrations**: researcher (regulations) + patterns (compliance anti-patterns) + context (scope) + constraints (feasibility) + critic (audit risk)

## Comprehensive Security Workflows

### 🛡️ **Complete Security Assessment**
**Use Case**: Full security review of system or codebase
```
1. vulnerability-scanner: Initial OWASP Top 10 scan
2. → researcher: "Research CVE database for detected frameworks and versions"  
3. → patterns: "Find structural security anti-patterns in authentication/authorization logic"
4. → threat-modeling: "Model attack surface and threat scenarios for system architecture"
5. → context: "Map system architecture showing security-relevant data flows"
6. → compliance-checker: "Assess regulatory compliance for detected data types and industry"
7. → researcher: "Research compliance requirements and recent enforcement actions"
8. → critic: "Evaluate if identified security issues represent real vs theoretical risks"
9. → constraints: "Balance security recommendations with operational feasibility"
10. SYNTHESIZE: Comprehensive security assessment with prioritized recommendations
```

### 🔐 **Web Application Security Review**
**Use Case**: Security analysis for web applications
```
1. vulnerability-scanner: Scan for web app vulnerabilities (OWASP Top 10)
2. → researcher: "Research recent web application attack trends and CVEs"
3. → threat-modeling: "Model web application attack surface and user access patterns"
4. → patterns: "Detect insecure coding patterns in authentication and session management"
5. → compliance-checker: "Check web application privacy and data protection compliance"
6. → critic: "Assess realistic exploitability of web application vulnerabilities"
7. RESULT: Web-specific security assessment with attack scenarios
```

### 🏢 **Enterprise Compliance Audit**
**Use Case**: Regulatory compliance preparation
```
1. compliance-checker: Initial compliance framework assessment
2. → researcher: "Research latest regulatory requirements and enforcement guidance"
3. → context: "Map compliance scope to system architecture and data handling"
4. → patterns: "Find compliance anti-patterns in data handling and access controls"
5. → vulnerability-scanner: "Scan for security vulnerabilities affecting compliance"
6. → threat-modeling: "Model regulatory compliance threat scenarios"
7. → constraints: "Assess compliance implementation vs operational requirements"
8. → critic: "Evaluate audit risk and remediation priorities"
9. RESULT: Audit-ready compliance assessment with evidence gaps identified
```

### 🚨 **Incident Response Security Analysis**
**Use Case**: Post-incident security analysis
```
1. vulnerability-scanner: Scan for vulnerabilities related to incident
2. → threat-modeling: "Model attack path and lateral movement possibilities"
3. → patterns: "Find similar vulnerable patterns across system"
4. → researcher: "Research attack techniques and indicators of compromise"
5. → compliance-checker: "Assess compliance implications and breach notification requirements"
6. → critic: "Evaluate containment effectiveness and residual risks"
7. RESULT: Comprehensive incident analysis with remediation plan
```

## Specialized Security Combinations

### 🎯 **API Security Assessment**
```
vulnerability-scanner → patterns → threat-modeling → critic
Focus: API endpoint security, authentication flaws, data exposure
```

### 🔒 **Data Privacy Analysis**  
```
compliance-checker → patterns → researcher → constraints → critic
Focus: GDPR/CCPA compliance, data handling practices, privacy controls
```

### 🏗️ **Architecture Security Review**
```
threat-modeling → context → vulnerability-scanner → constraints → critic  
Focus: System design security, trust boundaries, attack surface reduction
```

### 💾 **Database Security Assessment**
```
vulnerability-scanner → patterns → threat-modeling → compliance-checker
Focus: SQL injection, data encryption, access controls, audit trails
```

### ☁️ **Cloud Security Analysis**
```
threat-modeling → compliance-checker → vulnerability-scanner → researcher → critic
Focus: Cloud misconfigurations, shared responsibility model, compliance frameworks
```

## Industry-Specific Workflows

### 🏥 **Healthcare Security (HIPAA)**
```
1. compliance-checker: HIPAA compliance assessment
2. → vulnerability-scanner: PHI protection vulnerability scan
3. → threat-modeling: Healthcare-specific threat scenarios
4. → researcher: "Research healthcare cybersecurity threats and HIPAA enforcement"
5. → patterns: "Find PHI handling anti-patterns"
6. → critic: "Assess HIPAA violation risks and patient impact"
```

### 💳 **Financial Services Security (PCI-DSS)**
```
1. compliance-checker: PCI-DSS compliance review
2. → vulnerability-scanner: Payment data security vulnerabilities
3. → threat-modeling: Financial fraud and data theft scenarios  
4. → researcher: "Research financial cybercrime trends and PCI enforcement"
5. → constraints: "Balance PCI compliance with user experience"
```

### 🏛️ **Government Security (FedRAMP)**
```
1. compliance-checker: FedRAMP control assessment
2. → vulnerability-scanner: Government security standard vulnerabilities
3. → threat-modeling: Nation-state and advanced persistent threats
4. → researcher: "Research government cybersecurity requirements and threats"
```

## Advanced Multi-Agent Patterns

### 🔄 **Iterative Security Hardening**
```
Round 1: vulnerability-scanner → patterns → researcher
Round 2: Apply fixes, threat-modeling → context → critic  
Round 3: compliance-checker → constraints → final validation
```

### 🎭 **Red Team / Blue Team Simulation**
```
Red Team: threat-modeling → vulnerability-scanner → researcher (attack techniques)
Blue Team: patterns → compliance-checker → constraints (defensive measures)
Synthesis: critic → comprehensive security posture assessment
```

### 📊 **Security Metrics and KPIs**
```
1. vulnerability-scanner: Vulnerability density metrics
2. → compliance-checker: Compliance score tracking
3. → threat-modeling: Attack surface reduction metrics
4. → patterns: Security anti-pattern trend analysis
5. → critic: Overall security posture assessment
```

## Agent Coordination Best Practices

### 🔧 **Mandatory Coordination Rules**
- **High-severity findings**: Always involve critic for risk validation
- **Compliance gaps**: Use constraints for feasibility assessment
- **Architecture changes**: Include context for system understanding
- **New technologies**: Invoke researcher for security intelligence

### ⚡ **Performance Optimization**
- **Parallel execution**: Run independent agents simultaneously
- **Smart chaining**: Use previous agent outputs as input for next agents
- **Context sharing**: Leverage shared understanding across agent network
- **Result synthesis**: Combine findings into actionable recommendations

### 🎯 **Quality Assurance**
- **Cross-validation**: Multiple agents validate critical findings
- **False positive reduction**: Critic agent challenges assumptions
- **Practical focus**: Constraints agent ensures implementability
- **Research backing**: All recommendations supported by intelligence

This workflow framework enables comprehensive security analysis through coordinated agent intelligence, providing thorough coverage while maintaining practical focus and actionable outcomes.