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
- [ ] Remove specialist-whisper (capabilities fully covered by foundation-patterns)
- [ ] Merge specialist-axioms + specialist-invariants → specialist-system-logic
- [ ] Merge specialist-git-tagger + specialist-git-troubleshooter → specialist-git-manager
- [ ] Merge specialist-guidelines-file + specialist-guidelines-repo → specialist-guidelines
- [ ] Reduce total agent count from 24 to ~19 agents (20% reduction)
- [ ] Preserve all critical capabilities during consolidation
- [ ] Update CLAUDE.md agent coordination patterns for consolidated agents
- [ ] Test consolidated agents maintain equivalent functionality

## Notes
Consolidation based on evidence-based redundancy analysis. Priority order:
1. Remove specialist-whisper (100% overlap with foundation-patterns)
2. Merge system logic agents (axioms + invariants - both handle "fundamental truths")
3. Merge git agents (tagger + troubleshooter - same domain)
4. Merge guideline agents (file + repo - same technology detection logic)

NO NEW AGENTS CREATED. Focus on reduction and consolidation only.
Reference comprehensive agent analysis findings for detailed overlap assessment.