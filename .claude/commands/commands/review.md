---
description: Review slash command(s) following guidelines with redundancy analysis and agent coordination.
argument-hint: Command name, group of commands, namespace or any other designation. Review all commands if empty.
allowed-tools: Task, Read, Write, Glob, Bash, WebSearch, WebFetch
---

# Command Compliance Review

Review slash command definition for compliance with @.support/instructions/claude-commands-guidelines.md using comprehensive multi-agent analysis.

## Instructions

1. Parse $ARGUMENTS for review parameters:
   - Determine which commands are to be reviewed.
   - When no arguments are passed, review all commands under .claude/commands, including commands in sub-folders
   (namespaces).

2. Validate command exists somewhere in .claude/commands/ directory before proceeding

3. Execute comprehensive parallel compliance analysis clusters:

**Phase 1: Structure and Format Analysis**
- **File Structure Cluster**: foundation-patterns + specialist-code-cleaner + foundation-principles (file format validation, structure compliance, principle adherence)
- **Frontmatter Analysis Cluster**: foundation-criticism + specialist-constraint-solver (frontmatter completeness, field validation, tool restrictions)
- **Content Structure Cluster**: foundation-principles + specialist-stack-advisor (content organization, instruction clarity, best practices)

**Phase 2: Guidelines Compliance Assessment**
- **Naming Convention Cluster**: foundation-patterns + foundation-principles (file naming, command naming, convention compliance)
- **Security Compliance Cluster**: foundation-criticism + specialist-constraint-solver + foundation-research (tool restrictions, permission model, security best practices)
- **Content Quality Cluster**: specialist-code-cleaner + foundation-principles + foundation-criticism (instruction quality, AI-optimization, clarity assessment)

**Phase 3: Best Practices and Optimization**
- **Agent Coordination Analysis**: foundation-research + specialist-options-analyzer + foundation-context (agent usage patterns, coordination efficiency, best practices)
- **Integration Pattern Analysis**: foundation-context + specialist-stack-advisor + foundation-principles (project integration, workflow alignment, technology compliance)
- **Quality Assurance Cluster**: foundation-criticism + foundation-principles + specialist-test-strategist (overall quality, improvement opportunities, validation requirements)

4. Compliance Validation Checklist:

**Mandatory Requirements**:
- [ ] File location: .claude/commands/ directory
- [ ] File format: Markdown (.md) extension
- [ ] Frontmatter: Valid YAML with required fields and correct syntax
- [ ] Description: Present and descriptive
- [ ] Argument-hint: Clear parameter guidance
- [ ] Model: Specified (typically "sonnet")
- [ ] Title: Clear, descriptive command title
- [ ] Instructions: Step-by-step AI instructions (not human docs)
- [ ] $ARGUMENTS: Proper parameter reference usage

**Security Requirements**:
- [ ] allowed-tools: Minimal necessary tools only
- [ ] Tool restrictions: Appropriate for command scope
- [ ] Input validation: Parameter validation instructions
- [ ] Security considerations: Appropriate safety measures

**Best Practices**:
- [ ] Single responsibility: One clear purpose
- [ ] Error handling: Common failure scenarios covered
- [ ] Agent coordination: Appropriate agent usage
- [ ] Performance: Efficient execution patterns
- [ ] Maintainability: Clear, sustainable implementation

5. Analysis and Reporting:
   - Generate comprehensive compliance report with specific issues
   - Categorize violations by severity (critical, high, medium, low)
   - Provide specific remediation recommendations for each issue
   - If --fix flag provided, automatically correct fixable issues
   - Present before/after comparison for any fixes applied

6. Output structured compliance assessment with actionable recommendations

## Compliance Assessment Categories

**Critical Issues** (Must Fix):
- Missing required frontmatter fields
- Invalid YAML structure
- Missing or incorrect file location
- Security violations in tool permissions
- Completely missing instructions section

**High Priority Issues**:
- Poor $ARGUMENTS usage
- Inadequate security considerations
- Missing error handling
- Unclear or ambiguous instructions
- Tool permission overreach

**Medium Priority Issues**:
- Suboptimal agent coordination patterns
- Minor naming convention violations
- Incomplete argument hints
- Missing best practice implementations

**Low Priority Issues**:
- Style and formatting inconsistencies
- Minor optimization opportunities
- Documentation improvements
- Enhanced user experience suggestions

## Error Handling

- **File Not Found**: Clear error message with available commands list
- **Invalid Format**: Specific parsing error details and fix guidance
- **Access Issues**: Permission or file system error handling
- **Analysis Failures**: Graceful handling of agent coordination issues

## Output Format

Provide structured compliance report including:
- **Overall Compliance Score**: Percentage score with grade (A-F)
- **Critical Issues**: Must-fix violations with specific remediation steps
- **Security Assessment**: Tool restrictions and permission model compliance
- **Best Practices Score**: Adherence to guidelines best practices
- **Improvement Recommendations**: Specific, actionable enhancement suggestions
- **Agent Coordination Analysis**: Efficiency and pattern assessment
- **Fix Summary**: If --fix used, summary of automatic corrections applied