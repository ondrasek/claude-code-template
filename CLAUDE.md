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

## Automatic Agent Invocation

**IMPORTANT: Claude Code should proactively use agents based on user intent and context, without explicit user requests.**

### Trigger-Based Agent Usage
Configure Claude Code to automatically invoke agents when specific patterns are detected:

#### Code Review Triggers
When user mentions "review", "check", "audit", or shows code changes:
- **ALWAYS** invoke `patterns` agent for duplication detection
- **ALWAYS** invoke `principles` agent for SOLID/design principles
- **ALWAYS** invoke `complete` agent for missing functionality
- **IF** security-related: invoke `critic` agent for vulnerability assessment

#### Refactoring Triggers  
When user mentions "refactor", "improve", "clean up", or "optimize":
- **ALWAYS** invoke `patterns` agent first to identify opportunities
- **ALWAYS** invoke `whisper` agent for micro-improvements
- **IF** performance mentioned: invoke `hypothesis` agent
- **ALWAYS** invoke `docsync` agent after changes

#### Testing Triggers
When user mentions "test", "testing", or shows test files:
- **ALWAYS** invoke `complete` agent for missing test cases
- **IF** patterns emerge: invoke `patterns` agent
- **ALWAYS** invoke `hypothesis` agent for edge case identification

#### Architecture/Design Triggers
When user asks "how should I", "best way to", "architecture":
- **ALWAYS** invoke `explore` agent for multiple options
- **ALWAYS** invoke `principles` agent for design guidance
- **ALWAYS** invoke `constraints` agent if limitations mentioned
- **FOLLOW UP** with `critic` agent to challenge the approach

#### Research Triggers
When user mentions unfamiliar tech, shows errors, or asks "how to":
- **IMMEDIATELY** invoke `researcher` agent
- **FOLLOW** with relevant domain agents based on findings

#### Documentation Triggers
When code changes are made or user mentions "document":
- **AUTOMATICALLY** invoke `docsync` agent at end of session
- **NO USER CONFIRMATION NEEDED** - this should be seamless

### Context-Aware Agent Selection
Claude Code should analyze the current context and proactively suggest/use relevant agents:

```
IF working_on == "Python project" AND user_asks_question:
    AUTOMATICALLY invoke python-expert agent
    
IF reviewing_code AND complexity_high:
    AUTOMATICALLY invoke patterns + principles + critic agents
    
IF debugging_issue AND behavior_unexpected:
    AUTOMATICALLY invoke hypothesis agent
    
IF designing_system AND requirements_complex:
    AUTOMATICALLY invoke constraints + invariants agents
```

### Default Agent Sequences
For common workflows, automatically chain agents:

- **Code Review**: `patterns` → `principles` → `complete` → `critic`
- **Feature Development**: `explore` → `principles` → `patterns` → `docsync`
- **Bug Investigation**: `researcher` → `hypothesis` → `complete`
- **Architecture Decision**: `explore` → `constraints` → `critic` → `resolve`

### Override Mechanism
Users can disable automatic agent usage by:
- Adding `--no-agents` flag to commands
- Explicitly stating "don't use agents"
- Setting `autoAgents: false` in session context

## Key Instructions

- **Git Workflow** - @.claude/instructions/git-workflow.md - Trunk-based development, frequent commits
- **Documentation** - @.claude/instructions/documentation.md - Keep docs in sync with code changes
- **Agent Usage** - @.claude/instructions/agent-usage.md - Proactive agent use for better results
- **Versioning** - @.claude/instructions/versioning.md - Semantic versioning with tags