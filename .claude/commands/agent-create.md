# /agent-create

Guide for creating new Claude Code agents following empirical principles and selection optimization.

## Usage
```
/agent-create [agent-name]
```

## What it does
- Validates agent necessity using decision framework from @.support/instructions/agent-creation.md
- Checks for redundancy with existing agents
- Guides agent specification with proven description patterns
- Generates optimized agent descriptions with Tier 1 selection keywords
- Creates agent file with proper frontmatter and structure

## Agent Creation Workflow

### Phase 1: Necessity Validation
1. **Complexity justification**: Verify task generates >50 lines of intermediate output
2. **Boundary analysis**: Confirm clear input/output boundaries exist  
3. **Reuse assessment**: Check if pattern applies to >3 different contexts
4. **Redundancy check**: Compare against existing agent capabilities

### Phase 2: Description Optimization
1. **Keyword integration**: Include Tier 1 keywords (PROACTIVELY, MUST USE)
2. **Trigger specification**: Add quoted user phrases for context matching
3. **Boundary definition**: Clearly state what agent does/doesn't handle
4. **Selection testing**: Validate description against Claude Code selection patterns

### Phase 3: Agent Generation
1. **Create agent file** in `.claude/agents/` directory
2. **Generate YAML frontmatter** with optimized description
3. **Add agent body** following proven templates
4. **Document justification** for future audits

## Selection-Optimized Description Template

```yaml
---
name: [descriptive-name]
description: "[TIER1_KEYWORD] when [specific_user_context] or [quoted_user_phrases]. [Capability_boundary_statement]"
---
```

## Decision Checklist

Before creating an agent, verify ALL criteria:

- [ ] Task generates >50 lines of intermediate output in main context
- [ ] Process involves >3 tool calls with state management
- [ ] Same analysis pattern needed in >3 different contexts
- [ ] Input can be defined as specific parameters
- [ ] Output is structured and actionable without clarification
- [ ] Process doesn't require mid-execution guidance from main context
- [ ] Requires specialized prompting strategy not suitable for main context
- [ ] No existing agent covers this capability
- [ ] Not mirroring human organizational roles

## High-Priority Selection Keywords

**Tier 1 (Highest selection probability):**
- `PROACTIVELY`
- `MUST USE` 
- `automatically`
- `should be used when`
- `required for`

**Context matching examples:**
- `"why does this happen"`
- `"strange behavior"`
- `"what are my options"`
- `"is this SOLID"`

## Related Commands
- `/agent-audit` - Review existing agents against principles
- `/agent-guide` - Documentation on using existing agents

## Reference Documentation
- @.support/instructions/agent-creation.md - Complete creation principles
- @.support/instructions/agent-usage.md - Agent coordination patterns