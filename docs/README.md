# Documentation Index

This directory contains detailed documentation for understanding and customizing the Claude Code template. 

## Getting Started

If you're new to this template, start with the [main README](../README.md) for installation and quick start instructions.

## Documentation Structure

### [Features Guide](features.md)
Learn about the template's key capabilities:
- 19 specialized AI agents and how they work together
- Custom slash commands for common development tasks
- Technology stack integration and automatic detection
- MCP tool integration and automation systems

### [Memory System Guide](memory-system.md) 
Understand the persistent memory system that makes this template unique:
- How context persists across Claude Code sessions
- Automatic memory export/import with git hooks
- Knowledge graph storage of architectural decisions
- Leveraging memory for better development assistance

### [Customization Guide](customization.md)
Adapt the template for your specific needs:
- Creating custom slash commands and AI agents
- Adding new technology stack guidelines  
- Configuring MCP servers for your tools
- Team collaboration and environment-specific setups

## After Installation

Once you've installed the template, these essential commands will help you explore:

- `/agents` - Manage your 19 specialized AI agents
- `/stacks` - View available technology stack guidelines
- `/memory-export` - Save current session context
- `/agent-guide` - Learn effective agent usage patterns

## Key Configuration Files

- **`CLAUDE.md`** - Project-specific guidelines (customize for your project)
- **`.claude/settings.json`** - Main Claude Code configuration
- **`.mcp.json`** - MCP server configuration for memory and tools
- **`.claude/agents/`** - Individual agent definitions and capabilities

## Quick Reference

### Most Useful Agents
- `researcher` + `patterns` + `principles` - Core analysis trio
- `critic` - Challenge assumptions and validate approaches  
- `completer` - Find missing implementations and TODOs
- `docs` - Keep documentation in sync with code changes

### Essential Commands
- `/review` - Comprehensive code analysis
- `/refactor` - Code improvement suggestions
- `/test` - Testing assistance and generation
- `/doc-update` - Sync documentation with code changes

## Need Help?

- **Template Issues**: Check `./scripts/validate-template.sh`
- **Claude Code**: [Official Documentation](https://docs.anthropic.com/en/docs/claude-code)
- **MCP Protocol**: [Specification](https://modelcontextprotocol.io)
- **Customization**: Review the [customization guide](customization.md)

The documentation here focuses on understanding and extending the template's capabilities. For basic installation and setup, refer to the [main README](../README.md).