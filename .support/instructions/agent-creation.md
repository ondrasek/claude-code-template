# Agent Creation Principles

Empirically-derived principles for determining when agents provide measurable value over inline processing.

## Context and Scope

**CRITICAL NOTE**: These principles apply to **agent creation decisions** and **system architecture**. They do NOT override CLAUDE.md's operational mandates for parallel agent usage in existing workflows.

**Principle Application**:
- **Agent Creation**: Apply all principles rigorously - prefer consolidation over new agents
- **Agent Usage**: Follow CLAUDE.md aggressive parallel coordination for optimal analysis
- **System Evolution**: Balance principle-driven design with operational performance requirements

**Conflict Resolution**: When principles conflict with CLAUDE.md operational mandates, operational requirements take precedence. These principles guide long-term system design, not immediate execution patterns.

## Core Principles

### 1. Context Window Decluttering (PRIMARY PURPOSE)
**The fundamental value of dedicated sub-agents is maintaining a clean, focused main context window.**

Agents exist primarily to prevent the main context from becoming polluted with:
- Lengthy intermediate analysis steps
- Multi-file code examination artifacts
- Complex reasoning chains that obscure primary task focus
- Repetitive processing output that adds noise without immediate value
- Detailed technical research that supports but doesn't directly answer user queries

**Critical Requirements:**
- **Agent tasks MUST remove clutter from main context** - not just organize it differently
- **Agent outputs MUST be concise summaries** - detailed work stays in agent context
- **Multiple tool calls and file analysis MUST happen in agent context** - never in main
- **Intermediate reasoning MUST be contained** - main context sees only conclusions
- **Complex research MUST be synthesized** - raw information gathering stays isolated

**Evidence of Success:**
Main context conversations remain focused on user intent rather than processing artifacts. Users see clean, actionable results without intermediate computational noise.

**Context Pollution Anti-Patterns:**
- Running multi-file analysis directly in main context
- Showing detailed reasoning chains for simple requests
- Displaying raw tool output instead of synthesized insights
- Performing iterative refinement cycles visibly in main context
- Presenting unsorted research results requiring user filtering

### 1a. Capability Uniqueness Principle
**Each agent must provide distinct, non-overlapping value to the system.**

**Core Principle**: Agent specialization value diminishes when coordination overhead exceeds analytical benefits. The system optimizes for unique contributions rather than exhaustive coverage.

**Uniqueness Guidelines:**
- **Domain Cohesion**: Natural problem domains should not be artificially split across multiple agents
- **Tool Synergy**: Agents using identical tool combinations for similar outcomes indicate consolidation opportunity
- **Capability Boundaries**: Each agent should own a distinct analytical perspective or computational approach
- **Authority Assignment**: Single agent should be authoritative source for each domain expertise

**System Optimization Principle**: Minimize total agent count while maximizing unique value contribution. Quality of specialization matters more than quantity of specialists.

### 2. Overhead Justification
Create agents only when the complexity reduction in main context exceeds the overhead of agent creation and maintenance.

**Measurable criteria:**
- Task generates >50 lines of intermediate analysis that pollutes main context
- Process requires >3 sequential tool invocations with complex state management
- Logic gets reused across >3 different scenarios

**Evidence required:** Document specific overhead reduction achieved

### 3. Prompt Specialization (Not "Cognitive")
Agents provide specialized prompting strategies for specific analysis patterns, not magical cognitive differences.

**Practical examples:**
- `patterns` agent: Optimized prompting for systematic code pattern detection
- `critic` agent: Prompting designed to generate contrarian analysis
- `completer` agent: Prompting focused on finding gaps and missing implementations

**Reality check:** All agents use the same language model with different instructions

### 4. Context Boundary Management
Agents should handle tasks that have clear input/output boundaries and don't require ongoing main context interaction.

**Good boundaries:**
- Input: File paths or code snippets
- Process: Self-contained analysis
- Output: Structured recommendations

**Bad boundaries:**
- Requires iterative clarification from main context
- Needs access to ongoing conversation state
- Produces outputs requiring main context interpretation

### 5. Focus on Computational Tasks and Thinking Patterns
Agents should embody computational tasks, thinking patterns, paradigms, and analytical perspectives - not human organizational roles.

**Correct agent approaches:**
- **Computational tasks**: `patterns` - Systematically detect code duplication across files
- **Context window isolation**: `researcher` - Gather information without cluttering main context
- **Thinking patterns**: `critic` - Apply contrarian analysis methodology
- **Paradigms**: `axioms` - Derive solutions from first principles reasoning
- **Perspectives**: `constraints` - View problems through limitation/trade-off lens
- **Points of view**: `hypothesis` - Approach debugging through systematic theory formation

**Incorrect agent approaches:**
- **Human roles**: `project-manager`, `team-lead`, `stakeholder`, `scrum-master`
- **Social dynamics**: `mediator`, `facilitator`, `coordinator`
- **Organizational positions**: `architect`, `senior-developer`, `tech-lead`

