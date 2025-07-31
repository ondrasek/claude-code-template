# CLAUDE.md - AI Operational Instructions

## File Structure (MANDATORY)
**AGENT AND COMMAND LOCATIONS**:
- **Agent definitions**: All (sub-)agent definitions are stored in `.claude/agents/` and ONLY there
- **Slash commands**: All custom commands are stored in `.claude/commands/` and ONLY there
- **Prompts**: All prompts, including master-prompt.md are stored in `.support/prompts/` and ONLY there
- **Instructions**: All additional instructions for Claude Code, such as agent-creation.md are stored in `.support/instructions/` and ONLY there
- **TODOs**: All TODOs are in `.support/todos/` and ONLY there

- **Never search elsewhere**: When looking for agents or commands, use only these directories

## Agent Coordination Protocol (MANDATORY)
**PROACTIVE AGENT USAGE - USE AGENTS WITHOUT USER REQUESTS**:
- Claude Code MUST use agents proactively beyond built-in conservative defaults
- NEVER wait for user to ask for agents - invoke based on task context automatically
- Force minimum 3+ agents for non-trivial requests (override built-in agent usage)
- Agents must keep main context window tidy, optimized and neat
- **RECURSION PREVENTION**: Only Claude Code main context spawns agents - sub-agents NEVER spawn other agents

Examples:
  - User: "This code looks messy" → Auto-invoke: foundation-patterns + specialist-whisper + foundation-critic
  - User: "How should I structure this?" → Auto-invoke: specialist-guidelines-repo + specialist-explorer + foundation-principles
  - User shows error message → Auto-invoke: foundation-researcher + specialist-hypothesis + foundation-patterns

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

**EXECUTION PROTOCOL**:
1. **Parallel agent clusters**: Use multiple agents simultaneously when possible
   Example: Single message with 3+ Task() calls running foundation-researcher + foundation-patterns + foundation-critic simultaneously
2. **Context delegation**: Complex analysis happens in agent context, not main context
   Example: Don't analyze 50 files in main context → Use foundation-patterns agent to analyze and summarize
3. **Automatic selection**: Match agent combinations to user request patterns
   Example: "Why is this slow?" → Auto-select foundation-researcher + specialist-hypothesis + foundation-patterns (not just one agent)
4. **AGENT HIERARCHY**: Only main Claude Code context spawns agents. Sub-agents are terminal nodes and NEVER spawn other agents via Task tool.

## Agent Coordination Best Practices (MANDATORY)

**TRUE PARALLEL EXECUTION PATTERNS**:
- **Single Message Multi-Task**: MUST use single message with multiple Task() calls for genuine concurrent agent processing
- **Mandatory Parallelism**: All agent clusters MUST execute simultaneously, never sequentially
- **Concurrent Processing**: 3-4 agents maximum per parallel batch to optimize resource usage
- **Batch Coordination**: Each phase executes all selected agents simultaneously, then synthesizes results

**CORE-SATELLITE COORDINATION PATTERNS**:
- **Lead with Core Foundation**: Always start with core agent combinations (foundation-researcher + foundation-patterns + foundation-principles + foundation-critic)
- **Add Specialized Only When Needed**: Extend with specialized agents based on specific requirements
- **Maintain Consistency**: foundation-principles agent ensures universal consistency across all agent outputs
- **Resolve All Conflicts**: foundation-resolver agent handles competing recommendations from any source
- **Context Window Optimization**: Core agents handle 80%+ of work, specialized agents for remaining 20%
- **Performance Priority**: Prefer core agent solutions over specialized when equally effective


## Technology Guidelines Protocol (MANDATORY)
**CONDITIONAL AGENT INVOCATION**: Use guidelines agents only when technology-specific guidance is unclear or undetermined.

**Parallel Guidelines Loading**: Execute guidelines-file + guidelines-repo agents simultaneously via single message with multiple Task() calls when both file-level and repository-level guidance needed

