# MCP Servers Configuration

This directory contains centralized MCP (Model Context Protocol) server configurations and implementations for the Claude Code template project.

## Configuration File

The `mcp-config.json` file provides centralized configuration for all MCP servers in this repository. This file is automatically detected and used by the `launch-claude.sh` script.

### Configuration Structure

```json
{
  "mcpServers": {
    "server-name": {
      "command": "executable",
      "args": ["arg1", "arg2"],
      "env": {
        "VARIABLE": "${ENV_VAR:-default_value}"
      },
      "alwaysAllow": ["tool1", "tool2"],
      "description": "Server description"
    }
  },
  "globalSettings": {
    "timeout": 30000,
    "retries": 3,
    "logLevel": "info"
  }
}
```

## Environment Variables

Environment variables can be configured in your project root `.env` file. See `.env.example` for a template.

### Required Variables

- `PERPLEXITY_API_KEY`: API key for Perplexity research server

### Optional Variables

- `PERPLEXITY_LOG_LEVEL`: Log level for Perplexity server (default: INFO)
- `PERPLEXITY_DEFAULT_MODEL`: Default model for Perplexity queries (default: sonar)
- `MCP_LOG_LEVEL`: Global MCP log level (default: info)
- `MCP_ENABLE_TELEMETRY`: Enable MCP telemetry (default: false)
- `PROJECT_ENV`: Environment type (development/production)

## Automatic Configuration Loading

The `launch-claude.sh` script automatically detects and loads MCP configuration from:

1. `.support/mcp-servers/mcp-config.json` (preferred, centralized)
2. `.mcp.json` (legacy, project root)

## Available MCP Servers

### Perplexity Research Server (`perplexity-research`)

Provides real-time web search and research capabilities through Perplexity AI.

**Location**: `./perplexity/`

**Tools**:
- `perplexity_search`: General-purpose research with real-time web search
- `perplexity_deep_research`: Comprehensive multi-perspective research
- `perplexity_quick_query`: Fast, concise answers to specific questions
- `list_models`: Get information about available Perplexity models
- `health_check`: Verify API connectivity and authentication

**Setup**:
1. Get a Perplexity API key from [perplexity.ai/settings/api](https://www.perplexity.ai/settings/api)
2. Add `PERPLEXITY_API_KEY=your_key_here` to your project root `.env` file
3. Install dependencies: `cd perplexity && uv sync`

## Usage

### With launch-claude.sh (Recommended)

```bash
# The script automatically loads MCP configuration
launch-claude "Search for the latest AI safety research"
```

### Direct Claude Code Usage

```bash
# Use the centralized configuration
claude --mcp-config .support/mcp-servers/mcp-config.json "Your query"
```

### Environment Configuration

```bash
# Copy environment template
cp .support/mcp-servers/.env.example .env

# Edit with your API keys
nano .env

# The launch-claude.sh script will automatically load these variables
```

## Adding New MCP Servers

1. **Create server directory**: Add your MCP server in `.support/mcp-servers/your-server-name/`

2. **Update configuration**: Add server configuration to `mcp-config.json`:
   ```json
   {
     "mcpServers": {
       "your-server-name": {
         "command": "your-executable",
         "args": ["arguments"],
         "env": {
           "YOUR_API_KEY": "${YOUR_API_KEY}"
         },
         "alwaysAllow": ["tool1", "tool2"],
         "description": "Your server description"
       }
     }
   }
   ```

3. **Update environment template**: Add required environment variables to `.env.example`

4. **Update documentation**: Add server information to this README

## Security Considerations

- **Never commit API keys**: Use environment variables and add `.env` to `.gitignore`
- **File permissions**: Set appropriate permissions on `.env` files (`chmod 600 .env`)
- **Environment variable validation**: The launch script validates and masks sensitive values
- **Path resolution**: All paths in configuration are resolved relative to project root

## Troubleshooting

### Configuration Not Loading

Check that the configuration file exists and is valid JSON:
```bash
python3 -m json.tool .support/mcp-servers/mcp-config.json
```

### Environment Variables Not Set

Verify your `.env` file is in the project root and contains required variables:
```bash
# Check if variables are loaded
launch-claude --debug "test" | grep -i "environment"
```

### MCP Server Not Starting

Enable debug mode to see detailed MCP server logs:
```bash
launch-claude --mcp-debug "test query"
```

### Permission Issues

For devcontainer/codespace environments, the script auto-detects and enables skip permissions:
```bash
launch-claude --skip-permissions "test query"
```

## File Structure

```
.support/mcp-servers/
├── mcp-config.json           # Centralized MCP configuration
├── .env.example              # Environment variable template
├── README.md                 # This documentation
├── perplexity/               # Perplexity research MCP server
│   ├── src/                  # Server source code
│   ├── tests/                # Server tests
│   ├── pyproject.toml        # Python dependencies
│   └── README.md             # Server-specific documentation
└── [future-servers]/         # Additional MCP servers
```