**Rationale:** Agents excel at computational processing, systematic analysis patterns, and specialized analytical perspectives. They provide value through focused thinking approaches and context isolation - not at replicating human social dynamics or organizational responsibilities.

### 6. Coordination Efficiency Principle
**System performance emerges from agent interaction patterns, not individual agent capabilities.**

**Core Principle**: The value of agent specialization must exceed the cost of coordination. Systems should optimize for interaction efficiency rather than individual agent sophistication.

**Efficiency Guidelines:**
- **Self-Sufficiency**: Agents requiring multiple other agents for basic functionality indicate poor boundary design
- **Proportional Complexity**: Agent sophistication should match task complexity requirements
- **Resource Awareness**: Agent selection should consider computational cost relative to analytical value
- **Execution Patterns**: Different task types warrant different coordination approaches

**System Scalability Principle**: Agent systems have natural complexity thresholds. Beyond these thresholds, coordination overhead degrades rather than enhances system performance.

### 7. Command-Agent Balance Principle
**Specialization should favor commands over agents due to context window economics.**

**Core Principle**: Commands are selected by users and have zero context window overhead, while agents are selected by Claude Code and consume context resources. Therefore, specialization needs should prioritize command creation over agent proliferation.

**Balance Guidelines:**
- **User-Directed Specialization**: When users need specific workflows or specialized analysis, create commands
- **System-Directed Generalization**: Agents should handle broad analytical patterns that Claude Code can automatically select
- **Context Efficiency**: Commands avoid the coordination overhead and context fragmentation of multi-agent workflows
- **Selection Clarity**: User command selection eliminates agent boundary ambiguity and selection errors

**Specialization Hierarchy**: Commands > Agents > Agent Combinations. Move down the hierarchy only when the previous level cannot adequately address the need.

## Decision Framework

### Agent Creation Checklist

**Before creating an agent, verify:**

0. **Command-first evaluation (PREREQUISITE)**
   - [ ] Specialization need cannot be addressed through user-selected commands
   - [ ] Requires Claude Code automatic selection rather than user direction
   - [ ] Task benefits from system-directed rather than user-directed specialization
   - [ ] Cannot be efficiently implemented as specialized command workflow

1. **Context window decluttering justification (PRIMARY)**
   - [ ] Task currently pollutes main context with >50 lines of intermediate processing
   - [ ] Multiple file reads/analysis would clutter main context with technical artifacts
   - [ ] Complex reasoning chains would obscure primary user intent in main context
   - [ ] Raw research/analysis output would require user filtering in main context
   - [ ] Agent can provide clean, actionable summary while containing detailed work

2. **Capability uniqueness validation**
   - [ ] Agent provides distinct analytical perspective not available elsewhere
   - [ ] Agent fills genuine capability gap in current ecosystem
   - [ ] Cannot be efficiently merged with existing agents without losing unique value
   - [ ] Provides unique tool combination or computational approach
   - [ ] Maintains system coherence without artificial domain splitting

3. **Coordination efficiency assessment**
   - [ ] Agent can operate self-sufficiently for its core domain
   - [ ] Coordination overhead justified by specialized analytical value
   - [ ] Agent complexity proportional to task complexity requirements
   - [ ] Doesn't create dependency chains that degrade system performance
   - [ ] Interaction patterns enhance rather than complicate workflow efficiency

4. **Quantifiable complexity reduction**
   - [ ] Task currently generates >50 lines of intermediate output in main context
   - [ ] Process involves >3 tool calls with state management between them
   - [ ] Same analysis pattern needed in >3 different contexts

5. **Clear boundaries**
   - [ ] Input can be defined as specific parameters (files, patterns, criteria)
   - [ ] Output is structured and actionable without further clarification
   - [ ] Process doesn't require mid-execution guidance from main context

6. **Specialization value**
   - [ ] Requires specialized prompting strategy not suitable for main context
   - [ ] Benefits from focused instructions and examples
   - [ ] Produces higher quality results than general-purpose prompting

### When NOT to Create an Agent

**Avoid agents when:**
- **Command-appropriate**: Specialization need can be addressed through user-selected commands
- **User-directed workflows**: Users can better direct the specialized analysis themselves
- **Single-use scenarios**: Only needed for one specific task or codebase
- **Simple tool orchestration**: Just calls 1-2 tools in sequence without complex logic
- **Requires conversational context**: Needs access to ongoing discussion state
- **Marginal benefit**: Overhead of agent creation exceeds complexity reduction

**DESIGN ANTI-PATTERNS:**
- **Command displacement**: Creating agents for specialization better handled by commands
- **Context inefficiency**: Choosing agent coordination over command-directed workflows
- **Artificial domain splitting**: Breaking naturally cohesive domains into multiple agents
- **Tool redundancy**: Multiple agents using identical approaches for overlapping outcomes
- **Coordination dependency**: Agent cannot function independently within its stated domain
- **Performance degradation**: Agent addition increases system complexity without proportional value
- **Capability overlap**: Significant overlap with existing agent capabilities
- **System bloat**: Addition contributes to coordination complexity exceeding analytical benefits

