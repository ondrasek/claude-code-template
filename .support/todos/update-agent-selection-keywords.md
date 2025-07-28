---
status: pending
type: feat
priority: high
assignee: generator
created: 2025-07-28
impact: minor
dependencies: []
---

# Update Agent Selection Keywords - Phase 1

## Description
Optimize agent descriptions for 12 agents lacking Tier 1 keywords to improve selection rates by adding "PROACTIVELY", "MUST USE", or similar directive language.

## Context
Agent audit revealed that agents without strong selection keywords are being underutilized. Phase 1 focuses on the most critical agents: todo, researcher (already optimized), and connector, plus 9 additional agents needing keyword optimization.

## Priority Agents for Phase 1

### High Priority (Week 1)
1. **todo agent** - Add "PROACTIVELY" keyword to description
   - Current: "Use when user asks to 'create TODO', 'track task', 'add to TODO list'..."
   - Needs: "PROACTIVELY use for task management, TODO creation, deferred actions..."

2. **connector agent** - Add "MUST USE" keyword for creative problem solving
   - Current: "Use when stuck on problems, user asks 'think outside the box'..."
   - Needs: "MUST USE when stuck on problems, creative solutions needed..."

3. **completer agent** - Add selection optimization keywords
   - Needs analysis and keyword integration for gap detection tasks

### Medium Priority Agents (9 remaining)
4. **context agent** - System understanding tasks
5. **explorer agent** - Option generation and alternatives  
6. **constraints agent** - Limitation handling and requirements
7. **resolver agent** - Conflict resolution and decision making
8. **whisper agent** - Code improvement and optimization
9. **patterns agent** - Pattern detection and analysis
10. **principles agent** - Best practice application
11. **critic agent** - Quality assessment and validation
12. **hypothesis agent** - Theory formation and testing

## Specific Optimization Strategy

### Keyword Integration Approach
- **"PROACTIVELY"**: For agents that should be used without explicit user request
- **"MUST USE"**: For agents critical to specific task types
- **"AUTOMATICALLY"**: For agents that should trigger on specific patterns
- **"ALWAYS"**: For agents that should be default choices

### Description Enhancement Pattern
```
Current: "Use when [condition]"
Enhanced: "PROACTIVELY use when [condition], MUST USE for [specific scenarios]"
```

## Implementation Plan

### Week 1 Tasks
- [ ] Update todo agent description with "PROACTIVELY" keyword
- [ ] Update connector agent description with "MUST USE" keyword  
- [ ] Analyze completer agent usage patterns and optimize description
- [ ] Test updated descriptions with sample queries
- [ ] Measure selection rate improvements

### Success Metrics
- [ ] All 3 priority agents updated with Tier 1 keywords
- [ ] Descriptions maintain clarity while improving selection
- [ ] Testing shows improved agent selection rates
- [ ] No degradation in agent functionality or clarity

## Acceptance Criteria
- [ ] todo agent description updated with selection keywords
- [ ] connector agent description updated with directive language
- [ ] completer agent analyzed and optimized
- [ ] All changes maintain agent clarity and functionality
- [ ] Updated descriptions tested with representative queries
- [ ] Documentation updated to reflect new selection patterns

## Technical Requirements
- Preserve existing agent functionality and behavior
- Maintain description clarity and readability
- Follow established agent description format and structure
- Ensure keyword integration feels natural, not forced
- Test compatibility with agent selection algorithms

## Notes
This is Phase 1 of a 3-phase agent optimization project. Focus is on the most critical agents first, with todo and connector being highest priority due to their fundamental roles in task organization and creative problem solving.

The researcher agent already has optimal "PROACTIVELY" keyword usage and can serve as a template for other agent optimizations.

## Dependencies
None - this is an independent optimization task that can proceed immediately.

## Risk Assessment
**Low Risk**: Changes are purely descriptive and don't affect agent logic or behavior. Reversible if selection rates don't improve as expected.