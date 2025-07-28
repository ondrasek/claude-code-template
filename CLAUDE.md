# CLAUDE.md - AI Operational Instructions

## .claude Configuration Principles

**AI-FIRST DESIGN**: Contains only project-specific operational overrides that extend Claude Code's built-in capabilities.

## Project-Specific Operational Overrides

### Mandatory Agent Usage Override
**BEHAVIOR OVERRIDE**: Use agents proactively beyond Claude Code defaults:
- Force minimum 3+ agents for non-trivial requests (override built-in conservative agent usage)
- Add memory-first research workflow: always check `mcp__memory__search_nodes()` before web searches
- Use agent parallel clusters defined in @.support/instructions/agent-usage.md
- Enforce agents to keep the Claude Code context window tidy, optimized and neat

### Technology Stack Detection Rules
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


### Memory Integration Override
**MCP MEMORY USAGE**: Project-specific memory behavior:
- Prioritize memory lookup before web searches (efficiency override)
- Store agent combination success patterns for this project
- Preserve architectural decisions across sessions
- Track parallel agent cluster performance data
- Use `mcp__memory__search_nodes()` before web research
- Store findings with `mcp__memory__create_entities()` and `mcp__memory__create_relations()`

### TODO Management System
**COLLABORATIVE TODO WORKFLOW**: `.support/todos/` directory for human-AI collaboration:
- **Purpose**: TODOs are meant to be BOTH human and AI readable
- **Creation**: TODOs SHOULD be created by BOTH users and AI
- **Format**: Individual markdown files with YAML frontmatter (status, type, priority, assignee)
- **Tools**: Use Claude Code built-in tools only (Glob, Read, Write, Edit)
- **Preservation**: Do NOT overwrite existing TODOs unless explicitly instructed
- **Expansion**: Prefer adding new TODO files to the folder instead of modifying existing ones
- **Integration**: Update CHANGELOG.md [Unreleased] section when TODOs are completed

## Key Reference Files

**CRITICAL INSTRUCTIONS**: Always check these files for guidance:
- @.support/instructions/git-workflow.md - Trunk-based development rules
- @.support/instructions/documentation.md - Documentation maintenance
- @.support/instructions/agent-usage.md - Agent coordination patterns
- @.support/instructions/versioning.md - Semantic versioning protocol

**TECHNOLOGY STACKS**: Load appropriate guidelines:
- @.support/stacks/python.md - Python with uv development
- @.support/stacks/rust.md - Rust development patterns
- @.support/stacks/javascript.md - Node.js/TypeScript patterns
- @.support/stacks/java.md - Java/Spring Boot patterns
- @.support/stacks/kotlin.md - Kotlin backend patterns
- @.support/stacks/ruby.md - Ruby development patterns
- @.support/stacks/csharp.md - C#/.NET patterns
- @.support/stacks/cpp.md - Modern C++ patterns
- @.support/stacks/docker.md - Container patterns

**AGENT DEFINITIONS**: Custom agents in @.claude/agents/ extend Claude Code's built-in capabilities with project-specific behaviors and memory integration.