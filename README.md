# Claude Code Forge

[![Version](https://img.shields.io/github/v/release/ondrasek/claude-code-forge?label=v2.57.0)](https://github.com/ondrasek/claude-code-forge/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A professional CLI tool for automated Claude Code configuration management. Install custom agents, commands, MCP tools, and development configurations with a single command.

## 🚀 Quick Start

### Installation

No installation required! Run directly with uvx:

```bash
# Initialize Claude Code configuration
uvx claude-code-forge init

# Verify installation
claude /stacks
```

### Prerequisites

- Claude Code CLI installed
- Python 3.8+ (for uvx)
- Internet connection (downloads configurations from GitHub releases)

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

### MCP Tools
- **memory** - Persistent session memory
- **perplexity** - Real-time web search and research
- Additional specialized tools configurable via `.mcp.json`

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

## 🔧 Configuration Management

### Backup Strategy
All backups are stored in `.support/backups/` with timestamped folders:
- Format: `YYYYMMDD-HHhMMmSS-reason`
- Example: `20250729-14h32m44-factory-reset`
- Backups preserve your customizations and can be restored manually

### GitIgnore Management
The tool automatically manages `.gitignore` entries for:
- `.support/backups/` - Configuration backups
- `.support/logs/` - Log files
- Other generated files that shouldn't be committed

### Working Directories
The tool only modifies:
- `.claude/` - Claude Code configuration
- `.support/` - Support files and backups
- `CLAUDE.md` - Project guidelines (with backups)

## 🛡️ Security

- **No hardcoded secrets** - All configurations use environment variables
- **Secure defaults** - Conservative security settings
- **Backup before changes** - Always creates backups before modifications
- **Read-only downloads** - Configurations downloaded from official releases

## 📚 Documentation

### Configuration Guides
- Agent ecosystem documentation in `.claude/agents/`
- Command documentation in `.claude/commands/`
- Stack-specific guidelines in `.claude/stacks/`

### Troubleshooting
Use `uvx claude-code-forge troubleshoot` for interactive debugging assistance.

### Customization
After initialization, you can customize:
1. Add custom agents in `.claude/agents/`
2. Create new commands in `.claude/commands/`
3. Update `CLAUDE.md` with project-specific guidelines
4. Configure additional MCP servers in `.mcp.json`

## 🚦 Development

### Running as DevContainer Feature
The tool is available as a devcontainer feature for seamless integration.

### Local Development
```bash
# Clone the repository
git clone https://github.com/ondrasek/claude-code-forge.git
cd claude-code-forge

# Install dependencies
pip install -r requirements.txt

# Run locally
python -m claude_code_forge init
```

## 📄 License

MIT License - see LICENSE file for details.