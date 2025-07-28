Add alias for claude code (.e.g, mycc) which will:
- Disable verbose mode
- Set default model to sonnet
- Load custom "master prompt" from a .claude.support/master-prompt.md file if it exists
- Enable all sorts of verbose logging using command line switches and environment variables
- Enable MCP server related verbose logging
- Implement custom command to analyze these logs by Claude Code using agents
