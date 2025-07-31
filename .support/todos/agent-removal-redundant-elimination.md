---
status: pending
type: chore
priority: high
assignee: foundation-criticism
created: 2025-01-31
---

# Agent Removal - Redundant Elimination

## Description
Remove agents identified as redundant or providing minimal unique value during comprehensive specialist agent review. Focus on agents with functionality completely covered by other agents.

## Acceptance Criteria
- [ ] Remove specialist-performance (covered by foundation-patterns + specialist-testing)
- [ ] Remove specialist-docs (documentation handled by foundation-patterns)
- [ ] Remove specialist-git-troubleshooter (basic git operations don't need specialized agent)
- [ ] Remove specialist-git-tagger (can be integrated into standard git workflow)
- [ ] Evaluate and potentially remove specialist-cleanup (one-time utility agent)
- [ ] Update all agent coordination patterns to remove references to eliminated agents
- [ ] Update CLAUDE.md parallel agent patterns to exclude removed agents
- [ ] Verify no critical functionality is lost through removal

## Notes
Removal priority based on:
1. Complete functional overlap with existing agents
2. Low utilization frequency
3. Single-purpose utility agents that can be integrated elsewhere
4. Agents that add complexity without proportional value

Conservative approach: Archive agents rather than delete to allow rollback if needed.