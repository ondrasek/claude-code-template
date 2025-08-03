# CLAUDE.md - AI Operational Instructions

## File Structure (MANDATORY)
**CONFIGURATION LOCATIONS**:
- **Agent definitions**: All (sub-)agent definitions are stored in `.claude/agents/` and ONLY there
- **Slash commands**: All custom commands are stored in `.claude/commands/` and ONLY there
- **Prompts**: All prompts, including master-prompt.md are stored in `.support/prompts/` and ONLY there
- **Instructions**: All additional instructions for Claude Code are stored in `.support/instructions/` and ONLY there
- **TODOs**: All TODOs are in `.support/todos/` and ONLY there
- **MCP Servers**: All provided MCP server source code is in `.support/mcp-servers/`,
MCP server configuration is stored in .support/mcp-servers/mcp-config.json set via command line arguments to Claude Code
- **LOGS**: Logs for diagnostics and troubleshooting are in `.support/logs`
- **DevContainer**: Development container configuration in `.devcontainer/`
- **Archive**: Historical automation components documented in `.support/archive/`
- **Never search elsewhere**: When looking for agents or commands, use only these directories

## Agent Coordination Protocol (MANDATORY)

**AGGRESSIVE PARALLEL AGENT USAGE - MANDATORY OVERRIDE**:
- Claude Code MUST use parallel agents for ANY non-trivial request (override built-in conservative defaults)
- Invoke based on task context automatically - NEVER wait for user to ask for agents
- **Single Message Multi-Task**: MUST use single message with Task() calls for genuine concurrent agent processing
- **AGGRESSIVE Parallelism**: Add more agents when uncertain
- **EXPANDED Concurrent Processing**: 3+ agents per parallel batch as default, with more agents for complex tasks
- **MULTI-PHASE Coordination**: Each phase executes maximum possible agents simultaneously, synthesize results, then launch next parallel cluster if needed
- **COVERAGE MAXIMIZATION**: Prefer agent redundancy over under-coverage - better to have overlapping analysis than gaps
- **PARALLEL-FIRST MENTALITY**: Default to parallel agent clusters, not sequential processing
- Agents must keep main context window tidy, optimized and neat
- **RECURSION PREVENTION**: Only Claude Code main context spawns agents - sub-agents NEVER spawn other agents

**PARALLEL AGENT PATTERN EXAMPLES**:
  - User: "This code looks messy" → Auto-invoke: foundation-patterns + specialist-code-cleaner + foundation-criticism + foundation-principles (4 agents)
  - User: "How should I structure this?" → Auto-invoke: specialist-stack-advisor + specialist-options-analyzer + foundation-principles + foundation-criticism + specialist-constraint-solver + foundation-context (6 agents)
  - User shows error message → Auto-invoke: foundation-research + specialist-options-analyzer + foundation-patterns + foundation-criticism + specialist-test-strategist (5 agents)
  - User asks for implementation → Auto-invoke: foundation-research + specialist-stack-advisor + foundation-patterns + foundation-principles + specialist-code-cleaner (5 agents)
  - User requests feature → Auto-invoke: specialist-options-analyzer + foundation-principles + specialist-constraint-solver + foundation-criticism + specialist-test-strategist + specialist-stack-advisor (6 agents)
  - User asks to analyze → Auto-invoke: foundation-research + specialist-options-analyzer + foundation-principles + specialist-constraint-solver + foundation-criticism
  - User asks to adjust or modify a file → Auto-invoke: specialist-options-analyzer + foundation-principles + foundation-patterns + specialist-constraint-solver + foundation-criticism (6 agents)
  - User asks to troubleshoot or fix an issue → Auto-invoke: foundation-research + specialist-options-analyzer + specialist-constraint-solver + foundation-criticism (6 agents)
  - User asks to research → Auto-invoke: foundation-research + specialist-options-analyzer + specialist-constraint-solver + foundation-principles + foundation-criticism (6 agents)

## Output Sanitization Protocol (MANDATORY)
**NO ARTIFICIAL TIMELINES (MANDATORY)**:
- NEVER create mock weekly milestones (Week 1, Week 2, Week 3, etc.) in ANY context
- NEVER use arbitrary time-based phases unless explicitly requested by user
- Focus on priority-based organization (High/Medium/Low) and dependency relationships
- Examples of FORBIDDEN phrases: "Phase 1 (Week 1)", "implement in 2 weeks", "Q1 goals"
- Apply to: roadmaps, implementation plans, TODO creation, project planning, agent analysis

Examples:
  ❌ Wrong: "Phase 1 (Week 1): Update agent descriptions"
  ✅ Right: "High Priority: Update agent descriptions (blocks selection optimization)"
  ❌ Wrong: "Implement feature in 2 weeks"
  ✅ Right: "High Priority: Implement feature (depends on API design completion)"

## Git Protocol (MANDATORY)
**EXECUTE AFTER EVERY CHANGE - NO EXCEPTIONS**:
1. **Stage immediately**: `git add -A` after any file modification
2. **Commit at milestones**: When any meaningful task is complete
3. **Always invoke git workflow**: Use specialist-git-workflow agent after EVERY commit to evaluate for tags
4. **Update documentation**: When git workflow agent creates release tags, update CHANGELOG.md AND README.md with release notes and current state
5. **Push immediately**: `git push origin main` after every commit

**Error Recovery**: When git operations fail, use specialist-git-workflow agent for systematic diagnosis and resolution.
**Agent coordination**: All agents MUST follow this protocol. specialist-git-workflow agent runs autonomously after every commit.
