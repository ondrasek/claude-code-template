# TODO: Agent Parallelism Optimization

## Overview
After discovering that Claude Code has built-in agent parallelism capabilities, we need to optimize our agent architecture to better leverage these native features rather than building our own coordination layer.

## High Priority Tasks

### 1. Document Natural Parallel Agent Clusters
**Status**: pending
**Type**: docs
**SemVer Impact**: patch
**Assigned**: docs + researcher
**Dependencies**: None
**Description**: Create clear documentation of which agent combinations work best in parallel
**Acceptance Criteria**:
- [ ] Parallel cluster patterns documented in agent-usage.md
- [ ] Performance guidelines for agent combinations added
- [ ] Examples of recommended parallel workflows provided
- [ ] Resource conflict resolution documented

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
**Status**: pending
**Type**: refactor
**SemVer Impact**: patch
**Assigned**: patterns + principles
**Dependencies**: Task 1 completion
**Description**: Identify and eliminate unnecessary sequential chains where agents could run in parallel
**Acceptance Criteria**:
- [ ] Agent definitions reviewed for unnecessary sequential calls
- [ ] Batch validation patterns implemented
- [ ] Parallel cluster workflows enabled
- [ ] Performance improvements measured

**Current Issues**:
- Individual `critic` calls in agent definitions create sequential bottlenecks
- Linear "flow" descriptions prevent parallel thinking
- Excessive self-criticism dependencies create artificial delays

## Medium Priority Tasks

### 3. Create Workflow Templates for Native Parallel Execution
**Status**: pending
**Type**: feat
**SemVer Impact**: minor
**Assigned**: explorer + patterns
**Dependencies**: Tasks 1 and 2 completion
**Description**: Design standardized workflow patterns that leverage Claude Code's built-in parallelism
**Acceptance Criteria**:
- [ ] Standard workflow templates created
- [ ] Complex analysis patterns documented
- [ ] Template integration with existing commands
- [ ] Performance benchmarks established

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
**Status**: pending
**Type**: docs
**SemVer Impact**: patch
**Assigned**: docs
**Dependencies**: Tasks 1, 2, and 3 completion
**Description**: Revise CLAUDE.md and agent-usage.md to reflect parallel execution best practices
**Acceptance Criteria**:
- [ ] CLAUDE.md updated with parallel cluster guidance
- [ ] agent-usage.md updated with new workflow patterns
- [ ] Performance hints documented for agent combinations
- [ ] Resource coordination guidelines added

## Low Priority Tasks

### 5. Add Development Environment Enhancements
**Status**: pending
**Type**: feat
**SemVer Impact**: minor
**Assigned**: completer
**Dependencies**: None
**Description**: Add environment variables and aliases for better debugging and troubleshooting
**Acceptance Criteria**:
- [ ] ANTHROPIC_LOG=debug environment variable added
- [ ] Verbose mode enabled by default in development
- [ ] MCP-related logging enhancements implemented
- [ ] Claude Code log analysis command created

### 6. Create Codebase-Specific Agent Optimization System
**Status**: pending
**Type**: feat
**SemVer Impact**: minor
**Assigned**: generator + researcher + patterns
**Dependencies**: None
**Description**: Develop command system to analyze codebase and generate optimized, targeted agents
**Acceptance Criteria**:
- [ ] Codebase analysis command implemented
- [ ] Agent optimization algorithm created
- [ ] Automatic agent generation system built
- [ ] Generic agent replacement workflow established
- [ ] Changes properly documented in CHANGELOG.md

**Implementation Details**:
1. Command triggers existing agents to analyze codebase
2. Use analysis to design AI-optimized, efficient, targeted Claude Code sub-agents
3. Propose sub-agent definitions and store in .claude/agents folder
4. Remove existing generic sub-agents if overlap exists
5. Keep new, specific agents for better performance

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

## Completed Tasks (Archive)

*No completed tasks yet - will populate as tasks are finished*

---

*Note: This TODO focuses on optimizing for Claude Code's native parallelism capabilities rather than building custom coordination infrastructure. Completed tasks will be moved to CHANGELOG.md upon release.*