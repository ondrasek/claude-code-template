# /agent-create

Guide for creating new Claude Code agents following empirical principles, selection optimization, and multi-agent coordination patterns.

## Usage
```
/agent-create [agent-name]
```

## What it does
- **Validates agent necessity** using decision framework from @.support/instructions/agent-creation.md
- **Checks for redundancy** with existing 27 agents across all computational thinking patterns
- **Guides agent specification** with proven description patterns from gold standard agents
- **Generates optimized descriptions** with Tier 1 selection keywords and mandatory template compliance
- **Designs multi-agent coordination** patterns for sophisticated workflow integration
- **Creates agent file** with proper frontmatter, structure, and integration protocols

## Current Agent Ecosystem (27 agents)

### Core Analysis Agents
- **patterns**, **researcher**, **context**, **hypothesis**, **axioms**, **constraints**

### Security Specialists (Post-Split)
- **vulnerability-scanner**, **threat-modeling**, **compliance-checker**

### Quality & Performance
- **testing**, **performance**, **critic**, **completer**, **whisper**

### Architecture & Decision
- **explorer**, **resolver**, **principles**, **invariants**, **connector**

### Workflow & Documentation
- **generator**, **docs**, **git-tagger**, **git-troubleshooter**, **todo**, **time**, **prompter**

### Technology Guidelines
- **guidelines-file**, **guidelines-repo**

## Agent Creation Workflow

### Phase 1: Necessity Validation
1. **Computational thinking pattern identification**: Define the single coherent thinking pattern
2. **Complexity justification**: Verify task generates >50 lines of intermediate output
3. **Boundary analysis**: Confirm clear input/output boundaries exist
4. **Reuse assessment**: Check if pattern applies to >3 different contexts
5. **Redundancy check**: Compare against all 27 existing agent capabilities
6. **Human role avoidance**: Ensure focus on computational tasks vs organizational roles

### Phase 2: Multi-Agent Integration Design
1. **Coordination requirements**: Define mandatory integrations with other agents
2. **Workflow patterns**: Design multi-agent sequences (e.g., agent → researcher → critic)
3. **Cross-validation**: Plan false positive reduction through agent collaboration
4. **Quality assurance**: Define critic agent integration for complex findings

### Phase 3: Description Optimization
1. **Mandatory template compliance**: Follow exact template format requirements
2. **Tier 1 keyword integration**: Include MUST USE/PROACTIVELY keywords
3. **Trigger specification**: Add quoted user phrases for context matching
4. **Expert statement**: Define clear capability boundaries with "Expert at" statement
5. **Selection testing**: Validate description against Claude Code selection algorithm

### Phase 4: Agent Generation
1. **Create agent file** in `.claude/agents/` directory
2. **Generate YAML frontmatter** with optimized description
3. **Add agent body** following gold standard templates (performance, testing, security agents)
4. **Implement coordination protocols** with mandatory agent integrations
5. **Document workflow patterns** in `.support/workflows/` if applicable
6. **Document justification** for future audits

## Mandatory Description Template

**All new agents MUST follow this exact template:**

```yaml
---
name: [descriptive-name]
description: "[TIER1_KEYWORD] when [specific_user_context] or [quoted_user_phrases]. Expert at [specific_capability_statement]."
---
```

**Template Components:**
- **[TIER1_KEYWORD]**: MUST USE | PROACTIVELY use | ALWAYS use | MUST USE AUTOMATICALLY
- **[specific_user_context]**: When user does/asks/mentions X
- **[quoted_user_phrases]**: 'exact user language', 'common phrases', 'trigger words'
- **Expert at [specific_capability_statement]**: Clear capability boundary

## Decision Checklist

Before creating an agent, verify ALL criteria against current ecosystem:

### Core Principles Compliance
- [ ] **Single thinking pattern**: Represents one coherent computational thinking pattern
- [ ] **Complexity justification**: Task generates >50 lines of intermediate output in main context
- [ ] **Tool complexity**: Process involves >3 tool calls with state management
- [ ] **Reusability**: Same analysis pattern needed in >3 different contexts
- [ ] **Specialization value**: Requires specialized prompting strategy not suitable for main context

### Boundary Requirements
- [ ] **Clear input/output**: Can be defined as specific parameters
- [ ] **Structured output**: Actionable results without clarification
- [ ] **Self-contained**: Process doesn't require mid-execution guidance from main context
- [ ] **Context isolation**: Eliminates pollution of main context

### Ecosystem Integration
- [ ] **No redundancy**: No existing agent among 27 covers this capability
- [ ] **Coordination design**: Plans for multi-agent integration patterns
- [ ] **Workflow contribution**: Enables new or improved multi-agent workflows
- [ ] **Human role avoidance**: Not mirroring organizational positions or social dynamics

### Quality Standards
- [ ] **Template compliance**: Follows mandatory description template exactly
- [ ] **Tier 1 keywords**: Includes MUST USE/PROACTIVELY selection optimization
- [ ] **Expert boundaries**: Clear "Expert at" capability statement
- [ ] **Trigger specificity**: Quoted user phrases for algorithm matching

## Selection Priority Keywords

**Tier 1 (Highest selection probability):**
- `MUST USE` (for critical workflow agents)
- `PROACTIVELY` (for agents that should activate automatically)
- `ALWAYS use` (for universal defaults)
- `MUST USE AUTOMATICALLY` (for system-triggered agents)

**Tier 2 (High priority):**
- `Expert at`
- `specialized in`
- `designed for`
- `Use when`

**Context Matching Examples (Proven Effective):**
- `'security review'`, `'vulnerability check'` (vulnerability-scanner)
- `'performance issues'`, `'slow code'` (performance)
- `'test strategy'`, `'test coverage'` (testing)
- `'threat model'`, `'attack surface'` (threat-modeling)
- `'is this SOLID'`, `'best practices'` (principles)

## Multi-Agent Coordination Patterns

### Mandatory Integration Examples
**Security agents demonstrate advanced coordination:**
```
vulnerability-scanner MUST coordinate with:
→ researcher (CVE intelligence)
→ patterns (security anti-patterns)
→ critic (risk validation)
```

### Workflow Integration
**Design agents to enable sophisticated multi-agent workflows:**
- **Security Assessment**: vulnerability-scanner → researcher → patterns → threat-modeling → critic
- **Performance Optimization**: performance → patterns → hypothesis → constraints → critic
- **Quality Assurance**: testing → security → performance → completer

## Gold Standard Templates

**Use these agents as templates for new development:**
- **performance.md**: 261 lines, perfect algorithmic analysis structure
- **testing.md**: 308 lines, comprehensive systematic methodology
- **vulnerability-scanner.md**: Excellent multi-agent coordination patterns
- **threat-modeling.md**: Outstanding architectural analysis framework

## Related Commands
- `/agent-audit` - Review existing agents against principles
- `/agent-guide` - Documentation on using existing 26 agents

## Reference Documentation
- @.support/instructions/agent-creation.md - Complete creation principles
- @.support/workflows/security-workflows.md - Multi-agent coordination examples
- @.support/instructions/stack-mapping.md - Technology detection patterns

## Success Metrics

**New agents should achieve:**
- **Description Quality**: 5/5 stars with perfect template compliance
- **Selection Optimization**: Algorithm-friendly with quoted user triggers
- **Boundary Clarity**: Self-contained with structured outputs
- **Overhead Justification**: Clear >50 line context reduction
- **Integration Readiness**: Designed for multi-agent coordination

**Current ecosystem averages: 4.4/5.0 stars across 27 agents**