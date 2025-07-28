# CLAUDE.md - AI Operational Instructions

## Agent Coordination Protocol (MANDATORY)
**PROACTIVE AGENT USAGE - USE AGENTS WITHOUT USER REQUESTS**:
- Claude Code MUST use agents proactively beyond built-in conservative defaults
- NEVER wait for user to ask for agents - invoke based on task context automatically
- Force minimum 3+ agents for non-trivial requests (override built-in agent usage)
- Agents must keep main context window tidy, optimized and neat

**EXECUTION PROTOCOL**:
1. **Memory-first research**: Check `mcp__memory__search_nodes()` before web searches
2. **Parallel agent clusters**: Use multiple agents simultaneously when possible  
3. **Context delegation**: Complex analysis happens in agent context, not main context
4. **Automatic selection**: Match agent combinations to user request patterns

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

## Technology Stack Detection Rules
**AUTOMATIC STACK DETECTION**: At session start, detect active technologies:
```
1. Use Glob tool to scan for technology indicators:
   - Python: *.py, pyproject.toml, requirements.txt → Apply @.support/stacks/python.md
   - Rust: *.rs, Cargo.toml → Apply @.support/stacks/rust.md
   - JavaScript/TypeScript: *.js, *.ts, package.json → Apply @.support/stacks/javascript.md
   - Go: *.go, go.mod → Apply @.support/stacks/go.md
   - Java: *.java, pom.xml, build.gradle → Apply @.support/stacks/java.md
   - Kotlin: *.kt, build.gradle.kts → Apply @.support/stacks/kotlin.md
   - Ruby: *.rb, Gemfile → Apply @.support/stacks/ruby.md
   - C#: *.cs, *.csproj, *.sln → Apply @.support/stacks/csharp.md
   - C/C++: *.c, *.cpp, *.h, CMakeLists.txt → Apply @.support/stacks/cpp.md
   - Docker: Dockerfile, docker-compose.yml → Apply @.support/stacks/docker.md
2. Load corresponding stack guidelines using @ syntax
3. Apply technology-specific best practices throughout session
```

## Memory Integration Override
**MCP MEMORY USAGE**: Project-specific memory behavior:
- Prioritize memory lookup before web searches (efficiency override)
- Store agent combination success patterns for this project
- Preserve architectural decisions across sessions
- Track parallel agent cluster performance data
- Use `mcp__memory__search_nodes()` before web research
- Store findings with `mcp__memory__create_entities()` and `mcp__memory__create_relations()`

## Simple Git Protocol (MANDATORY)
**EXECUTE AFTER EVERY CHANGE - NO EXCEPTIONS**:
1. **Stage immediately**: `git add -A` after any file modification
2. **Commit at milestones**: When any meaningful task is complete
3. **Always invoke tagger**: Use tagger agent after EVERY commit to evaluate for tags
4. **Push immediately**: `git push origin main` after every commit

**Agent coordination**: All agents MUST follow this protocol. Tagger agent runs autonomously after every commit.

## Documentation Protocol (MANDATORY)
**EXECUTE WITH EVERY CODE CHANGE - NO EXCEPTIONS**:
1. **Same commit rule**: Documentation updates in same commit as code changes
2. **Always check**: README.md, CHANGELOG.md, API docs, CLAUDE.md for needed updates
3. **Update immediately**: New features, API changes, configuration changes
4. **Use docs agent**: Invoke docs agent for documentation maintenance

## TODO Protocol (MANDATORY)
**USE TODO AGENT FOR ALL TASK MANAGEMENT - NO CONTEXT CLUTTER**:
1. **Agent delegation**: Use TODO agent for creating/tracking tasks
2. **Clean context**: No TODO tracking in main conversation flow
3. **Deferred actions**: TODOs represent future work, not current progress
4. **File management**: Agent handles `.support/todos/` directory autonomously

**Agent invocation**: `Task: "Create TODO for X" (subagent_type: todo)`