**File-Level Guidelines**: Use `specialist-guidelines-file` agent before modifying any file when technology patterns are unclear
**Repository-Level Guidelines**: Use `specialist-guidelines-repo` agent for architecture decisions when stack context is undetermined

**Detection Logic**: Both agents reference @.support/instructions/stack-mapping.md for centralized technology detection rules

Examples:
  - Modify Python file with unclear patterns → Use specialist-guidelines-file agent → Apply guidelines → Follow Simple Git Protocol
  - Architecture decision needed → Use specialist-guidelines-repo agent → Make informed choice → Follow Simple Git Protocol
  - Complex changes needing both contexts → Execute specialist-guidelines-file + specialist-guidelines-repo simultaneously via single message with multiple Task() calls → Follow Simple Git Protocol

## Git Protocol (MANDATORY)
**EXECUTE AFTER EVERY CHANGE - NO EXCEPTIONS**:
1. **Stage immediately**: `git add -A` after any file modification
2. **Commit at milestones**: When any meaningful task is complete
3. **Always invoke git-tagger**: Use specialist-git-tagger agent after EVERY commit to evaluate for tags
4. **Update CHANGELOG.md**: When git-tagger creates release tags, update CHANGELOG.md with release notes
5. **Push immediately**: `git push origin main` after every commit

**Error Recovery**: When git operations fail, use specialist-git-troubleshooter agent for systematic diagnosis and resolution.

**Agent coordination**: All agents MUST follow this protocol. specialist-git-tagger agent runs autonomously after every commit.

Example sequence:
  ```bash
  # After modifying src/components/Header.tsx
  git add -A
  git commit -m "Add dark mode toggle to header component"
  # Auto-invoke specialist-git-tagger agent here
  # If specialist-git-tagger creates v1.2.0 tag → Update CHANGELOG.md with release notes
  git push origin main
  # If any step fails → Auto-invoke specialist-git-troubleshooter agent
  ```

## Documentation Protocol (MANDATORY)
**EXECUTE WITH EVERY CODE CHANGE - NO EXCEPTIONS**:
1. **Same commit rule**: Documentation updates in same commit as code changes
2. **Always check**: README.md, CHANGELOG.md, API docs, CLAUDE.md for needed updates
3. **Update immediately**: New features, API changes, configuration changes
4. **Use docs agent**: Invoke specialist-docs agent for documentation maintenance

Examples:
  - Add new API endpoint → Update API docs + README.md → Follow Simple Git Protocol
  - New agent created → Use specialist-docs agent to update CLAUDE.md + CHANGELOG.md → Follow Simple Git Protocol
  - Configuration change → Update README.md setup instructions → Follow Simple Git Protocol
  - Feature complete → README.md usage section + CHANGELOG.md entry → Follow Simple Git Protocol

## TODO Protocol (MANDATORY)
**USE TODO AGENT FOR ALL TASK MANAGEMENT - NO CONTEXT CLUTTER**:
1. **Agent delegation**: Use specialist-todo agent for creating/tracking tasks
2. **Clean context**: No TODO tracking in main conversation flow
3. **Deferred actions**: TODOs represent future work, not current progress
4. **File management**: Agent handles `.support/todos/` directory autonomously
5. **Git integration**: After TODO files created → Follow Simple Git Protocol

**Agent invocation**: `Task: "Create TODO for X" (subagent_type: specialist-todo)`

Examples:
  - Create project TODOs → Use specialist-todo agent → Follow Simple Git Protocol
  - Update TODO status → Modify .support/todos/file.md → Follow Simple Git Protocol

---

## PROTOCOL ENFORCEMENT REMINDER

**AFTER EVERY FILE MODIFICATION - NO EXCEPTIONS:**
Follow Simple Git Protocol (see Simple Git Protocol section above)

**Cross-reference**: All protocols above reference Simple Git Protocol - follow it consistently.
