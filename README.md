# Claude Code Configuration Template & Dotfiles

[![Version](https://img.shields.io/github/v/release/ondrasek/claude-code-template?label=v2.45.4)](https://github.com/ondrasek/claude-code-template/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A comprehensive template repository and dotfiles setup for Claude Code that automatically configures custom commands, MCP tools, and development environment. Works as a GitHub template repository or dotfiles repository.

## 🚀 Quick Start

### Method 1: Using as GitHub Dotfiles (Recommended for Persistent Setup)

1. Fork this repository and name it `dotfiles`
2. Go to GitHub Settings → Codespaces → Enable "Automatically install dotfiles"
3. Select your dotfiles repository
4. Every new Codespace will automatically have Claude Code configured!

### Method 2: Using as a GitHub Template (Project-Specific Setup)

1. Click "Use this template" on GitHub
2. Create your new repository
3. Clone and start coding - Claude Code will automatically detect the configuration!

### Method 3: Direct Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/claude-code-template.git dotfiles
cd dotfiles

# Run the install script
./install.sh

# Reload your shell
source ~/.bashrc
```

## 🎯 What Gets Installed

When used as dotfiles, the install script automatically:

1. **Installs Claude Code** via npm globally
2. **Sets up configuration** in `~/.claude/`
3. **Creates shell aliases** for quick access
4. **Installs MCP tools** (only non-redundant: memory, inspector)
5. **Configures Git aliases** for Claude-powered commits
6. **Installs uv** for Python project management
7. **Sets up development tools** (ruff, pytest)

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
- **`install.sh`** - Installation script for dotfiles setup

## 🔧 Pre-Configured Features

### Custom Slash Commands
- `/review` - Comprehensive code review
- `/test` - Testing assistance
- `/refactor` - Code improvement
- `/security` - Security audit
- `/langchain-agent` - LangChain development
- `/crewai-crew` - CrewAI multi-agent systems
- `/python-uv` - Python project setup with uv
- `/agent-guide` - Guide for using specialized AI agents
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

Note: Claude Code has built-in filesystem and web tools - no MCP needed!

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
  - Auto-detection of devcontainer/codespace environments for permissions
  - Installation: `./.support/scripts/install-launch-claude.sh`
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

You can also use the Claude Code CLI:
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

- Claude Code's built-in security safeguards
- Sensitive file awareness (`.env`, `*.key`)
- Automatic dangerous operation prevention

## 🧪 Template Validation

Run the validation script to ensure the template structure is complete:

```bash
./validate-template.sh
```

This checks:
- Directory structure and file presence
- All commands and agents are available
- No deprecated configurations remain
- Security features are enabled

## 🎯 Best Practices

1. **Agent coordination is mandatory** - All non-trivial requests automatically use minimum 3+ agents
2. **Context-clean workflows** - Let agents handle complex multi-step processes independently
3. **Documentation updates automatically** - Every code change includes documentation updates in same commit
4. **Memory-first research** - System checks MCP memory before web searches
5. **Keep CLAUDE.md updated** with project-specific information
6. **Use slash commands** for repetitive tasks
7. **Configure MCP tools** for external integrations
8. **Customize agents** for your specific workflow needs
9. **Run verification** after making configuration changes

## 📚 Documentation

### User Guides
- **[Getting Started](docs/getting-started.md)** - Quick setup and essential features
- **[Complete Features Guide](docs/features.md)** - All capabilities and AI agents
- **[Memory System](docs/memory-system.md)** - Persistent context across sessions
- **[Customization Guide](docs/customization.md)** - Adapt for your project

### External Resources
- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
- [MCP Protocol Specification](https://modelcontextprotocol.io)
- [GitHub Dotfiles Documentation](https://docs.github.com/en/codespaces/customizing-your-codespace/personalizing-codespaces-for-your-account#dotfiles)
- [Versioning Guidelines](VERSIONING.md) - How we version this template

## 📄 License

MIT License - see LICENSE file for details.