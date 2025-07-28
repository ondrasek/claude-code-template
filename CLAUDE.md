# CLAUDE.md - AI Operational Instructions

## Agent Coordination Protocol (MANDATORY)
**EXECUTE FOR ALL NON-TRIVIAL REQUESTS - NO EXCEPTIONS**:
1. **Minimum 3+ agents**: Always use multiple agents for complex tasks
2. **Memory-first research**: Check `mcp__memory__search_nodes()` before web searches
3. **Parallel agent clusters**: Use multiple agents simultaneously when possible
4. **Context optimization**: Agents keep main context window tidy and focused

**Agent combinations**: researcher + patterns + critic (minimum baseline)

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

## Key Reference Files

**TECHNOLOGY STACKS**: MANDATORY operational instructions applied when technologies detected:
- @.support/stacks/python.md - Python with uv development (ENFORCE uv exclusively)
- @.support/stacks/rust.md - Rust development patterns (ENFORCE ownership/borrowing)
- @.support/stacks/javascript.md - Node.js/TypeScript patterns (ENFORCE TypeScript types)
- @.support/stacks/java.md - Java/Spring Boot patterns (ENFORCE Java 17+ features)
- @.support/stacks/kotlin.md - Kotlin backend patterns (ENFORCE coroutines over blocking)
- @.support/stacks/ruby.md - Ruby development patterns (ENFORCE RSpec testing)
- @.support/stacks/csharp.md - C#/.NET patterns (ENFORCE nullable reference types)
- @.support/stacks/cpp.md - Modern C++ patterns (ENFORCE C++20 features, RAII)
- @.support/stacks/docker.md - Container patterns (ENFORCE security hardening)