## Validation and Measurement

### Agent Success Metrics

**Measurable indicators of agent value:**

1. **Context window decluttering (PRIMARY METRIC)**:
   - Lines of intermediate processing eliminated from main context
   - Reduction in tool call artifacts visible to main context
   - User conversations stay focused on intent rather than processing details
   - Main context readability and focus improvement

2. **Context reduction**: Lines of intermediate output eliminated from main context
3. **Reuse frequency**: Number of times agent is invoked across different scenarios
4. **Output quality**: Structured, actionable results that don't require clarification
5. **Boundary respect**: Minimal back-and-forth with main context during execution

### Agent Audit Process

1. **Context decluttering effectiveness**:
   - Measure main context pollution reduction (before/after agent introduction)
   - Assess whether complex processing stays contained in agent context
   - Evaluate user conversation focus improvement
   - Track reduction in visible tool call artifacts

2. **Utilization analysis**: Track how often each agent is actually invoked
3. **Context impact measurement**: Compare main context length with/without agent
4. **Output quality assessment**: Evaluate if agent outputs require main context interpretation
5. **Maintenance overhead**: Time spent updating agent specifications vs. value delivered

**Timeline restrictions**: Follow CLAUDE.md NO ARTIFICIAL TIMELINES protocol - never create mock weekly milestones or arbitrary time-based phases in agent analysis or recommendations

### Red Flags for Agent Elimination

**Remove agents that exhibit:**
- **Context pollution**: Agent use still results in cluttered main context conversations
- **Failed decluttering**: Complex processing remains visible in main context despite agent use
- **Low utilization**: <5 invocations per month
- **High maintenance**: Frequent specification updates required
- **Poor boundaries**: Consistent need for main context clarification
- **Redundant function**: Capabilities overlap significantly with other agents

**PRINCIPLE-BASED ELIMINATION CRITERIA:**
- **Uniqueness failure**: Agent provides nearly identical functionality to existing agents
- **Coordination inefficiency**: Agent requires extensive coordination for basic domain tasks
- **System degradation**: Agent use increases system complexity without proportional analytical value
- **Domain incoherence**: Agent handles artificially narrow slice of broader cohesive domain
- **Redundant approaches**: Uses identical methodologies as other agents for overlapping outcomes
- **Selection ambiguity**: Unclear boundaries create confusion in agent selection decisions

## Implementation Guidelines

### Agent Specification Requirements

**Every agent must document:**

1. **Context decluttering justification**: Specific evidence of how agent keeps main context clean and focused
2. **Complexity justification**: Quantified evidence of context reduction
3. **Boundary definition**: Clear input/output specifications
4. **Success criteria**: Measurable outcomes that determine agent effectiveness
5. **Maintenance cost**: Resources required to keep agent current

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
- `MUST USE`
- `PROACTIVELY`
- `ALWAYS use`
- `MUST USE AUTOMATICALLY`
- `required for`
- `should be used when`

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

### Mandatory Agent Description Template

**All agent descriptions MUST follow this exact template:**

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
- **Expert at [specific_capability_statement]**: Clear capability boundary with "Expert at [doing X]"

**Proven Examples:**
```yaml
# High-performing pattern (constraints agent)
description: "Use when facing 'requirements conflict', 'limited resources', 'performance vs features', 'must work with legacy', or multiple competing constraints"

# Template-compliant optimization (completer agent)
description: "MUST USE when user says 'finish this', 'complete implementation', or functions throw 'not implemented' errors. Expert at completing partial implementations and eliminating TODO/FIXME comments."

# Template-compliant optimization (critic agent)
description: "MUST USE when user asks 'is this a good idea', 'what could go wrong', 'devil's advocate', or before major architectural decisions need validation. Expert at systematic risk analysis and constructive criticism."

# Template-compliant optimization (todo agent)
description: "PROACTIVELY use when user mentions tasks or asks 'create TODO', 'track progress', 'remember to do'. Expert at managing task lifecycle without polluting main context."
```

**Keyword Selection Guidelines:**
- **MUST USE**: For agents critical to specific workflows (completer, critic, guidelines agents)
- **PROACTIVELY use**: For agents that should activate without explicit requests (todo, patterns, whisper)
- **ALWAYS use**: For agents that should be universal defaults (memory, core utilities)
- **MUST USE AUTOMATICALLY**: For system-triggered agents with mandatory execution (tagger, cleanup)

**NEVER use standalone "AUTOMATICALLY"** - too weak for selection priority. Always combine with stronger directive.

### Current Agent Status

**Note**: Existing agents remain unchanged pending empirical evaluation against these principles. Future agent modifications should follow the validation framework and selection optimization guidelines above.
