# Claude Code Configuration Template & Dotfiles

[![Version](https://img.shields.io/github/v/release/ondrasek/claude-code-template)](https://github.com/ondrasek/claude-code-template/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A comprehensive template repository and dotfiles setup for Claude Code that automatically configures custom commands, MCP tools, and development environment. Works as a GitHub template repository or dotfiles repository.

## 🚀 Quick Start

### Method 1: Using as GitHub Dotfiles (Recommended)

1. Fork this repository and name it `dotfiles`
2. Go to GitHub Settings → Codespaces → Enable "Automatically install dotfiles"
3. Select your dotfiles repository
4. Every new Codespace will automatically have Claude Code configured!

### Method 2: Using as a GitHub Template

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
- **`install.sh`** & **`bootstrap.sh`** - Installation scripts for dotfiles setup

## 🔧 Pre-Configured Features

### Custom Slash Commands
- `/review` - Comprehensive code review
- `/test` - Testing assistance
- `/refactor` - Code improvement
- `/security` - Security audit
- `/debug-mcp` - MCP server debugging
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
- **Database servers** - PostgreSQL, Redis, etc. (see examples)
- **API integrations** - LangChain, Ollama, etc. (see examples)
- Additional specialized tools in `.claude/mcp-servers/`

Note: Claude Code has built-in filesystem and web tools - no MCP needed!

### AI-Native Agents
- **Pattern-Based**: Context synthesis, pattern recognition, parallel exploration
- **First-Principles**: Axiom derivation, principle enforcement, invariant protection
- **Documentation**: Automatic documentation synchronization
- **Conflict Resolution**: Handles pattern vs principle conflicts
- **Technology Experts**: Python-expert and more stack-specific agents
- **Implementation Support**: Prompt-engineer for creating framework-specific prompts
- **Critical Analysis**: Critic agent to prevent sycophancy and bad decisions
- Total of 19 specialized agents for different aspects of development

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

1. **Keep CLAUDE.md updated** with project-specific information
2. **Use slash commands** for repetitive tasks
3. **Configure MCP tools** for external integrations
4. **Customize agents** for your specific workflow needs
5. **Run verification** after making configuration changes

## 📚 Resources

- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
- [MCP Protocol Specification](https://modelcontextprotocol.io)
- [GitHub Dotfiles Documentation](https://docs.github.com/en/codespaces/customizing-your-codespace/personalizing-codespaces-for-your-account#dotfiles)
- [Versioning Guidelines](VERSIONING.md) - How we version this template
- **Memory System** - Architectural decisions and patterns stored in MCP memory server for cross-session persistence

## 📄 License

MIT License - see LICENSE file for details.