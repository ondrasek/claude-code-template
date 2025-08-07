# Negative Triggers Design for Agent Descriptions

## Overview

This document outlines the design for negative triggers to be added to all agent descriptions to prevent inappropriate usage and improve selection accuracy.

## Current State Analysis

### Existing Patterns Found
- Foundation agents have "Boundary Clarifications" sections with "This agent does NOT handle"
- Some agents have restrictions sections listing what they must not do
- Coordination sections implicitly define boundaries by describing complementary agents
- Selection guidance exists but focuses on positive triggers

### Gaps Identified
- No standardized negative trigger format across all agents
- Missing explicit anti-pattern definitions
- No validation logic for negative triggers
- Inconsistent boundary documentation between agents

## Negative Trigger Categories

### 1. Task Type Exclusions
**Definition:** Specific types of requests this agent cannot handle
- Implementation tasks vs research tasks
- Creation vs analysis tasks  
- One-off solutions vs systematic approaches

### 2. Context Exclusions
**Definition:** Situations where this agent is not appropriate
- When other agents are already working
- Specific workflow phases where agent doesn't apply
- Context-dependent boundaries

### 3. Scale Exclusions  
**Definition:** Tasks too large/small for this agent's capabilities
- Complexity thresholds
- Scope limitations
- Resource constraints

### 4. Technology Exclusions
**Definition:** Domains outside this agent's expertise
- Programming languages not supported
- Framework-specific limitations
- Tool compatibility constraints

### 5. Timing Exclusions
**Definition:** When in workflow this agent should not be used
- Initial creation phases
- After completion phases
- Concurrent usage conflicts

## Proposed Negative Trigger Format

### Standardized Section Structure
```markdown
## Negative Triggers (Do Not Use)

### Task Type Exclusions
- ❌ **Pattern**: "create new...", "implement..."
- ❌ **Reasoning**: This agent focuses on analysis, not implementation
- ❌ **Alternative**: Use implementation-focused agents instead

### Context Exclusions  
- ❌ **Pattern**: "quick fix...", "temporary solution..."
- ❌ **Reasoning**: Agent requires comprehensive analysis
- ❌ **Alternative**: Use rapid-response agents for urgent fixes

### Scale Exclusions
- ❌ **Pattern**: Single-line changes, trivial modifications
- ❌ **Reasoning**: Agent overhead not justified for simple tasks
- ❌ **Alternative**: Direct implementation without agent delegation

### Technology Exclusions
- ❌ **Pattern**: Non-web technologies, embedded systems
- ❌ **Reasoning**: Agent expertise limited to web stack
- ❌ **Alternative**: Use technology-specific specialist agents

### Timing Exclusions
- ❌ **Pattern**: During initial brainstorming, post-completion reviews
- ❌ **Reasoning**: Agent most effective during active development phase
- ❌ **Alternative**: Use planning or review-focused agents
```

### Validation Logic Integration
```markdown
## Selection Validation
Before using this agent, verify:
☐ Task does not match any negative trigger patterns
☐ Context is appropriate for this agent's expertise
☐ Scale justifies agent coordination overhead
☐ Technology stack aligns with agent capabilities
☐ Timing aligns with agent's workflow position
```

## Agent-Specific Negative Trigger Examples

### Researcher Agent
- **Task Exclusions**: "Write code for...", "Implement...", "Create new..."
- **Context Exclusions**: "Internal codebase analysis", "Pattern detection"
- **Scale Exclusions**: "Simple API calls", "Known information lookup"
- **Technology Exclusions**: "Real-time data", "Local-only information"
- **Timing Exclusions**: "After research completed", "During implementation"

### Patterns Agent  
- **Task Exclusions**: "Research new...", "Find external...", "Create unique..."
- **Context Exclusions**: "One-off solutions", "Novel algorithms"
- **Scale Exclusions**: "Single-instance issues", "Non-repeated code"
- **Technology Exclusions**: "External research domains"
- **Timing Exclusions**: "Before code exists", "After refactoring complete"

### Principles Agent
- **Task Exclusions**: "Quick fix...", "Temporary...", "Just make it work..."
- **Context Exclusions**: "Non-code tasks", "Emergency patches"
- **Scale Exclusions**: "Single function validation"
- **Technology Exclusions**: "Non-software design"
- **Timing Exclusions**: "During rapid prototyping", "Post-architecture freeze"

### Critic Agent
- **Task Exclusions**: "Create new...", "Generate ideas...", "Research options..."
- **Context Exclusions**: "Initial creation", "Brainstorming sessions"
- **Scale Exclusions**: "Trivial decisions", "No-risk changes"
- **Technology Exclusions**: "Well-established, proven approaches"
- **Timing Exclusions**: "Before proposal exists", "After decision finalized"

## Implementation Strategy

### Phase 1: Foundation Agents
1. Update all foundation agents (researcher, patterns, principles, critic, context, conflicts)
2. Standardize negative trigger format
3. Add validation checklists
4. Cross-reference with existing boundary documentation

### Phase 2: Specialist Agents  
1. Update all specialist agents with appropriate negative triggers
2. Ensure consistency with foundation agent patterns
3. Add technology-specific exclusions
4. Validate against actual usage patterns

### Phase 3: Validation and Testing
1. Test negative triggers against known inappropriate use cases
2. Validate reduction in agent misselection
3. Gather feedback on selection accuracy improvements
4. Refine triggers based on actual usage data

## Success Metrics

### Quantitative Goals
- 80% reduction in inappropriate agent selections
- Faster initial agent selection (reduced trial-and-error)
- Improved agent combination success rates
- Fewer agent coordination conflicts

### Qualitative Goals
- Clearer agent boundaries and responsibilities
- Better alignment between capabilities and tasks
- Reduced user confusion about agent selection
- More predictable agent behavior and outcomes

## Maintenance Guidelines

### Regular Review Process
- Monthly review of negative trigger effectiveness
- Quarterly updates based on new usage patterns
- Annual comprehensive review of all agent boundaries
- Continuous monitoring of selection accuracy metrics

### Update Criteria
- New anti-patterns discovered through usage
- Technology stack changes affecting agent capabilities
- Workflow evolution requiring boundary adjustments
- User feedback indicating selection confusion

## Documentation Standards

### Consistency Requirements
- All agents must have negative trigger sections
- Format must be standardized across all agents
- Validation checklists must be present
- Alternative suggestions must be provided

### Clarity Guidelines
- Use specific pattern examples, not vague descriptions
- Provide clear reasoning for each exclusion
- Include actionable alternatives for excluded scenarios
- Maintain consistency with positive trigger language