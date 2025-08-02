# Perplexity MCP Server

A comprehensive Model Context Protocol (MCP) server for integrating Perplexity AI's research capabilities with Claude Code. This server provides real-time web search and research functionality through Perplexity's API, ensuring supply chain security by implementing the integration directly in your codebase.

## Features

- **Real-time Web Search**: Access current information through Perplexity's live web search
- **Multiple Research Tools**: Quick queries, comprehensive research, and deep analysis
- **Model Selection**: Support for all Perplexity models (sonar, sonar-pro, sonar-reasoning, sonar-deep-research)
- **Customizable System Messages**: Tailor response style and behavior
- **Comprehensive Logging**: Optional file logging with configurable levels
- **Environment-based Configuration**: Secure API key management
- **stdio Transport**: Full compatibility with Claude Code
- **Comprehensive Testing**: Full test suite with mocking and edge case coverage

## Quick Start

### 1. Prerequisites

- Python 3.13 or higher
- UV package manager (recommended) or pip
- Perplexity API key ([Get one here](https://www.perplexity.ai/settings/api))

### 2. Installation

```bash
# Navigate to the server directory
cd .support/mcp-servers/perplexity

# Install dependencies with UV (recommended)
uv sync

# Or with pip
pip install -e .
```

### 3. Configuration

Create a `.env` file in the server directory:

```bash
# Copy the example environment file
cp .env.example .env

# Edit with your API key
PERPLEXITY_API_KEY=your_api_key_here
```

### 4. Test the Server

```bash
# Run health check
uv run python -m perplexity_mcp.server health_check

# Or test directly
uv run python -c "
import asyncio
from perplexity_mcp.client import PerplexityClient

async def test():
    client = PerplexityClient()
    result = await client.health_check()
    print('✅ API accessible' if result else '❌ API not accessible')

asyncio.run(test())
"
```

### 5. Integrate with Claude Code

#### Option A: Command Line Setup

Add the server to your Claude Code configuration:

```bash
# Add server to Claude Code (replace with absolute path)
claude mcp add perplexity-research \
  -e PERPLEXITY_API_KEY=your_api_key_here \
  -- uv --directory /absolute/path/to/.support/mcp-servers/perplexity run src/perplexity_mcp/server.py

# Verify server is registered
claude mcp list

# Test the integration
claude mcp inspect perplexity-research
```

#### Option B: Configuration File Setup

Add this configuration to your Claude Code MCP settings file:

```json
{
  "mcpServers": {
    "perplexity-research": {
      "command": "uv",
      "args": [
        "--directory",
        "/absolute/path/to/.support/mcp-servers/perplexity",
        "run",
        "src/perplexity_mcp/server.py"
      ],
      "env": {
        "PERPLEXITY_API_KEY": "your_api_key_here",
        "PERPLEXITY_LOG_LEVEL": "INFO"
      },
      "alwaysAllow": [
        "perplexity_search",
        "perplexity_deep_research", 
        "perplexity_quick_query",
        "list_models",
        "health_check"
      ]
    }
  }
}
```

**Configuration Notes:**
- Replace `/absolute/path/to/.support/mcp-servers/perplexity` with the actual absolute path to your Perplexity MCP server directory
- Add your actual Perplexity API key to the `PERPLEXITY_API_KEY` environment variable
- The `alwaysAllow` list enables auto-approval for all Perplexity tools
- Set `PERPLEXITY_LOG_LEVEL` to `DEBUG` for troubleshooting

#### Verify Installation

```bash
# Check MCP server status
claude mcp list

# Inspect available tools
claude mcp inspect perplexity-research

# Test basic functionality
claude mcp call perplexity-research health_check
```

## Available Tools

### 1. `perplexity_search`
General-purpose research with real-time web search.

**Parameters:**
- `query` (required): Research question or topic
- `model` (optional): Model to use (default: "sonar")
- `system_prompt` (optional): Custom instructions for response style
- `max_tokens` (optional): Maximum response length (default: 1000)
- `temperature` (optional): Response creativity (0.0-2.0, default: 0.7)

**Example:**
```python
# Quick research query
result = await perplexity_search(
    query="What are the latest developments in AI safety research?",
    model="sonar-pro"
)
```

### 2. `perplexity_deep_research`
Comprehensive multi-perspective research for complex topics.

**Parameters:**
- `topic` (required): Main research topic
- `focus_areas` (optional): Specific aspects to investigate
- `time_filter` (optional): Recency filter ("month", "week", "day")
- `domain_filter` (optional): Specific domains to search
- `max_tokens` (optional): Maximum response length (default: 1500)

**Example:**
```python
# Comprehensive research with focus areas
result = await perplexity_deep_research(
    topic="Quantum computing applications",
    focus_areas=["cryptography", "optimization", "machine learning"],
    time_filter="month",
    domain_filter=["arxiv.org", "nature.com"]
)
```

### 3. `perplexity_quick_query`
Fast, concise answers to specific questions.

**Parameters:**
- `question` (required): Specific question to ask
- `domain_filter` (optional): Limit search to specific domains
- `recency_filter` (optional): Time period for results

**Example:**
```python
# Quick factual query
result = await perplexity_quick_query(
    question="What is the current version of Python?",
    domain_filter=["python.org"],
    recency_filter="week"
)
```

### 4. `list_models`
Get information about available Perplexity models.

**Returns:** List of models with descriptions and usage recommendations.

### 5. `health_check`
Verify API connectivity and authentication.

**Returns:** Status message indicating API accessibility.

## Models Guide

### Available Models

- **sonar**: Fast, general-purpose model for most queries
- **sonar-pro**: Enhanced version with better reasoning capabilities
- **sonar-reasoning**: Optimized for logical reasoning and analysis
- **sonar-deep-research**: Most comprehensive model for in-depth research

### Model Selection Guide

| Use Case | Recommended Model | Why |
|----------|------------------|-----|
| Quick facts | `sonar` | Fast response, good for simple queries |
| General research | `sonar-pro` | Better quality with reasonable speed |
| Problem solving | `sonar-reasoning` | Optimized for step-by-step analysis |
| Comprehensive analysis | `sonar-deep-research` | Highest quality, multiple perspectives |

## Configuration

### Environment Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `PERPLEXITY_API_KEY` | Your Perplexity API key | - | Yes |
| `PERPLEXITY_LOG_LEVEL` | Logging level (DEBUG, INFO, WARNING, ERROR) | INFO | No |
| `PERPLEXITY_LOG_FILE` | Path to log file (if desired) | - | No |
| `PERPLEXITY_DEFAULT_MODEL` | Default model for queries | sonar | No |
| `PERPLEXITY_DEFAULT_SYSTEM` | Default system message | (built-in) | No |

### Example Configuration

```bash
# .env file
PERPLEXITY_API_KEY=pplx-abcd1234567890abcdef
PERPLEXITY_LOG_LEVEL=INFO
PERPLEXITY_LOG_FILE=/path/to/logs/perplexity.log
PERPLEXITY_DEFAULT_MODEL=sonar-pro
PERPLEXITY_DEFAULT_SYSTEM="Provide detailed, technical responses with citations."
```

## Development

### Running Tests

```bash
# Run all tests
uv run pytest

# Run with coverage
uv run pytest --cov=perplexity_mcp --cov-report=html

# Run specific test file
uv run pytest tests/test_client.py -v

# Run tests with live API (requires valid API key)
PERPLEXITY_API_KEY=your_key uv run pytest tests/test_integration.py -v
```

### Project Structure

```
.support/mcp-servers/perplexity/
├── src/perplexity_mcp/           # Main package
│   ├── __init__.py               # Package initialization
│   ├── server.py                 # FastMCP server implementation
│   ├── client.py                 # Perplexity API client
│   ├── main.py                   # Entry point
│   └── utils/                    # Utility modules
│       ├── __init__.py
│       └── logging.py            # Logging configuration
├── tests/                        # Test suite
│   ├── __init__.py
│   ├── conftest.py              # Pytest configuration
│   ├── test_client.py           # Client tests
│   ├── test_server.py           # Server tests
│   └── test_logging.py          # Logging tests
├── pyproject.toml               # Project configuration
├── .env.example                 # Environment template
└── README.md                    # This file
```

### Adding New Features

1. **Add API functionality**: Extend `client.py` with new methods
2. **Create MCP tools**: Add new tools in `server.py` using `@mcp.tool()` decorator
3. **Write tests**: Add comprehensive tests in `tests/` directory
4. **Update documentation**: Update this README and docstrings

### Code Quality

The project follows Python best practices:

- **Type hints**: Full type annotation coverage
- **Error handling**: Comprehensive error handling with logging
- **Testing**: High test coverage with mocks and integration tests
- **Documentation**: Detailed docstrings and comments
- **Logging**: Structured logging with configurable levels

## Troubleshooting

### Common Issues

#### 1. Authentication Errors
```
Error: Authentication failed. Check your API key.
```
**Solution:**
- Verify your API key in `.env` file
- Check that the key is valid on Perplexity's website
- Ensure no extra spaces in the environment variable

#### 2. Rate Limit Exceeded
```
Error: Rate limit exceeded. Please try again later.
```
**Solution:**
- Wait before making additional requests
- Consider upgrading your Perplexity plan
- Implement request throttling in your usage

#### 3. Network Connection Issues
```
Error: Network error: Connection timeout
```
**Solution:**
- Check internet connection
- Verify firewall/proxy settings
- Try with different network if available

#### 4. Claude Code Integration Issues
```
Error: Server not responding
```
**Solution:**
- Ensure absolute path is used in Claude Code configuration
- Verify UV is installed and accessible
- Check that all dependencies are installed
- Test server independently first

### Debug Mode

Enable debug logging for troubleshooting:

```bash
# Set environment variable
export PERPLEXITY_LOG_LEVEL=DEBUG

# Or in .env file
PERPLEXITY_LOG_LEVEL=DEBUG
PERPLEXITY_LOG_FILE=/tmp/perplexity-debug.log
```

### Health Check

```bash
# Test API connectivity
uv run python -c "
import asyncio
from perplexity_mcp.server import health_check

async def test():
    result = await health_check()
    print(result)

asyncio.run(test())
"
```

## API Costs and Limits

### Pricing Overview
- **Request-based**: ~$5 per 1,000 requests
- **Token-based**: $0.2-$5 per 1M tokens (model dependent)
- **Pro Plan**: $20/month with $5 monthly credits included

### Rate Limits
- **Free tier**: Limited requests per month
- **Pro tier**: Higher limits with burst capacity
- **Rate limit resets**: Typically monthly

### Cost Optimization Tips
1. **Use appropriate models**: `sonar` for simple queries, `sonar-deep-research` only when needed
2. **Set max_tokens**: Limit response length to control costs
3. **Cache results**: Store frequent query results locally
4. **Monitor usage**: Track API calls and token consumption

## Security Considerations

### API Key Security
- **Never commit** API keys to version control
- **Use environment variables** for configuration
- **Rotate keys regularly** as security best practice
- **Limit API key scope** if possible on Perplexity's platform

### Input Validation
- The server validates and sanitizes all inputs
- **Prompt injection** protection through parameterized queries
- **Rate limiting** on the client side to prevent abuse

### Network Security
- **HTTPS only**: All API communications use secure connections
- **No sensitive data logging**: API keys and sensitive content not logged
- **Error handling**: Errors don't expose sensitive information

## Contributing

This MCP server is part of the Claude Code template project. To contribute:

1. **Follow the existing code style** and patterns
2. **Add comprehensive tests** for new features
3. **Update documentation** including this README
4. **Test with Claude Code** integration before submitting
5. **Follow the project's git protocol** for commits

## License

This project is part of the Claude Code template and follows the same licensing terms.

## Support

For support with this MCP server:

1. **Check this README** for common solutions
2. **Review the logs** with debug mode enabled
3. **Test API connectivity** independently
4. **Check Perplexity API status** and documentation
5. **Report issues** through the main project repository

## Changelog

### v0.1.0 (Initial Release)
- ✅ Perplexity API integration with all models
- ✅ FastMCP server implementation
- ✅ Comprehensive tool set (search, research, quick query)
- ✅ Environment-based configuration
- ✅ Comprehensive test suite
- ✅ Claude Code compatibility with stdio transport
- ✅ Detailed documentation and troubleshooting guide