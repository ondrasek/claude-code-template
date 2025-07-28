# CLAUDE.md - AI Operational Instructions

## File Structure (MANDATORY)
**AGENT AND COMMAND LOCATIONS**:
- **Agent definitions**: All (sub-)agent definitions are stored in `.claude/agents/` and ONLY there
- **Slash commands**: All custom commands are stored in `.claude/commands/` and ONLY there
- **Never search elsewhere**: When looking for agents or commands, use only these directories

## Agent Coordination Protocol (MANDATORY)
**PROACTIVE AGENT USAGE - USE AGENTS WITHOUT USER REQUESTS**:
- Claude Code MUST use agents proactively beyond built-in conservative defaults
- NEVER wait for user to ask for agents - invoke based on task context automatically
- Force minimum 3+ agents for non-trivial requests (override built-in agent usage)
- Agents must keep main context window tidy, optimized and neat

Examples:
  - User: "This code looks messy" → Auto-invoke: patterns + whisper + critic
  - User: "How should I structure this?" → Auto-invoke: guidelines-repo + explorer + principles
  - User shows error message → Auto-invoke: researcher + hypothesis + patterns

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
1. **Memory-first research**: Check `mcp__memory__search_nodes()` before web searches
   Example: Before web searching "React best practices" → First check memory for previous React decisions
2. **Parallel agent clusters**: Use multiple agents simultaneously when possible
   Example: Single message with 3+ Task() calls running researcher + patterns + critic simultaneously  
3. **Context delegation**: Complex analysis happens in agent context, not main context
   Example: Don't analyze 50 files in main context → Use patterns agent to analyze and summarize
4. **Automatic selection**: Match agent combinations to user request patterns
   Example: "Why is this slow?" → Auto-select researcher + hypothesis + patterns (not just one agent)

## Agent Combination Patterns (MANDATORY)

**Analysis Requests** (`"analyze X"`, `"review Y"`, `"examine Z"`):
- **researcher** + **patterns** + **principles** + **critic**
- Flow: Research context → Find patterns → Apply principles → Critical evaluation

**Architecture/Design Questions** (`"design X"`, `"architect Y"`, `"structure Z"`):
- **researcher** + **explorer** + **constraints** + **principles** + **critic**  
- Flow: Research approaches → Generate alternatives → Handle constraints → Apply principles → Validate

**Debugging Investigations** (`"why does X"`, `"strange behavior"`, `"not working"`):
- **researcher** + **hypothesis** + **patterns** + **critic**
- Flow: Research known issues → Form theories → Find similar patterns → Validate solution

**Code Quality Tasks** (`"improve X"`, `"refactor Y"`, `"optimize Z"`):
- **patterns** + **principles** + **whisper** + **critic**
- Flow: Detect patterns → Apply principles → Make improvements → Critical review

**Feature Implementation** (`"add X"`, `"implement Y"`, `"create Z"`):
- **researcher** + **patterns** + **completer** + **docs**
- Flow: Research implementation → Check existing patterns → Ensure completeness → Update docs

**Decision Making** (`"options for X"`, `"approaches to Y"`, `"choose between Z"`):
- **explorer** + **constraints** + **resolver** + **critic**
- Flow: Generate alternatives → Handle constraints → Resolve conflicts → Critical assessment

**System Understanding** (`"how does X work"`, `"explain Y"`, `"show me Z"`):
- **context** + **patterns** + **researcher** + **critic**
- Flow: Understand system → Identify patterns → Research details → Validate understanding

## Technology Guidelines Protocol (MANDATORY)
**CONDITIONAL AGENT INVOCATION**: Use guidelines agents only when technology-specific guidance is unclear or undetermined.

**File-Level Guidelines**: Use `guidelines-file` agent before modifying any file when technology patterns are unclear
**Repository-Level Guidelines**: Use `guidelines-repo` agent for architecture decisions when stack context is undetermined

**Detection Logic**: Both agents reference @.support/instructions/stack-mapping.md for centralized technology detection rules

Examples with git commands:
  - Modify Python file with unclear patterns → Use guidelines-file agent → Apply guidelines → `git add -A && git commit -m "Update Python module following stack guidelines"`
  - Architecture decision needed → Use guidelines-repo agent → Make informed choice → `git add -A && git commit -m "Implement microservices architecture per guidelines"`

