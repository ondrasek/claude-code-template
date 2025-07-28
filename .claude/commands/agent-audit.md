# /agent-audit

Audit existing agents against creation principles and usage metrics for optimization opportunities.

## Usage
```
/agent-audit [--detailed] [agent-name...]
```

## What it does
- **Spawns individual agents**: Creates separate audit agents for each agent being evaluated
- **Parallel analysis**: Analyzes agent descriptions in isolated contexts for higher quality
- **Selection optimization**: Identifies low-performing description patterns using creation principles
- **Redundancy detection**: Checks for overlap between agents across separate analyses
- **Coordinated reporting**: Aggregates individual audits into comprehensive report

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

## Agent Spawning Strategy

**Individual Agent Analysis:**
- Each agent gets its own dedicated audit agent instance
- Isolated context prevents cross-contamination between evaluations
- Higher quality analysis through focused attention per agent
- Parallel execution for improved performance

**Aggregation Process:**
- Collect individual audit reports from each spawned agent
- Identify patterns across all agent evaluations
- Generate consolidated recommendations and priority actions
- Detect ecosystem-wide issues (redundancy, gaps, inconsistencies)

## Batch Analysis

**Options:**
- `--detailed`: Include full analysis and recommendations for each agent
- `agent-name...`: Audit specific agents only (spawns one agent per specified agent)
- No args: Audit all agents in `.claude/agents/` directory (spawns agent per discovered agent)

## Implementation Workflow

### Phase 1: Agent Discovery
```
1. Scan .claude/agents/ directory for all agent files
2. Parse agent names from command arguments (if provided)
3. Apply --detailed flag to audit scope
4. Prepare individual audit tasks for each agent
```

### Phase 2: Parallel Agent Spawning
```
For each agent to audit:
  Task: "Audit [agent-name] against creation principles" 
  Subagent: patterns (for description analysis and optimization)
  Context: Single agent file + creation principles
  Output: Individual audit report with ratings and recommendations
```

### Phase 3: Aggregation and Analysis
```
1. Collect all individual audit reports
2. Identify ecosystem patterns (redundancy, gaps, quality distribution)
3. Generate priority action list based on impact vs effort
4. Create consolidated recommendations for immediate fixes
```

### Phase 4: Reporting
```
- Executive summary with overall ecosystem health
- Individual agent scores and recommendations  
- Priority optimization actions ranked by impact
- Red flag agents requiring elimination/major revision
```

## Integration with Creation Principles

**Individual agent evaluation criteria** from @.support/instructions/agent-creation.md:
- **Overhead justification**: Does agent reduce >50 lines of main context?
- **Context boundaries**: Clear input/output without back-and-forth?
- **Selection optimization**: Tier 1/2 keywords for Claude Code selection?
- **Focus validation**: Computational tasks, thinking patterns, paradigms, perspectives vs human roles?

**Ecosystem-wide analysis:**
- **Redundancy detection**: Overlapping capabilities across agents
- **Gap identification**: Missing specialized analysis patterns
- **Quality distribution**: Spread of description optimization scores

## Related Commands
- `/agent-create` - Create new agents following principles
- `/agent-guide` - Documentation on using existing agents

## Reference Documentation
- @.support/instructions/agent-creation.md - Complete creation and audit principles