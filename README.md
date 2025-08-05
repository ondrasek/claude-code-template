# Claude Code Forge

[![Version](https://img.shields.io/github/v/release/ondrasek/claude-code-forge)](https://github.com/ondrasek/claude-code-forge/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A professional CLI tool for automated Claude Code configuration management. Install custom agents, commands, MCP tools, and development configurations with a single command.

**Transform your Claude Code experience with:**
- 16 specialized AI agents for comprehensive development support
- Custom slash commands (`/stacks`, `/fix`, `/discuss`) for instant assistance
- Integrated MCP tools for memory and web research
- Automated project structure and configuration management
- Zero-configuration setup with intelligent backup system

> **Note**: This is a complementary tool designed to enhance your Claude Code experience. It works alongside the official Claude Code CLI to provide advanced configuration management and specialized AI agents.

## 📖 Table of Contents

### Getting Started
- [⚡ Quick Start](#-quick-start)
- [📋 Installation Verification](#-installation-verification)
- [🤔 FAQ](#-frequently-asked-questions)

### Reference
- [📋 Available Commands](#-available-commands)
- [🎯 What Gets Installed](#-what-gets-installed)
- [🔧 Configuration Management](#-configuration-management)

### Advanced
- [🛡️ Security & Safety](#-security--safety)
- [🎨 Customization](#-customization)
- [🚀 Development](#-development)

### Support
- [🔧 Troubleshooting](#-troubleshooting)
- [📚 Documentation](#-documentation)
- [📞 Support](#-support)

## ⚡ Quick Start

### 1. Prerequisites
- [Claude Code CLI](https://claude.ai/code) installed and working
- Python 3.11+ (for uvx support)
- Internet connection for configuration downloads

**Verify your setup:**
```bash
# Check Claude Code is installed
claude --version

# Check Python version (should be 3.11+)
python3 --version

# Check uvx is available
uvx --version
```

> **Troubleshooting Prerequisites:**
> - **Claude Code not found:** Install from [claude.ai/code](https://claude.ai/code)
> - **Python version too old:** Install Python 3.11+ from [python.org](https://python.org)
> - **uvx not available:** Upgrade Python or install with `pip install --user pipx`

### 2. Installation

```bash
# One command installs everything
uvx claude-code-forge init
```

### 3. Quick Verification

```bash
# Check agents (should show 16 agents)
claude /agents/audit

# Test custom commands
claude /stacks
```

🎉 **Success!** Your Claude Code now includes 16 specialized agents, custom commands, and MCP tools.

[📋 See detailed verification steps](#-installation-verification)

---

## ⚡ Quick Reference

**Most Used Commands:**
```bash
# Full setup
uvx claude-code-forge init

# Stack analysis  
claude /stacks

# Issue help
claude /fix "problem description"

# Critical analysis
claude /discuss "topic"
```

**Key Agents:** `researcher` • `context` • `patterns` • `principles` • `critic` • `conflicts`

**[📖 Full Documentation](#-table-of-contents) • [❓ FAQ](#-frequently-asked-questions) • [🔧 Troubleshooting](#-troubleshooting)**

---

## 📋 Installation Verification

**Expected Results After Installation:**
- ✅ 16 agents listed in audit (6 foundation + 10 specialist)
- ✅ `/stacks` command responds with technology analysis
- ✅ Tools include memory, perplexity, and others
- ✅ `.claude/` and `.support/` directories exist
- ✅ Configuration files present in `.claude/agents/`, `.claude/commands/`

**Detailed verification:**
```bash
# Check project structure was created
ls -la .claude/ .support/

# Confirm backup was created (if upgrading)
ls -la .support/backups/

# Test comprehensive tool access
claude "what tools do you have access to?"
```


## 📋 Available Commands

| 🛠️ Command | 📝 Description | ⚡ Usage |
|------------|----------------|----------|
| `init` | Initialize all configurations | `uvx claude-code-forge init` |
| `factory-reset` | Reset to defaults with backup | `uvx claude-code-forge factory-reset` |
| `upgrade` | Update to latest configurations | `uvx claude-code-forge upgrade` |
| `agent-ecosystem` | Generate project-specific agents | `uvx claude-code-forge agent-ecosystem` |
| `troubleshoot` | Debug Claude Code and MCP issues | `uvx claude-code-forge troubleshoot` |
| `master-prompt` | Craft optimized master prompts | `uvx claude-code-forge master-prompt` |

### Command Details

#### `init`
Initializes all custom configurations for Claude Code:
- Installs 16 specialized AI agents (6 foundation + 10 specialist)
- Sets up custom slash commands
- Configures MCP servers (memory, perplexity, etc.)
- Creates project structure and guidelines
- Optionally backs up existing configuration to `.support/backups`

#### `factory-reset`
Resets all configurations to the default state:
- Creates timestamped backup (e.g., `20250729-14h32m44-factory-reset`)
- Removes current configurations
- Installs fresh default configurations
- Preserves backup in `.support/backups` directory

#### `upgrade`
Updates configurations to the latest available version:
- Downloads latest release from GitHub
- Preserves local customizations where possible
- Creates backup before upgrading

#### `agent-ecosystem`
**Purpose:** Generate project-specific agents
- Analyzes your repository structure and technologies
- Creates custom agents tailored to your project
- Integrates with existing agent infrastructure

#### `troubleshoot`
**Purpose:** Debug configuration and connectivity issues
- Launches AI-assisted log analysis
- Diagnoses Claude Code and MCP problems
- Provides step-by-step solutions

#### `master-prompt`
**Purpose:** Create optimized AI prompts
- Interactive prompt engineering wizard
- Incorporates web search and research capabilities
- Follows prompt engineering best practices

## 🎯 What Gets Installed

### AI Agents (16 Total)

**Foundation Agents (6)** - Core development support:

| Agent | Capability |
|-------|------------|
| `researcher` | External information discovery and best practices |
| `context` | Internal architecture understanding and documentation |
| `patterns` | Code quality analysis and pattern detection |
| `principles` | Design principle validation (SOLID, DRY, KISS) |
| `critic` | Risk assessment and objective code review |
| `conflicts` | Conflict resolution and decision mediation |

**Specialist Agents (10)** - Advanced workflows:

| Agent | Capability |
|-------|------------|
| `git-workflow` | Git operations, branching, and release management |
| `stack-advisor` | Technology stack guidance and modernization |
| `code-cleaner` | Code refactoring, cleanup, and optimization |
| `performance-optimizer` | Performance analysis and bottleneck resolution |
| `test-strategist` | Testing strategy, coverage, and quality assurance |
| `todo-manager` | Task management and project organization |
| `options-analyzer` | Decision analysis and trade-off evaluation |
| `constraint-solver` | Constraint resolution and requirement balancing |
| `meta-programmer` | Code generation and meta-programming tasks |
| `prompt-engineer` | AI prompt optimization and agent development |

### Custom Slash Commands

| Command | Purpose |
|---------|----------|
| `/stacks` | Technology stack analysis and recommendations |
| `/fix` | Issue resolution and debugging assistance |
| `/discuss` | Critical analysis and architectural discussions |
| `/performance` | Performance optimization suggestions |

**Agent Management:**
- `/agents/audit` - List all available agents
- `/agents/create` - Create new custom agents
- `/agents/guide` - Agent usage documentation

**TODO Management:**
- `/todo/next` - Get next priority task
- `/todo/create` - Create new TODO items
- `/todo/review` - Review and update TODO status

### MCP Tools

| Tool | Purpose |
|------|----------|
| **memory** | Persistent session memory across Claude Code sessions |
| **perplexity** | Real-time web search and research capabilities |
| **custom tools** | Additional specialized tools via `.mcp.json` configuration |

### Project Structure

```
.claude/                 # Claude Code configuration
├── agents/             # AI agent definitions
├── commands/           # Custom slash commands
├── stacks/             # Technology-specific guidelines
├── mcp-servers/        # MCP server configurations
└── settings.json       # Claude Code settings

.support/               # Supporting infrastructure
├── prompts/            # Reusable prompt templates
├── instructions/       # Development guidelines
├── todos/              # Task tracking and management
├── mcp-servers/        # MCP server source code
├── logs/               # Diagnostics and troubleshooting
└── backups/            # Automatic configuration backups

CLAUDE.md              # Project operational guidelines
```

## 🤔 Frequently Asked Questions

### What is the relationship to Claude Code?
**Claude Code Forge is a companion tool** that enhances the official Claude Code CLI:
- **Claude Code**: The official desktop application and CLI from Anthropic
- **Claude Code Forge**: This tool that adds specialized agents, commands, and configurations
- **Together**: They provide a powerful development environment with AI-powered assistance

### Do I need both?
Yes! Claude Code Forge requires Claude Code to be installed first:
1. Install Claude Code from [claude.ai/code](https://claude.ai/code)
2. Run `uvx claude-code-forge init` to add enhancements
3. Use enhanced Claude Code with new agents and commands

### Is this official?
No, Claude Code Forge is a community tool that works with the official Claude Code CLI. It's designed to be safe and non-intrusive.

### What happens to my existing configuration?
Your existing configuration is automatically backed up to `.support/backups/` before any changes. You can restore it anytime.

## 🔧 Configuration Management

### Automatic Backup System
- **Location:** `.support/backups/` with timestamped folders
- **Format:** `YYYYMMDD-HHhMMmSS-reason` (e.g., `20250729-14h32m44-factory-reset`)
- **Content:** Preserves all customizations for manual restoration
- **Frequency:** Before every configuration change

### Git Integration
- **Auto-managed `.gitignore`** for backup and log directories
- **Safe modification scope:** Only touches `.claude/`, `.support/`, and `CLAUDE.md`
- **Version control friendly:** Configurations can be committed and shared

### Directory Structure Management
- **`.claude/`** - Primary Claude Code configuration
- **`.support/`** - Infrastructure and backup files
- **`CLAUDE.md`** - Project operational guidelines (backed up before changes)

## 🛡️ Security & Safety

| Security Feature | Implementation |
|-----------------|----------------|
| **Secret Management** | Environment variables only, no hardcoded credentials |
| **Secure Defaults** | Conservative security settings and permissions |
| **Change Protection** | Automatic backups before any modifications |
| **Source Integrity** | Configurations downloaded from verified GitHub releases |
| **Isolated Operation** | Only modifies designated directories (`.claude/`, `.support/`) |

## 📚 Documentation

### Built-in Documentation
- **Agent Documentation:** Detailed guides in `.claude/agents/` for each AI agent
- **Command Reference:** Usage examples in `.claude/commands/` for all slash commands
- **Technology Guides:** Stack-specific best practices in `.claude/stacks/`
- **Troubleshooting:** Common issues and solutions in `.support/logs/`

## 🔧 Troubleshooting

> **💡 Quick Help:** Run `uvx claude-code-forge troubleshoot` for AI-assisted debugging

### Common Issues & Solutions

#### Installation Problems

**Problem:** `uvx: command not found`
```bash
# Check current Python version
python3 --version
# If version < 3.13, install Python 3.13+ from python.org
# uvx is included with Python 3.13+ automatically
```

**Problem:** `claude: command not found`
```bash
# Install Claude Code CLI from https://claude.ai/code
# Follow the installation instructions for your platform
# Restart terminal after installation
```

**Problem:** Permission denied errors
```bash
# Solution: Check file permissions
ls -la ~/.claude/
# Ensure you own the .claude directory
```

#### Configuration Issues

**Problem:** Agents not showing up
```bash
# Check installation completed
uvx claude-code-forge init --verbose

# Verify agents directory
ls -la .claude/agents/

# Restart Claude Code application
```

**Problem:** Commands not working
```bash
# Check commands directory
ls -la .claude/commands/

# Verify Claude Code settings
cat .claude/settings.json
```

**Problem:** MCP tools not available
```bash
# Check MCP configuration
cat .mcp.json

# Verify MCP servers
ls -la .support/mcp-servers/
```

#### Advanced Troubleshooting

**Interactive Debugging:**
```bash
# Launch AI-assisted troubleshooting
uvx claude-code-forge troubleshoot
```

**Manual Diagnostics:**
```bash
# Check logs for errors
ls -la .support/logs/

# Verify all components
uvx claude-code-forge init --dry-run

# Reset to clean state if needed
uvx claude-code-forge factory-reset
```

**Getting Help:**
- Check existing configurations: `claude /agents/guide`
- Review documentation: Files in `.support/instructions/`
- Reset if corrupted: `uvx claude-code-forge factory-reset`
- Open issue: [GitHub Issues](https://github.com/ondrasek/claude-code-forge/issues)

## 🎨 Customization

### Adding Your Own Agents
```bash
# Create custom agent
cat > .claude/agents/my-agent.md << 'EOF'
# My Custom Agent

You are a specialized agent for [specific task].

## Capabilities
- [List capabilities]

## Usage
- [Usage instructions]
EOF
```

### Creating Custom Commands
```bash
# Create custom slash command
cat > .claude/commands/my-command.md << 'EOF'
# /my-command

Description: [What this command does]

Usage: `/my-command [parameters]`

[Command implementation]
EOF
```

### Project-Specific Guidelines
```bash
# Update project guidelines
# Edit CLAUDE.md with your project's specific context
```

### Additional MCP Configuration
```bash
# Add more MCP servers to .mcp.json
# Follow existing patterns in the file
```

## 🚀 Development

### DevContainer Integration
Claude Code Forge is available as a devcontainer feature for seamless development environment integration.

### Local Development Setup
```bash
# Clone and setup for development
git clone https://github.com/ondrasek/claude-code-forge.git
cd claude-code-forge

# Install in development mode
pip install -e .

# Run local version
python -m claude_code_forge init

# Run tests (if available)
python -m pytest
```

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to:
- Report bugs or request features via [GitHub Issues](https://github.com/ondrasek/claude-code-forge/issues)
- Submit pull requests for improvements
- Share your custom agents and configurations
- Improve documentation and examples

## 📞 Support

- **Documentation:** Check the `docs/` directory for comprehensive guides
- **Issues:** [GitHub Issues](https://github.com/ondrasek/claude-code-forge/issues) for bug reports
- **Discussions:** [GitHub Discussions](https://github.com/ondrasek/claude-code-forge/discussions) for questions
- **AI-Assisted Help:** Use `uvx claude-code-forge troubleshoot` for interactive debugging