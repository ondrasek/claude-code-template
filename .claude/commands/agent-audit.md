# /agent-audit

Audit existing agents against creation principles and usage metrics for optimization opportunities.

## Usage
```
/agent-audit [--detailed] [agent-name...]
```

## What it does
- Analyzes agent descriptions against selection optimization patterns
- Identifies agents with low-performing description patterns
- Checks for redundancy and overlap between agents
- Suggests description improvements using Tier 1 keywords
- Generates agent utilization and effectiveness report

## Audit Criteria

### Description Quality Assessment
1. **Selection keyword analysis**: Presence of Tier 1/2 keywords
2. **Trigger specificity**: Concrete user context scenarios
3. **Boundary clarity**: Clear capability definitions
4. **Redundancy check**: Overlap with other agent descriptions

### Performance Indicators
1. **Selection frequency**: How often Claude Code invokes the agent
2. **Context efficiency**: Lines of output generated vs. main context pollution
3. **Boundary respect**: Amount of back-and-forth with main context
4. **Output quality**: Structured, actionable results without clarification needs

## Audit Output Format

```
## Agent Audit Report

**Agent**: [agent-name]
**Description Quality**: ⭐⭐⭐⚪⚪ (3/5)
**Selection Keywords**: Missing Tier 1 keywords
**Trigger Specificity**: Generic - needs quoted user phrases
**Boundary Clarity**: Well-defined
**Redundancy Risk**: Low overlap with other agents

### Optimization Recommendations:
1. Add "PROACTIVELY" keyword to description
2. Include quoted trigger phrases like "why does this happen"
3. Specify exact contexts when agent should be invoked

### Suggested Description:
```yaml
description: "PROACTIVELY use when user asks 'why does this happen', 'strange behavior', or debugging unexpected results. Expert at systematic hypothesis formation and testing"
```
```

## Red Flag Detection

**Flags agents for review/elimination:**
- Missing Tier 1 or Tier 2 selection keywords
- Generic descriptions without specific triggers
- Significant overlap with other agent capabilities
- Poor boundary definition requiring main context clarification

## Batch Analysis

**Options:**
- `--detailed`: Include full analysis and recommendations for each agent
- `agent-name...`: Audit specific agents only
- No args: Audit all agents in `.claude/agents/` directory

## Integration with Creation Principles

Uses validation framework from @.support/instructions/agent-creation.md:
- Overhead justification analysis
- Context boundary assessment  
- Selection optimization evaluation
- Human role detection

## Related Commands
- `/agent-create` - Create new agents following principles
- `/agent-guide` - Documentation on using existing agents

## Reference Documentation
- @.support/instructions/agent-creation.md - Complete creation and audit principles