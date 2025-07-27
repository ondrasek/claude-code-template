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
- **complete** - Find missing functionality and TODOs
- **connect** - Cross-domain creative insights
- **constraints** - Multi-dimensional constraint solving
- **context** - Deep system understanding
- **critic** - Challenge assumptions and ideas
- **docsync** - Documentation maintenance
- **explore** - Multiple solution generation
- **hypothesis** - Scientific debugging approach
- **invariants** - Type safety and state machine design
- **meta** - Code generation and DSL creation
- **patterns** - Pattern detection and refactoring
- **principles** - Software design principles (SOLID, etc.)
- **prompt-engineer** - AI agent development
- **python-expert** - Python-specific guidance
- **researcher** - Information gathering and research
- **resolve** - Conflict resolution between approaches
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

## Intelligent Agent Invocation

**Claude Code should proactively use appropriate agents based on request context for optimal results.**

### Context-Aware Agent Selection

**Core Principle**: Use the right agents for the task, not all agents for every task.

**Base Agents** (used for most requests):
- `researcher` - Gather information and current best practices
- `critic` - Validate approaches and challenge assumptions

**Context-Specific Agents**:
- **Code Analysis**: Add `patterns` + `principles` when reviewing or refactoring code
- **Debugging Issues**: Add `hypothesis` for systematic problem investigation  
- **Architecture Decisions**: Add `explore` + `constraints` for design alternatives
- **Missing Functionality**: Add `complete` when scanning for TODOs or gaps
- **Code Generation**: Add `meta` for templates, DSLs, or repetitive code
- **Documentation Changes**: Add `docsync` after any code modifications
- **Historical Context**: Add `time` for git history or evolution analysis

**Technology-Specific Agents**:
- Python projects: Add `python-expert` when working with .py files
- Prompt engineering: Add `prompt-engineer` for AI agent development
- Type systems: Add `invariants` for state machine or type safety work

### Smart Agent Workflows

**Simple Queries** → `researcher` only
**Code Review** → `researcher` + `patterns` + `principles` + `critic`
**Debugging** → `researcher` + `hypothesis` + `critic`  
**Architecture Planning** → `researcher` + `explore` + `constraints` + `principles` + `critic`
**Feature Implementation** → `researcher` + `patterns` + `complete` + `docsync`

### User Control Mechanisms

**Comprehensive Analysis**: User says "use all agents" or "deep analysis"
**Quick Response**: User says "quick answer" or "simple question"  
**Specific Focus**: User says "just check patterns" or "only research this"
**No Agents**: User says "don't use agents" or adds `--no-agents` flag

### Performance Guidelines

1. **Start minimal** - Begin with base agents, add based on context
2. **Progressive enhancement** - Add agents based on initial findings
3. **Parallel execution** - Run compatible agents simultaneously
4. **Fail gracefully** - Continue if individual agents fail
5. **Respect time limits** - Don't over-analyze simple requests

## Key Instructions

- **Git Workflow** - @.claude/instructions/git-workflow.md - Trunk-based development, frequent commits
- **Documentation** - @.claude/instructions/documentation.md - Keep docs in sync with code changes
- **Agent Usage** - @.claude/instructions/agent-usage.md - Proactive agent use for better results
- **Versioning** - @.claude/instructions/versioning.md - Semantic versioning with tags