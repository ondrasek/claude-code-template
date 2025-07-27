# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Claude Code configuration template repository that demonstrates best practices for configuring Claude Code with custom commands, agents, and MCP tools.

## Repository Purpose

This repository contains Claude Code configuration examples organized by feature type. Each directory contains specific configuration types with README files explaining their usage.

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

## Agent Usage Guidelines

Detailed agent usage instructions have been moved to `.claude/instructions/agent-usage.md` for better organization.

See: @.claude/instructions/agent-usage.md

## Development Workflow

### Git Workflow

Git workflow instructions have been moved to `.claude/instructions/git-workflow.md` for better organization.

See: @.claude/instructions/git-workflow.md

## Technology Stack Guidelines

### Available Technology Stacks

This repository supports multiple technology stacks through modular configuration files. Each stack has its own guidelines, best practices, and specialized commands.

**Currently Available Stacks:**
- **Python** - See @.claude/stacks/python.md for Python/uv development guidelines
- (More stacks can be added in `.claude/stacks/`)

### Using Technology-Specific Guidelines

1. **Reference the stack file**: When working with a specific technology, reference the appropriate stack file
2. **Use stack commands**: Each stack may have specific commands (e.g., `/python-uv` for Python)
3. **Follow stack conventions**: Each technology has its own patterns and best practices

### Python Quick Reference
For Python development, this project uses **uv exclusively** for dependency management.
See @.claude/stacks/python.md for complete Python development guidelines.

## Documentation Maintenance

Documentation maintenance instructions have been moved to `.claude/instructions/documentation.md` for better organization.

See: @.claude/instructions/documentation.md

## Versioning

Versioning guidelines have been moved to `.claude/instructions/versioning.md` for better organization.

See: @.claude/instructions/versioning.md

## Best Practices

- Keep commands focused and well-documented
- Design agents for specific, complex workflows
- Test MCP configurations before deployment
- Use agents and commands to maintain standards
- Update this file as new configurations are added
- Commit and push changes frequently to maintain code history
- Use uv exclusively for Python dependency management
- Maintain documentation synchronously with code changes
- Follow semantic versioning for all releases

## Instruction Files

Detailed instructions are organized in topic-specific files:

- **Git Workflow** - @.claude/instructions/git-workflow.md - Commit strategy, trunk-based development
- **Documentation** - @.claude/instructions/documentation.md - Maintaining docs, using docsync agent
- **Agent Usage** - @.claude/instructions/agent-usage.md - When and how to use each agent
- **Versioning** - @.claude/instructions/versioning.md - Semantic versioning guidelines