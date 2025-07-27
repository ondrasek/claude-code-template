# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Claude Code configuration template repository that demonstrates best practices for configuring Claude Code with custom commands, agents, and MCP tools. Configuration examples are organized by feature type with README files explaining their usage.

## Key Features

### 1. Slash Commands
Located in `commands/`, these are custom prompts that expand when invoked with `/command-name`:
- `/review` - Comprehensive code review
- `/test` - Testing assistance
- `/refactor` - Code refactoring help
- `/security` - Security audit

### 2. Agents
Specialized AI agents in `.claude/agents/` for complex tasks (alphabetically organized):
- **axioms** - First-principles reasoning
- **completer** - Find missing functionality and TODOs
- **connector** - Cross-domain creative insights
- **constraints** - Multi-dimensional constraint solving
- **context** - Deep system understanding
- **critic** - Challenge assumptions and ideas
- **docs** - Documentation maintenance
- **explorer** - Multiple solution generation
- **generator** - Code generation and DSL creation
- **hypothesis** - Scientific debugging approach
- **invariants** - Type safety and state machine design
- **patterns** - Pattern detection and refactoring
- **principles** - Software design principles (SOLID, etc.)
- **prompter** - AI agent development
- **researcher** - Information gathering and research
- **resolver** - Conflict resolution between approaches
- **time** - Historical analysis and evolution
- **whisper** - Micro-improvements at scale

Use the built-in `/agents` command to manage agents

### 3. MCP Tools
External tool integrations in `mcp-tools/`:
- Filesystem access
- Database connections
- API integrations
- Custom tool development

## Usage Guidelines

1. **Custom Commands**: Create new slash commands by adding `.md` files to `.claude/commands/`
2. **Agent Development**: Define specialized agents in `.claude/agents/` for domain-specific tasks
3. **Tool Integration**: Configure MCP servers in `.claude/settings.json`
4. **Efficiency**: Use agents and commands to automate repetitive tasks

## Development Workflow

### Git Workflow

**CRITICAL: Commit and push after EVERY non-trivial change. Never wait to accumulate changes.**

**TRUNK-BASED DEVELOPMENT: Always work on main branch. Only create feature branches if explicitly instructed.**

See: @.claude/instructions/git-workflow.md

## Technology Stack Detection

**IMPORTANT: Automatically detect and apply technology-specific guidelines based on repository contents.**

When working in this repository, check for the presence of technology-specific files and refer to the appropriate stack guidelines:

### Detection Rules
- **Python files** (`.py`, `pyproject.toml`, `requirements.txt`) → Refer to @.claude/stacks/python.md
- **Rust files** (`.rs`, `Cargo.toml`) → Refer to @.claude/stacks/rust.md
- **JavaScript/TypeScript** (`.js`, `.ts`, `package.json`) → Refer to @.claude/stacks/javascript.md
- **Go files** (`.go`, `go.mod`) → Refer to @.claude/stacks/go.md
- **Java files** (`.java`, `pom.xml`, `build.gradle`) → Refer to @.claude/stacks/java.md
- **Kotlin files** (`.kt`, `build.gradle.kts`) → Refer to @.claude/stacks/kotlin.md
- **Ruby files** (`.rb`, `Gemfile`) → Refer to @.claude/stacks/ruby.md
- **C# files** (`.cs`, `.csproj`, `*.sln`) → Refer to @.claude/stacks/csharp.md
- **C/C++ files** (`.c`, `.cpp`, `.h`, `CMakeLists.txt`) → Refer to @.claude/stacks/cpp.md
- **Docker files** (`Dockerfile`, `docker-compose.yml`) → Refer to @.claude/stacks/docker.md

### Usage
1. At the start of each session, identify which technologies are present
2. Load the corresponding stack guidelines from `.claude/stacks/`
3. Follow technology-specific best practices throughout the session
4. If multiple technologies are present, apply all relevant guidelines

Additional stacks can be added in `.claude/stacks/`.

## Automatic Agent Invocation

**CRITICAL: Claude Code MUST use ALL appropriate agents for EVERY user request, prompt, or interaction.**

### Universal Agent Rule

**For ANY user request**: Use ALL appropriate agents automatically
- **ALWAYS start with**: `researcher` + `patterns` + `principles` + `completer`
- **ALWAYS add**: `critic` to validate approaches and challenge assumptions
- **ALWAYS include**: `docs` after any code modifications
- **ALWAYS consider**: Domain-specific agents based on detected technology stacks

### Default Agent Pipeline

**Standard Pipeline for ALL Requests:**
1. `researcher` - Gather information and context
2. `patterns` - Identify relevant patterns and structures  
3. `principles` - Apply design principles and best practices
4. `completer` - Ensure completeness and find missing elements
5. `critic` - Challenge assumptions and validate approaches
6. `docs` - Update documentation for any changes

**Additional Agents by Context:**
- Prompt engineering: Add `prompter`
- Architecture discussions: Add `explorer` + `constraints`
- Debugging: Add `hypothesis`
- Code generation: Add `generator`
- Historical analysis: Add `time`
- Cross-domain solutions: Add `connector`
- Type safety: Add `invariants`
- First principles: Add `axioms`
- System understanding: Add `context`
- Conflict resolution: Add `resolver`
- Code quality: Add `whisper`

### Simplified Automation Rules

1. **Use agents for EVERYTHING** - No exceptions, no trigger pattern matching needed
2. **Start comprehensive** - Begin with the standard 6-agent pipeline
3. **Add context-specific** - Include domain agents based on project detection
4. **Run in parallel when possible** - Maximum efficiency
5. **Always end with `docs`** - Keep documentation current

### Override Mechanism
Users can disable automatic agent usage by:
- Adding `--no-agents` flag to commands
- Explicitly stating "don't use agents"

## Key Instructions

- **Git Workflow** - @.claude/instructions/git-workflow.md - Trunk-based development, frequent commits
- **Documentation** - @.claude/instructions/documentation.md - Keep docs in sync with code changes
- **Agent Usage** - @.claude/instructions/agent-usage.md - Proactive agent use for better results
- **Versioning** - @.claude/instructions/versioning.md - Semantic versioning with tags