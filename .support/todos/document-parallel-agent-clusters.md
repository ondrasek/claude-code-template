---
status: completed
type: docs
priority: high
assignee: docs
created: 2025-01-28
impact: patch
---

# Document Natural Parallel Agent Clusters

## Description
Create clear documentation of which agent combinations work best in parallel

## Context
After discovering that Claude Code has built-in agent parallelism capabilities, we need to optimize our agent architecture to better leverage these native features rather than building our own coordination layer.

## Acceptance Criteria
- [ ] Parallel cluster patterns documented in agent-usage.md
- [ ] Performance guidelines for agent combinations added
- [ ] Examples of recommended parallel workflows provided
- [ ] Resource conflict resolution documented

## Recommended Parallel Clusters

### Analysis Cluster (Fully Parallel)
- researcher (web research) + patterns (code analysis) + principles (design analysis) + completer (gap analysis)

### Validation Cluster (Parallel with Smart Merging)
- critic (challenge findings) + constraints (check feasibility) + explorer (generate alternatives)

### Specialized Combinations
- Architecture decisions: explorer + constraints + principles + researcher
- Code quality: patterns + principles + completer + whisper
- Documentation: docs + researcher (for external references)

## Notes
Focus on optimizing for Claude Code's native parallelism capabilities rather than building custom coordination infrastructure.