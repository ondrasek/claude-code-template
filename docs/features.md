# Key Features Guide

This template provides three main categories of enhancements to Claude Code: specialized agents, custom commands, and automation systems.

## Specialized AI Agents

The template includes 19 specialized agents that work together to provide comprehensive development assistance:

### Core Analysis Agents
- **`researcher`** - Gathers information, finds best practices, researches documentation
- **`patterns`** - Detects code patterns, identifies refactoring opportunities  
- **`principles`** - Applies SOLID principles, enforces architectural standards
- **`completer`** - Finds missing implementations, TODOs, error handling gaps
- **`critic`** - Challenges assumptions, provides balanced perspective

### Problem-Solving Agents  
- **`hypothesis`** - Forms theories for debugging, designs experiments
- **`explorer`** - Generates multiple solution alternatives
- **`constraints`** - Handles complex requirements and trade-offs
- **`resolver`** - Mediates between conflicting approaches
- **`connector`** - Finds creative cross-domain solutions

### Specialized Agents
- **`generator`** - Creates code generators, templates, DSLs
- **`invariants`** - Designs type systems, prevents invalid states
- **`time`** - Analyzes git history and code evolution
- **`context`** - Provides deep system understanding
- **`whisper`** - Applies micro-improvements at scale
- **`prompter`** - Develops AI agents and prompts
- **`axioms`** - Applies first-principles reasoning

### Utility Agents
- **`docs`** - Maintains documentation consistency
- **`todo-manager`** - Manages development task lists

## Custom Slash Commands

Quick access to common development tasks:

### Code Quality
- `/review` - Comprehensive code review with best practices
- `/refactor` - Code improvement suggestions
- `/security` - Security audit and vulnerability scanning

### Development Workflow  
- `/test` - Generate tests, improve test coverage
- `/debug-mcp` - Debug MCP server issues
- `/doc-update` - Sync documentation with code changes

### Technology-Specific
- `/python-uv` - Set up Python projects with uv package manager
- `/langchain-agent` - LangChain development assistance
- `/crewai-crew` - CrewAI multi-agent system development

### Agent Management
- `/agent-guide` - Learn how to use specialized agents effectively
- `/agents` - Manage and configure your AI agents
- `/create-prompt` - Generate optimized prompts for AI frameworks

### Information & Analysis
- `/stacks` - List available technology stack guidelines  
- `/discuss` - Get critical analysis of ideas and proposals

## Technology Stack Integration

Automatic detection and integration with major technology stacks:

### Supported Technologies
- **Python** - uv package manager, pytest, ruff formatting
- **Rust** - Cargo, clippy, rustfmt integration
- **JavaScript/TypeScript** - npm/yarn, ESLint, Prettier
- **Go** - Go modules, gofmt, testing patterns
- **Java** - Maven/Gradle, JUnit, Spring Boot patterns
- **C#/.NET** - dotnet CLI, NuGet, testing frameworks
- **Docker** - Container best practices, multi-stage builds

### How It Works
1. Claude Code detects files in your project (`.py`, `.rs`, `package.json`, etc.)
2. Automatically loads relevant stack guidelines from `.claude/stacks/`
3. Applies technology-specific best practices and patterns
4. Provides context-appropriate suggestions and automation

## MCP Tool Integration

### Persistent Memory System
- **Cross-session context** - Remembers important decisions and patterns
- **Architectural decisions** - Stores and recalls design choices
- **Project patterns** - Learns from your specific codebase

### Database Integration
- **SQLite server** - For structured data storage and queries
- **Local database** - Project-specific data persistence

### Extensible Architecture
Add new MCP servers easily:
```bash
claude mcp add tool-name "npx -y @your/mcp-server"
```

## Automation & Hooks

### Git Integration
- **Pre-commit memory export** - Saves context before commits
- **Automated documentation** - Updates docs when code changes
- **Security scanning** - Checks for sensitive data exposure

### Code Formatting
- **Auto-formatting** - Runs appropriate formatters after edits
- **Technology-aware** - Uses the right tools for each language
- **Customizable rules** - Configure formatting per project

### Workflow Automation
- **Prompt validation** - Prevents dangerous operations
- **File security** - Automatic sensitive file detection
- **Development shortcuts** - Shell aliases and quick commands

## Memory System Benefits

Unlike standard Claude Code sessions, this template provides:

1. **Persistent Context** - Remembers architectural decisions across sessions
2. **Pattern Learning** - Adapts to your specific coding patterns
3. **Decision History** - Recalls why certain choices were made
4. **Cross-Session Continuity** - Maintains understanding of project evolution

## Agent Coordination

Agents work together intelligently:

- **Parallel Processing** - Multiple agents can work simultaneously
- **Context Sharing** - Agents build on each other's findings  
- **Specialized Workflows** - Different agent combinations for different tasks
- **Conflict Resolution** - The `resolver` agent mediates disagreements

## Getting Maximum Value

1. **Use agents proactively** - They're designed to work together
2. **Leverage technology detection** - Let the system adapt to your stack
3. **Build up memory** - The more you use it, the smarter it gets
4. **Customize commands** - Add project-specific slash commands
5. **Configure MCP tools** - Integrate with your existing tools and services

This comprehensive feature set transforms Claude Code from a chat interface into a full development environment that learns and adapts to your specific needs.