## Memory Integration Override
**MCP MEMORY USAGE**: Project-specific memory behavior:
- Prioritize memory lookup before web searches (efficiency override)
- Store agent combination success patterns for this project
- Preserve architectural decisions across sessions
- Track parallel agent cluster performance data
- Use `mcp__memory__search_nodes()` before web research
- Store findings with `mcp__memory__create_entities()` and `mcp__memory__create_relations()`

Examples with git commands:
  - Before researching: `mcp__memory__search_nodes("React architecture decisions")` → Use findings → `git add -A && git commit -m "Apply cached React patterns"`
  - After analysis: `mcp__memory__create_entities([{name: "Component Pattern", type: "decision"}])` → Store new pattern → `git add -A && git commit -m "Implement new component pattern with memory storage"`
  - Link decisions: `mcp__memory__create_relations([{source: "pattern_id", target: "decision_id"}])` → Apply relationships → `git add -A && git commit -m "Connect related architectural decisions"`

## Simple Git Protocol (MANDATORY)
**EXECUTE AFTER EVERY CHANGE - NO EXCEPTIONS**:
1. **Stage immediately**: `git add -A` after any file modification
2. **Commit at milestones**: When any meaningful task is complete
3. **Always invoke tagger**: Use tagger agent after EVERY commit to evaluate for tags
4. **Update CHANGELOG.md**: When tagger creates release tags, update CHANGELOG.md with release notes
5. **Push immediately**: `git push origin main` after every commit

**Agent coordination**: All agents MUST follow this protocol. Tagger agent runs autonomously after every commit.

Example sequence:
  ```bash
  # After modifying src/components/Header.tsx
  git add -A
  git commit -m "Add dark mode toggle to header component"
  # Auto-invoke tagger agent here
  # If tagger creates v1.2.0 tag → Update CHANGELOG.md with release notes
  git push origin main
  ```

## Documentation Protocol (MANDATORY)
**EXECUTE WITH EVERY CODE CHANGE - NO EXCEPTIONS**:
1. **Same commit rule**: Documentation updates in same commit as code changes
2. **Always check**: README.md, CHANGELOG.md, API docs, CLAUDE.md for needed updates
3. **Update immediately**: New features, API changes, configuration changes
4. **Use docs agent**: Invoke docs agent for documentation maintenance

Examples with git commands:
  - Add new API endpoint → Update API docs + README.md → `git add -A && git commit -m "Add user endpoint with docs"`
  - New agent created → Use docs agent to update CLAUDE.md + CHANGELOG.md → `git add -A && git commit -m "Add analyzer agent with documentation"`
  - Configuration change → Update README.md setup instructions → `git add -A && git commit -m "Update config with README changes"`
  - Feature complete → README.md usage section + CHANGELOG.md entry → `git add -A && git commit -m "Complete feature X with docs"`

## TODO Protocol (MANDATORY)
**USE TODO AGENT FOR ALL TASK MANAGEMENT - NO CONTEXT CLUTTER**:
1. **Agent delegation**: Use todo agent for creating/tracking tasks
2. **Clean context**: No TODO tracking in main conversation flow
3. **Deferred actions**: TODOs represent future work, not current progress
4. **File management**: Agent handles `.support/todos/` directory autonomously
5. **Git integration**: After TODO files created → `git add -A && git commit -m "Add TODO items for X"`

**Agent invocation**: `Task: "Create TODO for X" (subagent_type: todo)`

Examples with git commands:
  - Create project TODOs → Use todo agent → `git add -A && git commit -m "Add project planning TODOs"`
  - Update TODO status → Modify .support/todos/file.md → `git add -A && git commit -m "Update TODO status for feature Y"`

---

## PROTOCOL ENFORCEMENT REMINDER

**AFTER EVERY FILE MODIFICATION - NO EXCEPTIONS:**
```bash
git add -A
git commit -m "Descriptive message"
# Auto-invoke tagger agent
git push origin main
```

**Cross-reference**: All protocols above include git commands - follow them exactly.

