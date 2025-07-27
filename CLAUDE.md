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

### 4. Hooks
Automation scripts in `hooks/` that respond to Claude Code events

## Usage Guidelines

1. **Custom Commands**: Create new slash commands by adding `.md` files to `.claude/commands/`
2. **Agent Development**: Define specialized agents in `.claude/agents/` for domain-specific tasks
3. **Tool Integration**: Configure MCP servers in `.claude/settings.json`
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

## Python Development with uv

### Project Management
- **Always use uv** for Python projects - no pip, poetry, or other tools
- **Project initialization**: `uv init` for new projects
- **Dependencies**: `uv add package` and `uv remove package`
- **Virtual environments**: Managed automatically by uv
- **Running scripts**: `uv run python script.py`
- **Installing tools**: `uv tool install package`

### Common uv Commands
```bash
uv init                    # Initialize new project
uv add pandas numpy       # Add dependencies
uv add --dev pytest ruff  # Add dev dependencies
uv sync                   # Sync dependencies
uv run python main.py     # Run Python scripts
uv run pytest            # Run tests
uv tool install ruff     # Install tools globally
```

## Documentation Maintenance

### Automatic Documentation Updates
- **Always update documentation** when making code changes
- **Same commit rule**: Documentation updates go in the same commit as code changes
- **Files to maintain**: README.md, CHANGELOG.md, API documentation, CLAUDE.md
- **What to update**:
  - New features: Add to README features section
  - API changes: Update API documentation
  - Configuration changes: Update setup instructions
  - Breaking changes: Add to CHANGELOG with migration guide
  - New dependencies: Update installation instructions

### Documentation Checklist
Before committing, check if your changes affect:
- [ ] README.md - Features, installation, usage
- [ ] CHANGELOG.md - Version history, breaking changes
- [ ] API docs - Endpoint changes, new methods
- [ ] Configuration docs - New settings, environment variables
- [ ] CLAUDE.md - Development guidelines, patterns

### Using the Documentation Agent
Use the `docsync` agent to help maintain documentation:
```
Task: Use the docsync agent to update documentation after adding the new caching feature
```

## Best Practices

- Keep commands focused and well-documented
- Design agents for specific, complex workflows
- Test MCP configurations before deployment
- Use hooks to enforce coding standards
- Update this file as new configurations are added
- Commit and push changes frequently to maintain code history
- Use uv exclusively for Python dependency management
- Maintain documentation synchronously with code changes