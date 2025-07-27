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

## Agent Usage Guidelines

Claude Code should PROACTIVELY use specialized agents for better results:

### When to Use Each Agent

**ALWAYS use researcher agent when:**
- User mentions unfamiliar tools, libraries, or frameworks
- Encountering errors or debugging issues
- Asked about best practices or implementation patterns
- Need to find examples or documentation
- Comparing different approaches or technologies

**PROACTIVELY use pattern agents when:**
- `patterns`: Analyzing codebases for improvements
- `context`: User asks "how does X work" in this codebase
- `explore`: User needs multiple solution options
- `constraints`: Dealing with complex requirements
- `time`: Reviewing git history or predicting future needs

**MUST use principle agents when:**
- `principles`: Reviewing architecture or design decisions
- `axioms`: User asks "why" or needs first-principles thinking
- `invariants`: Designing type systems or state machines
- `resolve`: Patterns and principles conflict

**AUTOMATICALLY use utility agents when:**
- `whisper`: Code needs micro-improvements (use with BatchTool)
- `complete`: Finding and fixing TODOs, missing handlers
- `docsync`: After any feature addition or API change
- `hypothesis`: Debugging mysterious behavior
- `meta`: Noticing code generation opportunities

### Agent Collaboration Patterns

1. **Research First**: Use `researcher` to gather information, then apply other agents
2. **Pattern + Principle**: Use both to get complete analysis
3. **Document Always**: Follow any change with `docsync`
4. **Batch Operations**: Use `whisper` and `complete` with BatchTool

### Example Workflows

**Learning New Tool:**
1. `researcher` - Gather docs, examples, best practices in parallel
2. `patterns` - Identify common usage patterns
3. `meta` - Create generators for boilerplate

**Code Review:**
1. `context` - Understand the system
2. `patterns` + `principles` - Analyze from both angles
3. `resolve` - Handle any conflicts
4. `whisper` - Apply micro-improvements

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

## Technology Stack Guidelines

### Available Technology Stacks

This repository supports multiple technology stacks through modular configuration files. Each stack has its own guidelines, best practices, and specialized commands.

**Currently Available Stacks:**
- **Python** - See `.claude/stacks/python.md` for Python/uv development guidelines
- (More stacks can be added in `.claude/stacks/`)

### Using Technology-Specific Guidelines

1. **Reference the stack file**: When working with a specific technology, reference the appropriate stack file
2. **Use stack commands**: Each stack may have specific commands (e.g., `/python-uv` for Python)
3. **Follow stack conventions**: Each technology has its own patterns and best practices

### Python Quick Reference
For Python development, this project uses **uv exclusively** for dependency management.
See `.claude/stacks/python.md` for complete Python development guidelines.

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

## Versioning

This project follows **Semantic Versioning (SemVer)** - see VERSIONING.md for details.

When making changes:
- **MAJOR (breaking)**: Removing features, changing configurations incompatibly
- **MINOR (features)**: Adding agents, commands, or new capabilities
- **PATCH (fixes)**: Bug fixes, typos, small improvements

Always:
1. Update version in CHANGELOG.md
2. Create git tag: `git tag -a v1.2.3 -m "Release version 1.2.3"`
3. Push tag: `git push origin v1.2.3`

## Best Practices

- Keep commands focused and well-documented
- Design agents for specific, complex workflows
- Test MCP configurations before deployment
- Use hooks to enforce coding standards
- Update this file as new configurations are added
- Commit and push changes frequently to maintain code history
- Use uv exclusively for Python dependency management
- Maintain documentation synchronously with code changes
- Follow semantic versioning for all releases