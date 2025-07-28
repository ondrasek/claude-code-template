# Agent Creation Principles

Empirically-derived principles for determining when agents provide measurable value over inline processing.

## Core Principles

### 1. Overhead Justification
Create agents only when the complexity reduction in main context exceeds the overhead of agent creation and maintenance.

**Measurable criteria:**
- Task generates >50 lines of intermediate analysis that pollutes main context
- Process requires >3 sequential tool invocations with complex state management
- Logic gets reused across >3 different scenarios

**Evidence required:** Document specific overhead reduction achieved

### 2. Prompt Specialization (Not "Cognitive")
Agents provide specialized prompting strategies for specific analysis patterns, not magical cognitive differences.

**Practical examples:**
- `patterns` agent: Optimized prompting for systematic code pattern detection
- `critic` agent: Prompting designed to generate contrarian analysis
- `completer` agent: Prompting focused on finding gaps and missing implementations

**Reality check:** All agents use the same language model with different instructions

### 3. Context Boundary Management
Agents should handle tasks that have clear input/output boundaries and don't require ongoing main context interaction.

**Good boundaries:**
- Input: File paths or code snippets
- Process: Self-contained analysis
- Output: Structured recommendations

**Bad boundaries:** 
- Requires iterative clarification from main context
- Needs access to ongoing conversation state
- Produces outputs requiring main context interpretation

### 4. Avoid Human Organizational Roles
Agents should not mirror human team roles or organizational positions. They should focus on computational tasks and analysis patterns.

**Good agent concepts:**
- `critic` - Provides contrarian analysis (analysis pattern)
- `patterns` - Detects code duplication (computational task)
- `completer` - Finds missing implementations (systematic analysis)

**Bad agent concepts:**
- `project-manager` - Human organizational role
- `team-lead` - Human hierarchical position  
- `stakeholder` - Human business role
- `scrum-master` - Human process role

**Rationale:** Claude Code agents excel at computational tasks, systematic analysis, and specialized prompting strategies - not at replicating human social dynamics or organizational responsibilities.

## Decision Framework

### Agent Creation Checklist

**Before creating an agent, verify:**

1. **Quantifiable complexity reduction** 
   - [ ] Task currently generates >50 lines of intermediate output in main context
   - [ ] Process involves >3 tool calls with state management between them
   - [ ] Same analysis pattern needed in >3 different contexts

2. **Clear boundaries**
   - [ ] Input can be defined as specific parameters (files, patterns, criteria)
   - [ ] Output is structured and actionable without further clarification
   - [ ] Process doesn't require mid-execution guidance from main context

3. **Specialization value**
   - [ ] Requires specialized prompting strategy not suitable for main context
   - [ ] Benefits from focused instructions and examples
   - [ ] Produces higher quality results than general-purpose prompting

### When NOT to Create an Agent

**Avoid agents when:**
- **Single-use scenarios**: Only needed for one specific task or codebase
- **Simple tool orchestration**: Just calls 1-2 tools in sequence without complex logic
- **Requires conversational context**: Needs access to ongoing discussion state
- **Marginal benefit**: Overhead of agent creation exceeds complexity reduction

## Validation and Measurement

### Agent Success Metrics

**Measurable indicators of agent value:**

1. **Context reduction**: Lines of intermediate output eliminated from main context
2. **Reuse frequency**: Number of times agent is invoked across different scenarios  
3. **Output quality**: Structured, actionable results that don't require clarification
4. **Boundary respect**: Minimal back-and-forth with main context during execution

### Agent Audit Process

**Quarterly review criteria:**

1. **Utilization analysis**: Track how often each agent is actually invoked
2. **Context impact measurement**: Compare main context length with/without agent
3. **Output quality assessment**: Evaluate if agent outputs require main context interpretation
4. **Maintenance overhead**: Time spent updating agent specifications vs. value delivered

### Red Flags for Agent Elimination

**Remove agents that exhibit:**
- **Low utilization**: <5 invocations per month
- **High maintenance**: Frequent specification updates required
- **Poor boundaries**: Consistent need for main context clarification
- **Redundant function**: Capabilities overlap significantly with other agents

## Implementation Guidelines

### Agent Specification Requirements

**Every agent must document:**

1. **Complexity justification**: Quantified evidence of context reduction
2. **Boundary definition**: Clear input/output specifications
3. **Success criteria**: Measurable outcomes that determine agent effectiveness
4. **Maintenance cost**: Resources required to keep agent current

