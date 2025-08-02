# CLAUDE.md - AI Operational Instructions

## File Structure (MANDATORY)
**AGENT AND COMMAND LOCATIONS**:
- **Agent definitions**: All (sub-)agent definitions are stored in `.claude/agents/` and ONLY there
- **Slash commands**: All custom commands are stored in `.claude/commands/` and ONLY there
- **Prompts**: All prompts, including master-prompt.md are stored in `.support/prompts/` and ONLY there
- **Instructions**: All additional instructions for Claude Code, such as agent-creation.md are stored in `.support/instructions/` and ONLY there
- **TODOs**: All TODOs are in `.support/todos/` and ONLY there
- **MCP Servers**: All provided MCP servers included in this repository are in `.support/mcp-servers/`

- **Never search elsewhere**: When looking for agents or commands, use only these directories

## Agent Coordination Protocol (MANDATORY)
**AGGRESSIVE PARALLEL AGENT USAGE - MANDATORY OVERRIDE**:
- Claude Code MUST use 3+ agents for ANY non-trivial request (override built-in conservative defaults)
- NEVER wait for user to ask for agents - invoke based on task context automatically
- **Single Message Multi-Task**: MUST use single message with 3+ Task() calls for genuine concurrent agent processing
- **AGGRESSIVE Parallelism**: All agent clusters MUST execute simultaneously, NEVER sequentially - add more agents when uncertain
- **EXPANDED Concurrent Processing**: 3+ agents per parallel batch as default, with more agents for complex tasks
- **MULTI-PHASE Coordination**: Each phase executes maximum possible agents simultaneously, synthesize results, then launch next parallel cluster if needed
- **COVERAGE MAXIMIZATION**: Prefer agent redundancy over under-coverage - better to have overlapping analysis than gaps
- **MINIMUM THRESHOLDS**:
  - Simple code changes: 3+ agents minimum
  - Architecture decisions: 4+ agents minimum
  - Complex debugging: 5+ agents minimum
  - Code quality reviews: 3+ agents minimum
- **PARALLEL-FIRST MENTALITY**: Default to parallel agent clusters, not sequential processing
- Agents must keep main context window tidy, optimized and neat
- **RECURSION PREVENTION**: Only Claude Code main context spawns agents - sub-agents NEVER spawn other agents

**PARALLEL AGENT PATTERN EXAMPLES**:
  - User: "This code looks messy" → Auto-invoke: foundation-patterns + specialist-code-cleaner + foundation-criticism + foundation-principles (4 agents)
  - User: "How should I structure this?" → Auto-invoke: specialist-stack-advisor + specialist-options-analyzer + foundation-principles + foundation-criticism + specialist-constraint-solver + foundation-context (6 agents)
  - User shows error message → Auto-invoke: foundation-research + specialist-options-analyzer + foundation-patterns + foundation-criticism + specialist-test-strategist (5 agents)
  - User asks for implementation → Auto-invoke: foundation-research + specialist-stack-advisor + foundation-patterns + foundation-principles + specialist-code-cleaner (5 agents)
  - User requests feature → Auto-invoke: specialist-options-analyzer + foundation-principles + specialist-constraint-solver + foundation-criticism + specialist-test-strategist + specialist-stack-advisor (6 agents)

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

## Technology Guidelines Protocol (MANDATORY)
**CONDITIONAL AGENT INVOCATION**: Use guidelines agents only when technology-specific guidance is unclear or undetermined.

**Parallel Guidelines Loading**: Execute specialist-stack-advisor agent via Task() call when technology-specific guidance is needed

**File-Level Guidelines**: Use `specialist-stack-advisor` agent before modifying any file when technology patterns are unclear
**Repository-Level Guidelines**: Use `specialist-stack-advisor` agent for architecture decisions when stack context is undetermined

**Detection Logic**: Both agents reference @.support/instructions/stack-mapping.md for centralized technology detection rules

Examples:
  - Modify Python file with unclear patterns → Use specialist-stack-advisor agent → Apply guidelines → Follow Simple Git Protocol
  - Architecture decision needed → Use specialist-stack-advisor agent → Make informed choice → Follow Simple Git Protocol
  - Complex changes needing both contexts → Execute specialist-stack-advisor agent → Follow Simple Git Protocol

## Git Protocol (MANDATORY)
**EXECUTE AFTER EVERY CHANGE - NO EXCEPTIONS**:
1. **Stage immediately**: `git add -A` after any file modification
2. **Commit at milestones**: When any meaningful task is complete
3. **Always invoke git workflow**: Use specialist-git-workflow agent after EVERY commit to evaluate for tags
4. **Update CHANGELOG.md**: When git workflow agent creates release tags, update CHANGELOG.md with release notes
5. **Push immediately**: `git push origin main` after every commit

