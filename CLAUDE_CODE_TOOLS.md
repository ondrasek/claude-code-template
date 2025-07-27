# Claude Code Built-in Tools Reference

This document lists all tools that Claude Code provides natively, so you don't need to install MCP servers for these capabilities.

## Filesystem Tools

Claude Code has comprehensive filesystem access built-in:

- **Read** - Read any file from the local filesystem
- **Write** - Create or overwrite files
- **Edit** - Make exact string replacements in files
- **MultiEdit** - Make multiple edits to a single file efficiently
- **LS** - List files and directories
- **Glob** - Fast file pattern matching (e.g., `**/*.py`)
- **Grep** - Powerful search using ripgrep

**No need for**: `@modelcontextprotocol/server-filesystem`

## Web Tools

Claude Code can access web content natively:

- **WebSearch** - Search the web and use results to inform responses
- **WebFetch** - Fetch content from URLs and process with AI

**Partially replaces**: `@modelcontextprotocol/server-fetch` (though MCP version may have additional features)

## Development Tools

- **Bash** - Execute bash commands with persistent shell session
  - Supports timeouts
  - Maintains working directory
  - Full shell access
- **Git operations** - Through Bash tool
- **Package management** - npm, pip, cargo, etc. through Bash

**No need for**: Basic shell/command execution MCP servers

## Specialized Tools

- **NotebookRead** - Read Jupyter notebooks
- **NotebookEdit** - Edit Jupyter notebook cells
- **TodoWrite** - Task management and tracking
- **ExitPlanMode** - Planning mode management

## IDE Integration (when available)

- **mcp__ide__getDiagnostics** - Get language diagnostics from VS Code
- **mcp__ide__executeCode** - Execute Python code in Jupyter kernel

## What MCP Servers ARE Still Useful

Only install MCP servers that add capabilities NOT in Claude Code:

### Definitely Useful
- **Memory servers** - Cross-session persistence
- **Database connections** - PostgreSQL, MySQL, Redis, MongoDB
- **API integrations** - Slack, Discord, GitHub API, etc.
- **Specialized services** - LangChain, vector databases, Ollama
- **Browser automation** - Puppeteer, Playwright
- **Cloud services** - AWS, GCP, Azure integrations

### Redundant with Claude Code
- ❌ Filesystem servers
- ❌ Basic shell/command execution
- ❌ Simple file reading/writing
- ❌ Basic web fetching (unless advanced features needed)

## Best Practice

Before adding an MCP server, ask:
1. Does Claude Code already have this capability built-in?
2. Does the MCP server add unique features not available natively?
3. Is it worth the additional complexity and potential conflicts?

When in doubt, start with Claude Code's built-in tools and only add MCP servers when you hit limitations.