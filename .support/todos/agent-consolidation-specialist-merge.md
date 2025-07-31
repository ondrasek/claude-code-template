---
status: pending
type: refactor
priority: high
assignee: foundation-patterns
created: 2025-01-31
---

# Agent Consolidation - Specialist Merge

## Description
Consolidate overlapping specialist agents to reduce redundancy and improve efficiency. Merge functionally similar agents that have been identified during comprehensive agent analysis.

## Acceptance Criteria
- [ ] Merge specialist-whisper and specialist-completer into unified specialist-code-assistant
- [ ] Combine specialist-hypothesis and specialist-testing into specialist-validation
- [ ] Consolidate specialist-constraints and specialist-guidelines-* agents into specialist-standards
- [ ] Merge specialist-explorer and specialist-context into specialist-analysis
- [ ] Reduce total specialist agent count by 40-50%
- [ ] Preserve all critical capabilities during consolidation
- [ ] Update CLAUDE.md agent coordination patterns for consolidated agents
- [ ] Test consolidated agents maintain equivalent functionality

## Notes
Consolidation should focus on agents with >70% functional overlap. Priority order:
1. Code-focused agents (whisper + completer)
2. Analysis agents (hypothesis + testing) 
3. Standards agents (constraints + guidelines)
4. Context agents (explorer + context)

Reference comprehensive agent analysis findings for detailed overlap assessment.