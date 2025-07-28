---
status: pending
type: refactor
priority: high
assignee: patterns
created: 2025-07-28
---

# Clarify Agent Boundaries and Overlaps

## Description
Define clear boundaries between overlapping agents to reduce redundancy and improve selection efficiency. Many agents currently have overlapping responsibilities which can lead to confusion in selection and suboptimal coordination.

## Acceptance Criteria
- [ ] Audit all agent definitions in `.claude/agents/` for overlapping responsibilities
- [ ] Identify specific areas of overlap between similar agents
- [ ] Define clear primary responsibilities for each agent
- [ ] Establish secondary/supporting roles where overlap is beneficial
- [ ] Create decision criteria for choosing between overlapping agents
- [ ] Update agent descriptions to clarify unique value propositions
- [ ] Document when to use multiple overlapping agents vs single agent
- [ ] Add explicit "not responsible for" sections to agent definitions

## Implementation Details

### Key Overlaps to Address:
- **researcher vs context**: Both gather information but different scopes
- **patterns vs principles**: Both analyze code structure but different focuses
- **explorer vs researcher**: Both investigate but different methodologies
- **critic vs principles**: Both evaluate quality but different criteria
- **completer vs patterns**: Both ensure completeness but different approaches

### Boundary Definition Strategy:
1. **Primary Responsibility**: What this agent does better than any other
2. **Secondary Support**: Where this agent assists other agents
3. **Collaboration Points**: How this agent works with overlapping agents
4. **Exclusion Zones**: What this agent should NOT handle
5. **Escalation Triggers**: When to hand off to overlapping agents

### Documentation Updates Required:
- Agent definition files in `.claude/agents/`
- CLAUDE.md agent combination patterns
- Selection criteria documentation
- Troubleshooting guides for agent conflicts

## Success Metrics
- Reduced confusion in agent selection decisions
- Faster selection times due to clearer boundaries
- Improved coordination between related agents
- Elimination of redundant work across agent combinations
- Higher success rates in multi-agent collaborations

## Notes
This task is critical for the overall agent audit success. Clear boundaries will improve both automatic agent selection and manual agent coordination. Focus on defining complementary rather than competing relationships between overlapping agents.

## Dependencies
- Requires completion of agent selection frequency monitoring for data-driven boundary decisions
- Should coordinate with agent combination pattern documentation for consistent messaging