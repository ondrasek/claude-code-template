# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Claude Code configuration template repository that demonstrates best practices for configuring Claude Code with custom commands, agents, MCP tools, and hooks.

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
Specialized assistants in `agents/` for complex tasks:
- Code Reviewer Agent - Systematic code analysis
- Test Writer Agent - Comprehensive test creation
- General Purpose Agent - Multi-step research tasks

### 3. MCP Tools
External tool integrations in `mcp-tools/`:
- Filesystem access
- Database connections
- API integrations
- Custom tool development

### 4. Hooks
Automation scripts in `hooks/` that respond to Claude Code events

## Usage Guidelines

1. **Custom Commands**: Create new slash commands by adding `.md` files to `commands/`
2. **Agent Development**: Define specialized agents in `agents/` for domain-specific tasks
3. **Tool Integration**: Configure MCP servers in `mcp-tools/` for external services
4. **Automation**: Set up hooks for repetitive tasks and validations

## Development Workflow

### Git Commit Strategy
- **Commit frequently**: Make small, atomic commits after each meaningful change
- **Trunk-based development**: Always work on main branch unless explicitly instructed otherwise
- **No feature branches**: Push directly to main to maintain continuous integration
- **Commit after**: 
  - Adding new features
  - Fixing bugs
  - Refactoring code
  - Updating documentation
  - Modifying configurations
- **Auto-push**: Push commits to origin/main immediately after committing

### Example Workflow
```bash
# After making changes
git add -A
git commit -m "Add feature X"
git push origin main
```

## Best Practices

- Keep commands focused and well-documented
- Design agents for specific, complex workflows
- Test MCP configurations before deployment
- Use hooks to enforce coding standards
- Update this file as new configurations are added
- Commit and push changes frequently to maintain code history