## Claude Code Agent Selection Mechanism

### How Claude Code Selects Agents

Claude Code's agent selection algorithm primarily uses:

1. **Agent name**: Must be descriptive and unique
2. **Description field**: Critical for matching user requests to appropriate agents
3. **Content analysis**: Scans description text for relevant keywords and patterns

### Description Field Optimization

**High-impact elements Claude Code prioritizes:**

1. **Action keywords**: "Expert at", "specialized in", "designed for"
2. **Proactive indicators**: "PROACTIVELY", "automatically", "should be used when"
3. **Mandatory language**: "MUST USE", "required for", "essential when"
4. **Specific triggers**: Concrete scenarios that warrant agent invocation
5. **Capability boundaries**: What the agent does and doesn't handle

### Proven Description Patterns

**High selection rate patterns:**

```yaml
# Pattern 1: Mandatory usage
description: "MUST USE when debugging 'why does this happen', 'strange behavior', 'performance issue', 'it should work but doesn't', or investigating unexpected results"

# Pattern 2: Proactive triggers  
description: "PROACTIVELY use after writing significant code for quality analysis and potential improvements"

# Pattern 3: Specific expertise
description: "Expert at detecting code patterns, anti-patterns, duplication, and refactoring opportunities across codebases"
```

**Low selection rate patterns:**
```yaml
# Too generic
description: "Helps with code analysis"

# No trigger words
description: "Analyzes codebases for improvements"

# Vague capabilities
description: "General purpose development assistant"
```

### Selection Priority Keywords

**Tier 1 (Highest priority):**
- `PROACTIVELY` 
- `MUST USE`
- `automatically`
- `should be used when`
- `required for`

**Tier 2 (High priority):**
- `Expert at`
- `specialized in` 
- `designed for`
- `Use when`

**Tier 3 (Medium priority):**
- `helps with`
- `assists in`
- `provides`

### Context Matching Strategies

**Domain-specific triggers:**
```yaml
# Code quality contexts
description: "Use when user asks 'is this SOLID', 'best practices', 'design principles', 'is this good architecture'"

# Debugging contexts  
description: "Use when debugging 'why does this happen', 'strange behavior', 'performance issue'"

# Decision-making contexts
description: "Use when user asks 'what are my options', 'different ways to', 'compare approaches', 'pros and cons'"
```

**Anti-patterns to avoid:**
- Generic descriptions without specific triggers
- Missing action-oriented language
- No proactive usage indicators
- Overlapping descriptions with existing agents

## Description Optimization Examples

### Current Agent Analysis

**High-performing descriptions (from existing agents):**

```yaml
# hypothesis agent - excellent trigger specificity
description: "Use when debugging 'why does this happen', 'strange behavior', 'performance issue', 'it should work but doesn't', or investigating unexpected results"

# principles agent - clear proactive usage
description: "Use during /review or when user asks 'is this SOLID', 'best practices', 'design principles', 'is this good architecture', or code quality concerns"

# constraints agent - specific problem contexts  
description: "Use when facing 'requirements conflict', 'limited resources', 'performance vs features', 'must work with legacy', or multiple competing constraints"
```

**Descriptions needing optimization:**

```yaml
# Too generic - needs specific triggers
description: "Expert at gathering current information, best practices, and technical solutions through web search and documentation analysis"

# Missing proactive indicators
description: "Expert at detecting code patterns, anti-patterns, duplication, and refactoring opportunities across codebases"
```

### Selection Algorithm Insights

Based on observed Claude Code behavior:

1. **Exact phrase matching**: Claude Code looks for exact matches to user language in descriptions
2. **Proactive keyword priority**: "PROACTIVELY" and "MUST USE" significantly boost selection probability  
3. **Context sensitivity**: Descriptions with quoted user phrases ("why does this happen") perform better
4. **Negative correlation**: Generic terms like "helps with" reduce selection likelihood

### Future Agent Description Template

```yaml
---
name: [descriptive-name]
description: "[TIER1_KEYWORD] when [specific_user_context] or [quoted_user_phrases]. [Capability_boundary_statement]"
---
```

**Example application:**
```yaml
---
name: performance-optimizer
description: "PROACTIVELY use when user mentions 'slow performance', 'optimization needed', or 'this takes too long'. Expert at identifying bottlenecks and suggesting concrete performance improvements"
---
```

### Current Agent Status

**Note**: Existing agents remain unchanged pending empirical evaluation against these principles. Future agent modifications should follow the validation framework and selection optimization guidelines above.
