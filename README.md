# Claude Code Configuration Repository

[![Version](https://img.shields.io/github/v/release/ondrasek/claude-code-template?label=v2.53.0)](https://github.com/ondrasek/claude-code-template/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A comprehensive configuration repository for Claude Code containing custom commands, MCP tools, specialized agents, and development configurations. This repository provides manually installable configurations that you can copy to your local Claude Code setup.

## 🚀 Manual Setup

### Prerequisites

1. **Claude Code installed**: Ensure you have Claude Code CLI installed
2. **Git access**: Clone or download this repository
3. **File system access**: Ability to copy files to your home directory

### Quick Setup

1. **Clone this repository**:
   ```bash
   git clone https://github.com/yourusername/claude-code-template.git
   cd claude-code-template
   ```

2. **Copy Claude Code configuration**:
   ```bash
   # Copy the main configuration directory
   cp -r .claude/ ~/.claude/
   
   # Verify the configuration was copied
   ls -la ~/.claude/
   ```

3. **Set up environment variables**:
   ```bash
   # Add your API keys to shell configuration
   echo 'export CLAUDE_API_KEY="your-api-key-here"' >> ~/.bashrc
   source ~/.bashrc
   ```

4. **Test the setup**:
   ```bash
   # Start Claude Code and test
   claude
   # Try: /review, /stacks, /agents-guide
   ```

**📖 For detailed instructions, see: [Manual Setup Guide](docs/manual-setup-guide.md)**  
**📋 For all setup options, see: [Manual Setup Index](docs/manual-setup-index.md)**

### Future CLI Tool

A dedicated CLI setup tool is planned for future development to automate this configuration process. For now, manual copying is the recommended approach as it gives you full control over what gets configured and where.

## 🎯 What You Can Configure

### Claude Code Configuration
By copying the `.claude/` directory, you get:

1. **Custom Slash Commands** - Pre-built commands for common development tasks
2. **Specialized AI Agents** - 19+ agents for different aspects of development
3. **Technology Stacks** - Guidelines for specific tech stacks (Python, etc.)
4. **MCP Server Configurations** - Setup for memory, perplexity, and other tools
5. **Automation Hooks** - Security scanning, formatting, and validation
6. **Settings Configuration** - Optimized Claude Code settings

### Support Files
By copying the `.support/` directory, you get:

1. **Enhanced CLI Tools** - launch-claude wrapper with comprehensive logging
2. **Prompts and Instructions** - Reusable prompts and development guidelines
3. **TODO Management** - Organized task tracking system
4. **MCP Server Source** - Complete MCP server implementations
5. **Documentation Templates** - Structured documentation examples
6. **Log Management** - Organized logging and diagnostics system

## 📁 Repository Structure

This template follows Claude Code's expected structure and GitHub dotfiles conventions:

- **`.claude/`** - Claude Code configuration directory
  - `commands/` - Custom slash commands (/review, /test, etc.)
  - `agents/` - Specialized AI agents
  - `stacks/` - Technology-specific guidelines
  - `prompts/` - Reusable agent prompts
  - `hooks/` - Automation scripts
  - `mcp-servers/` - MCP tool configurations
- **`.claude/settings.json`** - Main configuration (auto-loaded by Claude Code)
- **`CLAUDE.md`** - Project guidelines for Claude Code
- **Documentation** - Usage guides and feature documentation

## 🔧 Pre-Configured Features

### Custom Slash Commands
- `/review` - Comprehensive code review
- `/test` - Testing assistance
- `/refactor` - Code improvement
- `/security` - Security audit
- `/langchain-agent` - LangChain development
- `/crewai-crew` - CrewAI multi-agent systems
- `/python-uv` - Python project setup with uv
- `/agents-guide` - Guide for using specialized AI agents
- `/doc-update` - Update documentation to match code changes
- `/stacks` - List available technology stacks
- `/use-python` - Activate Python development guidelines
- `/create-prompt` - Generate optimized prompts for AI frameworks
- `/discuss` - Get critical analysis of ideas and proposals

### MCP Tools (Non-Redundant Only)
- **memory** - Persistent session memory (cross-session state)
- **perplexity** - Real-time web search and research (v2.45.2: Enhanced STDIO protocol compliance)
- **Database servers** - PostgreSQL, Redis, etc. (see examples)
- **API integrations** - LangChain, Ollama, etc. (see examples)
- Additional specialized tools in `.claude/mcp-servers/`

**Recent v2.45.2 Improvements:**
- **Perplexity MCP Server**: Complete logging system overhaul for enhanced reliability
  - Full STDIO protocol compliance prevents interference with MCP communication
  - Silent operation mode when logging is disabled or unavailable
  - Improved error handling and configuration management
  - Enhanced stability for real-time research workflows

Note: Claude Code has built-in filesystem and web tools - these MCP tools provide additional capabilities!

### AI-Native Agents
- **Mandatory coordination**: Minimum 3+ agents used for all non-trivial requests
- **Context-clean delegation**: Complex tasks handled by agents, main context stays focused
- **Pattern-Based**: Context synthesis, pattern recognition, parallel exploration
- **First-Principles**: Axiom derivation, principle enforcement, invariant protection
- **Documentation**: Automatic documentation synchronization with every code change
- **Conflict Resolution**: Handles pattern vs principle conflicts
- **Technology Experts**: Python-expert and more stack-specific agents
- **Implementation Support**: Prompt-engineer for creating framework-specific prompts
- **Critical Analysis**: Critic agent to prevent sycophancy and bad decisions
- **Baseline combination**: researcher + patterns + critic (minimum standard)
- Total of 19 specialized agents for different aspects of development

### Enhanced CLI Tools
- **launch-claude wrapper** - Enhanced Claude Code wrapper with comprehensive logging defaults
  - All logging enabled by default (verbose, debug, MCP debug, save logs)
  - Sonnet model as default for optimal performance
  - Master prompt loading from `.support/prompts/master-prompt.md`
  - Secure .env file loading with validation and sensitive value masking
  - Advanced logging with timestamped files and log analysis
  - Auto-detection of different environments for permissions
  - Manual installation: Copy and run `./.support/scripts/install-launch-claude.sh`
  - Full documentation: [launch-claude Usage Guide](docs/launch-claude-usage.md)

### Automation Hooks
- **Pre-read security** - Scans for sensitive data
- **Post-edit formatting** - Auto-formats code
- **Prompt validation** - Checks for dangerous commands

## 📝 Customization

### Adding New Commands

Create a new file in `.claude/commands/`:

```markdown
# my-command.md

Your custom prompt here...
```

Use with: `/my-command`

### Configuring MCP Tools

MCP servers are configured in `.mcp.json`:

```json
{
  "mcpServers": {
    "your-tool": {
      "command": "npx",
      "args": ["-y", "@your/mcp-server"],
      "env": {
        "API_KEY": "${YOUR_API_KEY}"
      }
    }
  }
}
```

After copying the configuration, you can also use the Claude Code CLI:
```bash
claude mcp add your-tool "npx -y @your/mcp-server"
```

### Project-Specific Guidelines

Update `CLAUDE.md` with your project's:
- Architecture decisions
- Coding standards
- Development workflows
- Testing requirements

## 🛡️ Security Features

### Configuration Security
- **No Hardcoded Secrets** - All configurations use environment variables
- **Template Safety** - No sensitive data included in configuration files
- **Secure Defaults** - Conservative security settings in all configurations

### Built-in Security Safeguards
- Claude Code's built-in security protections
- Sensitive file awareness (`.env`, `*.key`)
- Automatic dangerous operation prevention
- Pre-read security scanning for sensitive data

## 🧪 Configuration Validation

After copying the configuration, you can validate it works properly:

```bash
# Check that Claude Code can find your configuration
claude config show

# Test a custom command
claude /stacks

# Verify MCP tools are working
claude mcp list
```

This verifies:
- Configuration files are in the correct location
- All commands and agents are available
- MCP tools are properly configured
- No configuration errors exist

## 🔧 Configuration Troubleshooting

### Common Issues and Solutions

**Configuration Not Found**:
```bash
# Check if configuration was copied correctly
ls -la ~/.claude/

# Verify Claude Code can find the config
claude config show
```

**Commands Not Working**:
```bash
# Check if commands directory exists
ls -la ~/.claude/commands/

# Test a specific command
claude /stacks
```

**MCP Tools Not Available**:
```bash
# Check MCP configuration
claude mcp list

# Verify MCP servers configuration
cat ~/.claude/mcp-servers/mcp-config.json
```

**Permission Issues**:
```bash
# Fix permissions if needed
chmod -R 755 ~/.claude/

# Check file ownership
ls -la ~/.claude/
```

## 🎯 Best Practices

1. **Agent coordination is mandatory** - All non-trivial requests automatically use minimum 3+ agents
2. **Context-clean workflows** - Let agents handle complex multi-step processes independently
3. **Documentation updates automatically** - Every code change includes documentation updates in same commit
4. **Memory-first research** - System checks MCP memory before web searches
5. **Secure secret management** - Use environment variables, never hardcode credentials
6. **Keep CLAUDE.md updated** with project-specific information
7. **Use slash commands** for repetitive tasks
8. **Configure MCP tools** for external integrations
9. **Customize agents** for your specific workflow needs
10. **Run verification** after making configuration changes
11. **Validate configuration regularly** - Use `claude config show` to verify your setup

## 📚 Documentation

### User Guides
- **[Getting Started](docs/getting-started.md)** - Quick setup and essential features
- **[Complete Features Guide](docs/features.md)** - All capabilities and AI agents
- **[Memory System](docs/memory-system.md)** - Persistent context across sessions
- **[Customization Guide](docs/customization.md)** - Adapt for your project

### Manual Setup Guides
- **[Manual Setup Guide](docs/manual-setup-guide.md)** - Complete step-by-step manual installation
- **[Detailed Copying Instructions](docs/copying-instructions.md)** - File-by-file copying guide
- **[Configuration Reference](docs/configuration-reference.md)** - Comprehensive configuration documentation
- **[Migration Guide](docs/migration-guide.md)** - Transition from automated to manual setup

### External Resources
- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
- [MCP Protocol Specification](https://modelcontextprotocol.io)
- [GitHub Dotfiles Documentation](https://docs.github.com/en/codespaces/customizing-your-codespace/personalizing-codespaces-for-your-account#dotfiles)
- [Versioning Guidelines](VERSIONING.md) - How we version this template

## 📄 License

MIT License - see LICENSE file for details.