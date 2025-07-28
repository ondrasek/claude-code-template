---
status: pending
type: docs
priority: high
assignee: docs
created: 2025-07-28
---

# Document Agent Combination Patterns

## Description
Create comprehensive documentation of proven agent combination patterns for different request types based on the CLAUDE.md protocol. This documentation will serve as a reference guide for optimal agent selection and coordination strategies.

## Acceptance Criteria
- [ ] Document all 7 agent combination patterns from CLAUDE.md protocol
- [ ] Provide detailed flow descriptions for each pattern (Research → Pattern → Apply → Validate)
- [ ] Include specific trigger phrases and request types for each combination
- [ ] Add examples of successful implementations for each pattern
- [ ] Create decision tree for pattern selection based on user requests
- [ ] Document parallel execution strategies for agent clusters
- [ ] Include performance metrics and success indicators for each pattern
- [ ] Add troubleshooting guide for pattern failures or suboptimal results

## Implementation Details

### Patterns to Document:
1. **Analysis Requests**: researcher + patterns + principles + critic
2. **Architecture/Design**: researcher + explorer + constraints + principles + critic
3. **Debugging Investigations**: researcher + hypothesis + patterns + critic
4. **Code Quality Tasks**: patterns + principles + whisper + critic
5. **Feature Implementation**: researcher + patterns + completer + docs
6. **Decision Making**: explorer + constraints + resolver + critic
7. **System Understanding**: context + patterns + researcher + critic

### Documentation Structure:
- Pattern name and primary use cases
- Trigger phrase detection logic
- Agent flow sequence and coordination
- Parallel execution opportunities
- Success metrics and validation criteria
- Common failure modes and mitigation strategies

## Success Metrics
- Clear mapping of request types to optimal agent combinations
- Reduced trial-and-error in agent selection
- Improved consistency in multi-agent coordination
- Faster resolution times for complex requests
- Higher success rates for agent combination executions

## Notes
This documentation should be referenced by the main Claude Code system to automatically select appropriate agent combinations based on user request patterns. The patterns should be treated as proven templates that can be instantiated with specific context while maintaining the proven coordination flow.