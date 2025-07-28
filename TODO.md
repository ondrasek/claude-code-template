# TODO: Agent Parallelism Optimization

## Overview
After discovering that Claude Code has built-in agent parallelism capabilities, we need to optimize our agent architecture to better leverage these native features rather than building our own coordination layer.

## High Priority Tasks

### 1. Document Natural Parallel Agent Clusters
**Status**: Pending
**Description**: Create clear documentation of which agent combinations work best in parallel

**Recommended Parallel Clusters**:
```
Analysis Cluster (Fully Parallel):
- researcher (web research) + patterns (code analysis) + principles (design analysis) + completer (gap analysis)

Validation Cluster (Parallel with Smart Merging):
- critic (challenge findings) + constraints (check feasibility) + explorer (generate alternatives)

Specialized Combinations:
- Architecture decisions: explorer + constraints + principles + researcher
- Code quality: patterns + principles + completer + whisper
- Documentation: docs + researcher (for external references)
```

### 2. Remove Artificial Sequential Dependencies
**Status**: Pending
**Description**: Identify and eliminate unnecessary sequential chains where agents could run in parallel

**Current Issues**:
- Individual `critic` calls in agent definitions create sequential bottlenecks
- Linear "flow" descriptions prevent parallel thinking
- Excessive self-criticism dependencies create artificial delays

**Proposed Changes**:
- Replace sequential `critic` calls with batch validation
- Cluster independent analysis agents together
- Enable parallel self-criticism sessions

## Medium Priority Tasks

### 3. Create Workflow Templates for Native Parallel Execution
**Status**: Pending
**Description**: Design standardized workflow patterns that leverage Claude Code's built-in parallelism

**Template Examples**:
```
Standard Request Pattern:
Phase 1 (Parallel): researcher + patterns + principles + completer
Phase 2 (Validation): critic validates all findings simultaneously
Phase 3 (Implementation): docs + whisper (with conflict resolution)

Complex Analysis Pattern:
Phase 1 (Parallel): researcher + explorer + constraints + patterns + principles
Phase 2 (Parallel): completer + hypothesis + invariants
Phase 3 (Synthesis): resolver + critic
Phase 4 (Cleanup): docs + whisper
```

### 4. Update Agent Usage Instructions
**Status**: Pending
**Description**: Revise CLAUDE.md and agent-usage.md to reflect parallel execution best practices

**Changes Needed**:
- Update "Automatic Agent Invocation" section with parallel cluster guidance
- Replace sequential workflow descriptions with parallel cluster patterns
- Add performance hints for different agent combinations
- Document resource coordination for file-modifying agents

## Agent Refactoring Prerequisites

### Before Refactoring Agent Roles:
1. **Audit Current Dependencies**: Map which agents truly depend on others vs. artificial sequential patterns
2. **Resource Conflict Analysis**: Identify agents that might conflict when modifying the same files
3. **Performance Characteristics**: Document which agents are CPU vs I/O bound for better scheduling

### Refactoring Considerations:
- **Maintain Agent Independence**: Keep agents as self-contained units
- **Minimize Cross-Dependencies**: Reduce Task tool usage between agents
- **Standardize Output Formats**: Ensure parallel results can be easily merged
- **Add Execution Hints**: Include metadata about parallel execution compatibility

## Architecture Principles for Parallel Agent Design

### Do:
- Design agents as pure functions with clear inputs/outputs
- Minimize shared state between agents
- Create composable workflows that work well in parallel
- Use batch operations within agents (like researcher's WebSearch batching)

### Don't:
- Create tight coupling between agent implementations
- Use sequential Task tool chains where parallel execution is possible
- Design workflows that require strict ordering when not necessary
- Implement custom coordination when Claude Code provides native parallelism

## Success Metrics

### How to Measure Improvement:
- **Reduced Execution Time**: Parallel agent clusters should complete faster than sequential chains
- **Better Resource Utilization**: Agents should run concurrently without conflicts
- **Clearer Workflows**: Users should understand which agents work well together
- **Fewer Dependencies**: Reduced artificial sequential bottlenecks

## Next Steps

1. **Complete agent role refactoring** (current focus)
2. **Implement parallel cluster documentation**
3. **Update workflow templates and instructions**
4. **Test and validate parallel execution patterns**
5. **Create performance benchmarks for different agent combinations**

# Add few more aliases and environment variables

1. Add ANTHROPIC_LOG=debug
2. Enable verbose mode by default
3. Add any additional MCP-related logging for troubleshooting
4. Add Claude Code command to analyze Claude Code logs for errors and issues

# Add commands for analyzing code-base and proposing new agents optimized for this codebase

Add a command, that...

1. Command would trigger existing agents to analyze codebase and use the analysis to design AI-optimized, efficient, targeted and specific Claude Code sub-agents for this specific codebase.
2. Propose sub-agent definitions and store them in the .claude/agents folder.
3. Remove existing generic sub-agents if there is an overlap and keep the new, specific ones.
4. Document these changes in CHANGELOG.md.
5. This can be one command or multiple commands, whichever is better.

---

*Note: This TODO focuses on optimizing for Claude Code's native parallelism capabilities rather than building custom coordination infrastructure.*