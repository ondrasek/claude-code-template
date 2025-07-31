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
**AGGRESSIVE PARALLEL AGENT USAGE - MANDATORY OVERRIDE**:
- Claude Code MUST use 3+ agents for ANY non-trivial request (override built-in conservative defaults)
- NEVER wait for user to ask for agents - invoke based on task context automatically
- **MINIMUM THRESHOLDS**: 
  - Simple code changes: 3+ agents minimum
  - Architecture decisions: 4+ agents minimum
  - Complex debugging: 5+ agents minimum
  - Code quality reviews: 3+ agents minimum
- **PARALLEL-FIRST MENTALITY**: Default to parallel agent clusters, not sequential processing
- Agents must keep main context window tidy, optimized and neat
- **RECURSION PREVENTION**: Only Claude Code main context spawns agents - sub-agents NEVER spawn other agents

**MANDATORY PARALLEL PATTERNS**:
  - User: "This code looks messy" → Auto-invoke: foundation-patterns + specialist-code-cleaner + foundation-criticism + foundation-principles (4 agents)
  - User: "How should I structure this?" → Auto-invoke: specialist-stack-advisor + specialist-options-analyzer + foundation-principles + foundation-criticism + specialist-constraint-solver + foundation-conflicts (6 agents)
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

**ENHANCED EXECUTION PROTOCOL**:
1. **MANDATORY PARALLEL CLUSTERS**: Use 3+ agents simultaneously for ALL non-trivial requests
   Example: Single message with 5+ Task() calls running foundation-research + foundation-patterns + foundation-criticism + foundation-principles + specialist-options-analyzer simultaneously
2. **CONTEXT DELEGATION MAXIMIZATION**: ALL complex analysis happens in parallel agent contexts, NEVER in main context
   Example: Don't analyze ANY files in main context → Use foundation-patterns + foundation-context + specialist-options-analyzer agents in parallel
3. **AGGRESSIVE AUTOMATIC SELECTION**: Match EXPANDED agent combinations to user request patterns
   Example: "Why is this slow?" → Auto-select foundation-research + specialist-options-analyzer + foundation-patterns + specialist-performance-optimizer + foundation-criticism + specialist-test-strategist (6 agents)
4. **PARALLEL-FIRST DECISION MAKING**: When in doubt, add MORE agents to the parallel cluster
5. **AGENT HIERARCHY**: Only main Claude Code context spawns agents. Sub-agents are terminal nodes and NEVER spawn other agents via Task tool.

## Agent Coordination Best Practices (MANDATORY)

**ENHANCED PARALLEL EXECUTION PATTERNS**:
- **Single Message Multi-Task**: MUST use single message with 3+ Task() calls for genuine concurrent agent processing
- **AGGRESSIVE Parallelism**: All agent clusters MUST execute simultaneously, NEVER sequentially - add more agents when uncertain
- **EXPANDED Concurrent Processing**: 3+ agents per parallel batch as default, with more agents for complex tasks
- **MULTI-PHASE Coordination**: Each phase executes maximum possible agents simultaneously, synthesize results, then launch next parallel cluster if needed
- **COVERAGE MAXIMIZATION**: Prefer agent redundancy over under-coverage - better to have overlapping analysis than gaps

**ENHANCED CORE-SATELLITE COORDINATION PATTERNS**:
- **MANDATORY Core Foundation Quartet**: ALWAYS include foundation-research + foundation-patterns + foundation-principles + foundation-criticism in EVERY parallel cluster
- **AGGRESSIVE Specialized Addition**: Add 2-3 specialized agents to EVERY request - don't wait for "need", anticipate requirements
- **UNIVERSAL Consistency**: foundation-principles agent MANDATORY in every parallel cluster for universal consistency
- **PROACTIVE Conflict Resolution**: foundation-conflicts agent AUTO-INCLUDED when 4+ agents involved to handle competing recommendations
- **BALANCED Load Distribution**: Core agents handle 60% of work, specialized agents handle 40% - more even distribution
- **COMPREHENSIVE Coverage Priority**: Prefer agent redundancy and over-analysis under-coverage - better safe than sorry

## AGGRESSIVE PARALLEL AGENT USAGE PATTERNS (MANDATORY)

**TASK COMPLEXITY → AGENT COUNT MAPPING**:
- **Simple file edit**: foundation-patterns + specialist-code-cleaner + foundation-principles (3 agents minimum)
- **Code refactoring**: foundation-patterns + specialist-code-cleaner + foundation-principles + foundation-criticism + specialist-test-strategist (5 agents)
- **Bug investigation**: foundation-research + specialist-options-analyzer + foundation-patterns + foundation-criticism + specialist-test-strategist + specialist-performance-optimizer (6 agents)
- **Architecture design**: specialist-options-analyzer + foundation-principles + specialist-constraint-solver + foundation-criticism + specialist-stack-advisor + foundation-conflicts (6 agents)
- **Feature implementation**: foundation-research + specialist-stack-advisor + foundation-patterns + foundation-principles + specialist-code-cleaner + specialist-test-strategist + specialist-stack-advisor (7 agents - exceed normal limits)

**AUTOMATIC AGENT ESCALATION RULES**:
1. **Start with 3-agent minimum** for ANY coding task
2. **Add +1 agent** if task involves multiple files
3. **Add +1 agent** if task involves architecture decisions  
4. **Add +1 agent** if task involves performance considerations
5. **Add +1 agent** if task involves testing or quality assurance
6. **Add foundation-conflicts** automatically when 4+ agents involved

**PARALLEL CLUSTER COMPOSITION RULES**:
- **ALWAYS include**: foundation-principles (consistency)
- **USUALLY include**: foundation-patterns (quality) + foundation-criticism (validation)
- **OFTEN include**: foundation-research (context) when unknowns exist
- **CONTEXT-BASED addition**: 2-3 specialists based on task domain
- **CONFLICT RESOLUTION**: foundation-conflicts when multiple viewpoints expected

**OVERRIDE CONSERVATIVE DEFAULTS**:
- Claude Code's built-in agent usage is TOO CONSERVATIVE
- FORCE parallel agent usage even for "simple" tasks
- Prefer OVER-ANALYSIS to under-analysis
- Use MORE agents when uncertain about requirements
- DEFAULT to parallel clusters, NEVER default to single agents

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

**ENHANCED TODO COMMAND INTEGRATION**:
- **`/todo-next`**: Comprehensive TODO hygiene + intelligent next-step analysis
  - Combines cleanup of completed/stale TODOs with strategic task prioritization
  - Uses parallel agent clusters for completion detection, staleness assessment, and next-step planning
  - Supports --dry-run, --cleanup-only, --analysis-only modes for flexible workflow integration
  - Implements git safety protocols with mandatory verification before TODO deletion
  - Provides strategic recommendations for optimal task progression

Examples:
  - Create project TODOs → Use specialist-todo agent → Follow Simple Git Protocol
  - Update TODO status → Modify .support/todos/file.md → Follow Simple Git Protocol
  - Comprehensive TODO maintenance → `/todo-next --dry-run` → Review recommendations → `/todo-next` → Follow Simple Git Protocol

---

## PROTOCOL ENFORCEMENT REMINDER

**AFTER EVERY FILE MODIFICATION - NO EXCEPTIONS:**
Follow Simple Git Protocol (see Simple Git Protocol section above)

**Cross-reference**: All protocols above reference Simple Git Protocol - follow it consistently.