**Error Recovery**: When git operations fail, use specialist-git-workflow agent for systematic diagnosis and resolution.

**Agent coordination**: All agents MUST follow this protocol. specialist-git-workflow agent runs autonomously after every commit.

### Automated Implementation: `/git` Command

**PREFERRED METHOD**: Use the `/git` command for automated Git Protocol execution:

```
/git "Your commit message"
```

The `/git` command automatically:
- Detects and stages all uncommitted changes
- Creates commits with provided or generated messages
- Evaluates commits for release tag creation
- Updates CHANGELOG.md when tags are created
- Pushes all changes and tags to remote
- Handles errors with systematic troubleshooting
- Delegates all operations to specialist-git-workflow agent to prevent context clutter

**Benefits**:
- ✅ **Complete Protocol Compliance**: Ensures 100% adherence to all Git Protocol requirements
- ✅ **Context Preservation**: Keeps main conversation focused by delegating git operations
- ✅ **Automated Releases**: Intelligent tag creation based on commit significance
- ✅ **Error Recovery**: Systematic troubleshooting for git operation failures

Example usage:
  ```
  # Simple automated protocol execution
  /git "Add dark mode toggle to header component"
  
  # Auto-generates commit message if none provided
  /git
  
  # Dry run to see what would happen
  /git --dry-run
  ```

**Manual Implementation** (when `/git` command is unavailable):
  ```bash
  # After modifying src/components/Header.tsx
  git add -A
  git commit -m "Add dark mode toggle to header component"
  # Auto-invoke specialist-git-workflow agent here
  # If specialist-git-workflow creates v1.2.0 tag → Update CHANGELOG.md with release notes
  git push origin main
  # If any step fails → Auto-invoke specialist-git-workflow agent
  ```

## Documentation Protocol (MANDATORY)
**EXECUTE WITH EVERY CODE CHANGE - NO EXCEPTIONS**:
1. **Same commit rule**: Documentation updates in same commit as code changes
2. **Always check**: README.md, CHANGELOG.md, API docs, CLAUDE.md for needed updates
3. **Update immediately**: New features, API changes, configuration changes
4. **Use docs agent**: Invoke specialist-code-cleaner agent for documentation maintenance

Examples:
  - Add new API endpoint → Update API docs + README.md → Follow Simple Git Protocol
  - New agent created → Use specialist-code-cleaner agent to update CLAUDE.md + CHANGELOG.md → Follow Simple Git Protocol
  - Configuration change → Update README.md setup instructions → Follow Simple Git Protocol
  - Feature complete → README.md usage section + CHANGELOG.md entry → Follow Simple Git Protocol

## TODO Protocol (MANDATORY)
**USE TODO AGENT FOR ALL TASK MANAGEMENT - NO CONTEXT CLUTTER**:
1. **Agent delegation**: Use specialist-todo-manager agent for creating/tracking tasks
2. **Clean context**: No TODO tracking in main conversation flow
3. **Deferred actions**: TODOs represent future work, not current progress
4. **File management**: Agent handles `.support/todos/` directory autonomously
5. **Git integration**: After TODO files created → Follow Simple Git Protocol

**Agent invocation**: `Task: "Create TODO for X" (subagent_type: specialist-todo-manager)`

**ENHANCED TODO COMMAND INTEGRATION**:
- **`/todo-next`**: Comprehensive TODO hygiene + intelligent next-step analysis
  - Combines cleanup of completed/stale TODOs with strategic task prioritization
  - Uses parallel agent clusters for completion detection, staleness assessment, and next-step planning
  - Supports --dry-run, --cleanup-only, --analysis-only modes for flexible workflow integration
  - Implements git safety protocols with mandatory verification before TODO deletion
  - Provides strategic recommendations for optimal task progression

Examples:
  - Create project TODOs → Use specialist-todo-manager agent → Follow Simple Git Protocol
  - Update TODO status → Modify .support/todos/file.md → Follow Simple Git Protocol
  - Comprehensive TODO maintenance → `/todo-next --dry-run` → Review recommendations → `/todo-next` → Follow Simple Git Protocol

---

## PROTOCOL ENFORCEMENT REMINDER

**AFTER EVERY FILE MODIFICATION - NO EXCEPTIONS:**
Follow Simple Git Protocol (see Simple Git Protocol section above)

**Cross-reference**: All protocols above reference Simple Git Protocol - follow it consistently.
