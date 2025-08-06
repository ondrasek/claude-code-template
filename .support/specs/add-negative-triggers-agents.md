---
status: pending
type: feat
priority: medium
assignee: patterns
created: 2025-07-28
---

# Add Negative Triggers to Agent Descriptions

## Description
Implement negative triggers in agent descriptions to prevent inappropriate usage and improve selection accuracy. Currently, agents may be selected for tasks they're not well-suited for, leading to suboptimal results.

## Acceptance Criteria
- [ ] Add "Do Not Use For" sections to all agent definition files
- [ ] Define specific negative trigger phrases that should prevent agent selection
- [ ] Implement anti-patterns for each agent type
- [ ] Add context exclusion criteria to agent descriptions
- [ ] Create validation logic to check negative triggers before agent selection
- [ ] Document common misuse scenarios for each agent
- [ ] Add warnings for edge cases where agent selection might be questionable
- [ ] Test negative trigger effectiveness with known inappropriate use cases

## Implementation Details

### Negative Trigger Categories:
1. **Task Type Exclusions**: Specific types of requests this agent cannot handle
2. **Context Exclusions**: Situations where this agent is not appropriate
3. **Scale Exclusions**: Tasks too large/small for this agent's capabilities
4. **Technology Exclusions**: Domains outside this agent's expertise
5. **Timing Exclusions**: When in workflow this agent should not be used

### Agent-Specific Negative Triggers:

#### researcher Agent:
- Do not use for: Implementation tasks, code writing, real-time data
- Anti-patterns: "Write code for...", "Implement...", "Create new..."

#### patterns Agent:
- Do not use for: One-off solutions, novel algorithms, external research
- Anti-patterns: "Research new...", "Find external...", "Create unique..."

#### principles Agent:
- Do not use for: Quick hacks, temporary fixes, non-code tasks
- Anti-patterns: "Quick fix...", "Temporary...", "Just make it work..."

#### critic Agent:
- Do not use for: Initial creation, brainstorming, research
- Anti-patterns: "Create new...", "Generate ideas...", "Research options..."

### Implementation Strategy:
1. Update all agent definition files with negative trigger sections
2. Add validation logic to check triggers before agent selection
3. Create feedback mechanism when negative triggers are violated
4. Document rationale for each negative trigger
5. Test with historical inappropriate agent selections

## Success Metrics
- Reduced inappropriate agent selections by 80%
- Faster initial agent selection due to clearer exclusions
- Improved agent combination success rates
- Fewer agent coordination conflicts
- Better alignment between agent capabilities and task requirements

## Notes
Negative triggers should be specific enough to prevent misuse but not so restrictive that they eliminate valid use cases. Focus on clear anti-patterns rather than exhaustive exclusion lists. The goal is to guide selection, not create rigid barriers.

## Dependencies
- Should coordinate with agent boundary clarification task
- Requires testing against agent selection frequency data
- May need updates to agent combination pattern documentation