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
Specialized AI agents in `.claude/agents/` for complex tasks:
- **Pattern-Based**: context, patterns, explore, whisper, constraints, time, connect, complete, hypothesis, meta
- **First-Principles**: principles, axioms, invariants
- **Conflict Resolution**: resolve
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
- **Rust files** (`.rs`, `Cargo.toml`) → Refer to @.claude/stacks/rust.md (if exists)
- **JavaScript/TypeScript** (`.js`, `.ts`, `package.json`) → Refer to @.claude/stacks/javascript.md (if exists)
- **Go files** (`.go`, `go.mod`) → Refer to @.claude/stacks/go.md (if exists)
- **Java files** (`.java`, `pom.xml`, `build.gradle`) → Refer to @.claude/stacks/java.md (if exists)
- **Ruby files** (`.rb`, `Gemfile`) → Refer to @.claude/stacks/ruby.md (if exists)
- **C/C++ files** (`.c`, `.cpp`, `.h`, `CMakeLists.txt`) → Refer to @.claude/stacks/cpp.md (if exists)
- **Docker files** (`Dockerfile`, `docker-compose.yml`) → Refer to @.claude/stacks/docker.md (if exists)

### Usage
1. At the start of each session, identify which technologies are present
2. Load the corresponding stack guidelines from `.claude/stacks/`
3. Follow technology-specific best practices throughout the session
4. If multiple technologies are present, apply all relevant guidelines

Additional stacks can be added in `.claude/stacks/`.


## Key Instructions

- **Git Workflow** - @.claude/instructions/git-workflow.md - Trunk-based development, frequent commits
- **Documentation** - @.claude/instructions/documentation.md - Keep docs in sync with code changes
- **Agent Usage** - @.claude/instructions/agent-usage.md - Proactive agent use for better results
- **Versioning** - @.claude/instructions/versioning.md - Semantic versioning with tags