# Claude Code Forge

[![Version](https://img.shields.io/github/v/release/ondrasek/claude-code-forge?label=v2.57.0)](https://github.com/ondrasek/claude-code-forge/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Transform your Claude Code CLI into a development productivity powerhouse.** This professional tool automatically configures 16 specialized AI agents, custom commands, and MCP integrations that supercharge your coding workflow.

## Why Claude Code Forge?

**Before:** Basic Claude Code with generic prompts and limited capabilities
```bash
$ claude "help me debug this code"
# Generic responses, no specialized knowledge, manual context switching
```

**After:** Specialized agent ecosystem with targeted expertise
```bash
$ claude /fix "memory leak in async handler"
# Launches performance-optimizer agent with debugging protocols
$ claude /stacks
# Analyzes your tech stack with architectural insights
$ claude /todo/next
# Intelligently prioritizes your development tasks
```

**Result:** 10x faster development cycles with AI agents that understand your codebase, architecture patterns, and development workflow.

## 📋 Table of Contents

- [Quick Start](#-quick-start)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Installation Verification](#installation-verification)
- [Available Commands](#-available-commands)
- [What Gets Installed](#-what-gets-installed)
- [Advanced Configuration](#-advanced-configuration)
- [Troubleshooting](#%EF%B8%8F-troubleshooting)
- [Documentation & Reference](#-documentation--reference)
- [Development & Contributing](#-development--contributing)
- [Frequently Asked Questions](#-frequently-asked-questions)
- [License](#-license)

## 🚀 Quick Start

### Prerequisites

Before using Claude Code Forge, you need:

#### 1. Claude Code CLI (Required)
The official Claude CLI tool from Anthropic. [Install Claude Code CLI](https://claude.ai/code) first.

**Verify Claude Code is installed:**
```bash
claude --version
# Expected output: claude-cli version X.X.X
```

#### 2. Python 3.8+ with uvx (Required)
Install uvx for running Python applications without installation:

```bash
# Install uvx (if not already installed)
pip install uvx

# Verify uvx is working
uvx --version
# Expected output: uvx X.X.X
```

#### 3. Internet Connection
Required for downloading configurations from GitHub releases.

### Installation

**Step 1: Initialize Configuration**
```bash
# Run the initialization (no installation required)
uvx claude-code-forge init
```

**Step 2: Verify Installation Success**
```bash
# Test custom command (should show technology analysis)
claude /stacks

# List installed agents (should show 16 agents)
ls .claude/agents/

# Check agent functionality
claude /agents/audit
```

**Expected Success Indicators:**
- ✅ `.claude/` directory created with agents and commands
- ✅ `.support/` directory created with project structure
- ✅ `/stacks` command returns technology stack analysis
- ✅ `claude /agents/audit` shows all 16 agents installed
- ✅ `CLAUDE.md` file created with project guidelines

### Installation Verification

Run this complete verification sequence:

```bash
# 1. Verify core functionality
claude /stacks
# Should return: "Analyzing technology stack..." with detailed output

# 2. Test agent ecosystem
claude /agents/audit
# Should list all 16 agents with status

# 3. Verify MCP integration
claude "test memory functionality"
# Should demonstrate persistent memory capabilities

# 4. Check directory structure
ls -la .claude/ .support/
# Should show complete directory structure as documented below
```

If any verification step fails, see the [Troubleshooting](#-troubleshooting) section below.

## 📋 Available Commands

```bash
# Core commands
uvx claude-code-forge init              # Initialize all configurations
uvx claude-code-forge factory-reset     # Reset to defaults with backup
uvx claude-code-forge upgrade           # Update to latest configurations

# Advanced features
uvx claude-code-forge agent-ecosystem   # Generate project-specific agents
uvx claude-code-forge troubleshoot      # Debug Claude Code and MCP issues
uvx claude-code-forge master-prompt     # Craft optimized master prompts
```

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
Analyzes your repository and generates project-specific agents:
- Runs Claude Code with specialized prompt for ecosystem analysis
- Builds repository-specific agents and commands
- Integrates with existing agent infrastructure

#### `troubleshoot`
Helps debug Claude Code and MCP issues:
- Launches log analysis with Claude
- Diagnoses configuration problems
- Provides solutions for common issues

#### `master-prompt`
Interactive wizard for creating optimized master prompts:
- Uses prompt engineering best practices
- Leverages web search and fetch capabilities
- Helps craft effective prompts for your use case

## 🎯 What Gets Installed

### AI Agents (16 total)
**Foundation Agents (6)**:
- `researcher` - External information discovery
- `context` - Internal architecture understanding
- `patterns` - Code quality and pattern detection
- `principles` - Design principle validation
- `critic` - Risk assessment and validation
- `conflicts` - Conflict resolution

**Specialist Agents (10)**:
- `git-workflow` - Git operations and workflow
- `stack-advisor` - Technology stack guidance
- `code-cleaner` - Code refactoring and cleanup
- `performance-optimizer` - Performance analysis
- `test-strategist` - Testing strategy
- `todo-manager` - Task management
- `options-analyzer` - Decision analysis
- `constraint-solver` - Constraint resolution
- `meta-programmer` - Meta-programming tasks
- `prompt-engineer` - AI prompt optimization

### Custom Slash Commands
- `/stacks` - Technology stack analysis
- `/fix` - Issue resolution
- `/discuss` - Critical analysis
- `/performance` - Performance optimization
- Agent management commands (`/agents/audit`, `/agents/create`, `/agents/guide`)
- TODO management commands (`/todo/next`, `/todo/create`, `/todo/review`)

### MCP (Model Context Protocol) Integration

**What is MCP?** The Model Context Protocol enables Claude to access external tools and data sources in real-time, extending capabilities beyond the base model.

**Included MCP Servers:**
- **memory** - Persistent session memory across conversations
  - Remembers project context, decisions, and preferences
  - Automatically maintains conversation history
  - Enables continuity across multiple Claude sessions

- **perplexity** - Real-time web search and research capabilities
  - Live access to current information and documentation
  - Technical research and stack analysis
  - Up-to-date library and framework information

**How MCP Works with Agents:**
```bash
# Agent uses MCP memory to recall previous decisions
claude /fix "the authentication bug from yesterday"
# Memory MCP provides context from previous session

# Agent uses MCP perplexity for current information
claude /stacks "evaluate latest React 19 features"
# Perplexity MCP fetches latest React 19 documentation
```

**Configuration:** Additional MCP servers can be configured via `.mcp.json`

### Project Structure
```
.claude/
├── agents/          # AI agent definitions
├── commands/        # Slash commands
├── stacks/          # Technology guidelines
├── mcp-servers/     # MCP configurations
└── settings.json    # Claude Code settings

.support/
├── prompts/         # Reusable prompts
├── instructions/    # Development guidelines
├── todos/           # Task tracking
├── mcp-servers/     # MCP server source code
├── logs/           # Diagnostics
└── backups/        # Configuration backups

CLAUDE.md           # Project guidelines
```

## 🔧 Advanced Configuration

### Agent Architecture

**Foundation Layer (6 Core Agents):**
These agents provide fundamental capabilities used by all other agents:

- **researcher** - External information discovery and validation
- **context** - Deep codebase analysis and architectural understanding
- **patterns** - Code quality assessment and pattern recognition
- **principles** - Design principle validation and architectural guidance
- **critic** - Risk assessment, validation, and quality control
- **conflicts** - Conflict resolution and decision arbitration

**Specialist Layer (10 Domain Agents):**
Specialized agents for specific development tasks:

- **git-workflow** - Git operations, branching strategies, commit optimization
- **stack-advisor** - Technology selection, compatibility analysis
- **code-cleaner** - Refactoring, code quality, technical debt reduction
- **performance-optimizer** - Performance analysis, bottleneck identification
- **test-strategist** - Test strategy, coverage analysis, quality assurance
- **todo-manager** - Task prioritization, project management
- **options-analyzer** - Decision analysis, trade-off evaluation
- **constraint-solver** - Complex constraint resolution, optimization
- **meta-programmer** - Code generation, automation, tooling
- **prompt-engineer** - AI prompt optimization, interaction design

**Agent Collaboration:**
Agents automatically collaborate through the foundation layer:

```bash
# Complex task triggers multiple agents
claude /fix "optimize database performance"

# Workflow:
# 1. context agent analyzes codebase architecture
# 2. performance-optimizer identifies bottlenecks
# 3. patterns agent suggests optimization patterns
# 4. critic agent validates proposed changes
# 5. test-strategist ensures testing coverage
```

### Configuration Management

#### Backup Strategy
All backups are stored in `.support/backups/` with timestamped folders:
- **Format:** `YYYYMMDD-HHhMMmSS-reason`
- **Example:** `20250729-14h32m44-factory-reset`
- **Restoration:** Backups preserve customizations and can be restored manually

#### GitIgnore Management
Automatic `.gitignore` management for:
- `.support/backups/` - Configuration backups (contains sensitive data)
- `.support/logs/` - Debug and diagnostic logs
- `.support/cache/` - Temporary files and caches
- Generated files that shouldn't be version controlled

#### Safe Modification Scope
The tool only modifies these directories (never touches your source code):
- `.claude/` - Claude Code configuration and agents
- `.support/` - Support files, backups, and diagnostics
- `CLAUDE.md` - Project guidelines (with automatic backup)
- `.gitignore` - Adds necessary entries (preserves existing)

## 🛡️ Security

- **No hardcoded secrets** - All configurations use environment variables
- **Secure defaults** - Conservative security settings
- **Backup before changes** - Always creates backups before modifications
- **Read-only downloads** - Configurations downloaded from official releases

## 📚 Documentation & Reference

### Configuration Guides
- **Agent Documentation:** Complete agent specifications in `.claude/agents/`
- **Command Reference:** Slash command definitions in `.claude/commands/`
- **Stack Guidelines:** Technology-specific best practices in `.claude/stacks/`
- **Project Guidelines:** Development standards and decisions in `CLAUDE.md`

### Progressive Learning Path

#### Beginner: Essential Commands
```bash
# Start with these core commands
claude /stacks          # Understand your technology stack
claude /fix "issue"     # Get targeted debugging help
claude /todo/next       # Prioritize your work
```

#### Intermediate: Agent Collaboration
```bash
# Use specialized agents for complex tasks
claude /agents/create   # Create custom agents
claude /performance "analyze API latency"
claude /discuss "should we migrate to microservices?"
```

#### Advanced: Ecosystem Management
```bash
# Manage and extend the agent ecosystem
uvx claude-code-forge agent-ecosystem  # Generate project-specific agents
uvx claude-code-forge master-prompt     # Craft optimized prompts
# Custom agent development and MCP integration
```

### Command Reference

#### Foundation Commands
- `/stacks` - Technology stack analysis and recommendations
- `/fix <issue>` - Targeted issue resolution with specialist agents
- `/discuss <topic>` - Critical analysis and decision support
- `/performance <area>` - Performance optimization guidance

#### Agent Management
- `/agents/audit` - Review all installed agents and their status
- `/agents/create` - Interactive agent creation wizard
- `/agents/guide` - Agent usage guidelines and best practices

#### Task Management
- `/todo/next` - Intelligent task prioritization
- `/todo/create <task>` - Create tracked development tasks
- `/todo/review` - Review and update task status

## 🛠️ Troubleshooting

### Common Installation Issues

#### Error: "claude: command not found"
**Cause:** Claude Code CLI not installed or not in PATH

**Solution:**
```bash
# Install Claude Code CLI first
# Visit https://claude.ai/code for installation instructions

# Verify installation
which claude
claude --version
```

#### Error: "uvx: command not found"
**Cause:** uvx not installed

**Solution:**
```bash
# Install uvx
pip install uvx

# Alternative: use pipx if available
pipx install uvx

# Verify installation
uvx --version
```

#### Error: "Failed to download configurations"
**Cause:** Network connectivity or GitHub access issues

**Solution:**
```bash
# Check internet connection
curl -I https://api.github.com/repos/ondrasek/claude-code-forge/releases/latest

# If behind corporate firewall, configure proxy
export HTTPS_PROXY=your-proxy:port
uvx claude-code-forge init
```

#### Error: "/stacks command not found" after installation
**Cause:** Claude Code configuration not properly loaded

**Solution:**
```bash
# Restart Claude Code CLI to reload configuration
pkill claude
claude /stacks

# Verify .claude directory exists and contains files
ls -la .claude/commands/
```

#### Error: "Permission denied" during installation
**Cause:** Insufficient file system permissions

**Solution:**
```bash
# Ensure write permissions in current directory
ls -la .
sudo chown -R $USER:$USER .

# Run installation again
uvx claude-code-forge init
```

### Interactive Troubleshooting

For complex issues, use the built-in troubleshooting assistant:

```bash
# Launch interactive debugging with Claude
uvx claude-code-forge troubleshoot
```

This will:
- Analyze your Claude Code and MCP configuration
- Check for common configuration problems
- Provide step-by-step solutions
- Generate diagnostic reports

### Getting Help

If troubleshooting doesn't resolve your issue:

1. **Check existing issues:** [GitHub Issues](https://github.com/ondrasek/claude-code-forge/issues)
2. **Create detailed bug report** with:
   - Operating system and version
   - Claude Code CLI version (`claude --version`)
   - Python version (`python --version`)
   - Complete error output
   - Steps to reproduce

### Customization

After successful installation, customize your setup:

#### 1. Add Custom Agents
```bash
# Create new agent in .claude/agents/
cp .claude/agents/template.json .claude/agents/my-agent.json
# Edit with your agent configuration
```

#### 2. Create Custom Commands
```bash
# Add new slash command in .claude/commands/
cp .claude/commands/stacks.json .claude/commands/my-command.json
# Customize command behavior
```

#### 3. Project Guidelines
```bash
# Update CLAUDE.md with project-specific guidelines
vim CLAUDE.md  # Add your coding standards, architecture decisions
```

#### 4. MCP Server Configuration
```bash
# Configure additional MCP servers
vim .mcp.json  # Add memory, perplexity, or custom MCP servers
```

## 🚦 Development & Contributing

### DevContainer Integration
Claude Code Forge is available as a devcontainer feature for seamless development environment setup:

```json
// .devcontainer/devcontainer.json
{
  "features": {
    "ghcr.io/ondrasek/claude-code-forge/claude-code-forge:latest": {}
  }
}
```

This automatically configures Claude Code with the full agent ecosystem when your devcontainer starts.

### Local Development

#### Setup Development Environment
```bash
# Clone the repository
git clone https://github.com/ondrasek/claude-code-forge.git
cd claude-code-forge

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Install in development mode
pip install -e .
```

#### Testing Local Changes
```bash
# Test your changes locally
python -m claude_code_forge init

# Run with different configurations
python -m claude_code_forge init --config-path ./custom-config

# Debug mode with verbose output
python -m claude_code_forge init --debug
```

#### Contributing

1. **Fork the repository** on GitHub
2. **Create a feature branch:** `git checkout -b feature/amazing-agent`
3. **Make your changes** and test thoroughly
4. **Add tests** for new functionality
5. **Update documentation** as needed
6. **Submit a pull request** with detailed description

**Contribution Areas:**
- New AI agents for specialized domains
- Enhanced MCP server integrations
- Improved troubleshooting and diagnostics
- Documentation and examples
- Performance optimizations

## ❓ Frequently Asked Questions

### General Questions

**Q: What exactly is Claude Code Forge?**
A: Claude Code Forge is a CLI tool that transforms the basic Claude Code CLI into a specialized development environment. It installs 16 AI agents, custom commands, and MCP integrations that understand your codebase and development workflow.

**Q: Is this an official Anthropic tool?**
A: No, this is a community-developed tool that enhances the official Claude Code CLI. It's built by developers for developers to maximize productivity with Claude.

**Q: Do I need to pay for anything?**
A: Claude Code Forge itself is free and open source. You'll need access to Claude (which may require a subscription), but no additional costs for using this tool.

### Installation & Setup

**Q: Why do I need Claude Code CLI first?**
A: Claude Code Forge enhances the official Claude CLI by adding specialized agents and commands. It cannot function without the base Claude Code CLI installed.

**Q: Can I use this with Claude.ai web interface?**
A: No, this tool specifically enhances the Claude Code CLI for terminal/command-line usage. The web interface doesn't support the agent ecosystem or custom commands.

**Q: What happens to my existing Claude Code configuration?**
A: Claude Code Forge automatically backs up your existing configuration before making changes. All backups are stored in `.support/backups/` with timestamps for easy restoration.

### Usage & Functionality

**Q: How do agents differ from regular Claude prompts?**
A: Agents are specialized AI assistants with specific expertise, context, and workflows. Instead of generic responses, you get targeted help from agents trained for specific domains (debugging, architecture, testing, etc.).

**Q: Can I create my own agents?**
A: Yes! Use `claude /agents/create` for an interactive wizard, or manually create agents in `.claude/agents/`. The `agent-ecosystem` command can even generate project-specific agents.

**Q: Do agents remember previous conversations?**
A: Yes, through MCP memory integration. Agents can recall project context, previous decisions, and maintain continuity across multiple Claude sessions.

**Q: What if I don't like some agents or commands?**
A: Everything is customizable. You can disable agents, modify commands, or completely customize the ecosystem. The `.support/backups/` directory lets you revert any changes.

### Technical Questions

**Q: Does this modify my source code?**
A: No, Claude Code Forge only modifies configuration directories (`.claude/`, `.support/`) and the `CLAUDE.md` guidelines file. Your source code is never touched.

**Q: Can I use this in team environments?**
A: Yes, the configuration can be committed to version control (except `.support/backups/` and `.support/logs/` which are automatically gitignored). Team members can share the same agent ecosystem.

**Q: What about security and privacy?**
A: The tool uses secure defaults, no hardcoded secrets, and only downloads configurations from official GitHub releases. Your code and data remain private to your Claude sessions.

### Troubleshooting

**Q: The `/stacks` command doesn't work after installation**
A: This usually means Claude Code CLI needs to be restarted to load the new configuration. Try `pkill claude` then run `claude /stacks` again.

**Q: I'm getting "uvx: command not found"**
A: Install uvx with `pip install uvx`. This is required to run Python applications without traditional installation.

**Q: Can I uninstall everything?**
A: Yes, use `uvx claude-code-forge factory-reset` to remove all configurations and revert to defaults. Your original configuration is backed up automatically.

## 📄 License

MIT License - see LICENSE file for details.