# MCP Server Configuration Examples

This directory contains example MCP (Model Context Protocol) server configurations for Claude Code.

## Important: Claude Code Built-in Tools

Claude Code already includes many tools natively:
- **Filesystem**: Read, Write, Edit, MultiEdit, LS, Glob, Grep
- **Web**: WebSearch, WebFetch
- **Development**: Bash, Git operations, Jupyter notebooks
- **Task Management**: TodoWrite

**Only add MCP servers that provide functionality NOT already in Claude Code!**

## How to Use These Configurations

1. **Copy configuration to project root**: Copy the desired configuration to `.mcp.json` in your project root
   ```bash
   cp .claude/mcp-servers/example-config.json .mcp.json
   ```

2. **Or use Claude Code CLI**: Add servers individually
   ```bash
   claude mcp add filesystem "npx -y @modelcontextprotocol/server-filesystem ."
   claude mcp add memory "npx -y @modelcontextprotocol/server-memory"
   ```

3. **View current MCP servers**:
   ```bash
   claude mcp list
   ```

## Available Example Configurations

### example-config.json
Basic MCP servers for general development:
- **filesystem**: Local file system access
- **postgres**: PostgreSQL database connection
- **fetch**: Web content fetching
- **memory**: Persistent memory storage

### ai-agent-development.json
Specialized servers for AI/ML development:
- **langchain-server**: LangChain integration
- **python-runner**: Python code execution
- **vector-store**: Vector database for RAG
- **web-search**: Web search capabilities
- **browserbase**: Browser automation
- **ollama**: Local LLM access
- **jupyter**: Jupyter notebook integration
- **redis**: Redis for state management

### mcp-development-tools.json
Tools for MCP server development:
- **mcp-inspector**: Debug MCP communications
- **example servers**: Reference implementations

## Environment Variables

Many MCP servers require environment variables:
```bash
export BROWSERBASE_API_KEY="your-key"
export REDIS_URL="redis://localhost:6379"
export API_KEY="your-api-key"
```

## Project vs User Scope

- **Project scope** (default): Configuration in `.mcp.json` applies only to current project
- **User scope**: Use `--scope user` to install globally
  ```bash
  claude mcp add filesystem "npx -y @modelcontextprotocol/server-filesystem ." --scope user
  ```

## Debugging MCP Servers

1. List all configured servers:
   ```bash
   claude mcp list
   ```

2. Check server status in Claude Code:
   - MCP servers appear in the Tools dropdown when active
   - Error messages appear if servers fail to start

3. View logs:
   - Check Claude Code output for MCP server errors
   - Enable debug mode for more verbose logging

## Security Notes

- Only install MCP servers from trusted sources
- Review server permissions before installation
- Use environment variables for sensitive data (API keys, etc.)
- Project `.mcp.json` files should be reviewed before trusting