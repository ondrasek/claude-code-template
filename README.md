# Claude Code Forge

**AI Agent System for Claude Code**

[![Version](https://img.shields.io/github/v/release/ondrasek/claude-code-forge)](https://github.com/ondrasek/claude-code-forge/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Issues](https://img.shields.io/github/issues/ondrasek/claude-code-forge)](https://github.com/ondrasek/claude-code-forge/issues)

Extends Claude Code with 17 specialized AI agents, automated workflows, and development integrations.

## What It Does

- **17 AI Agents**: Code review, performance analysis, testing, architecture, security
- **27 Slash Commands**: Workflow automation and agent coordination
- **GitHub Issues Integration**: Project management with AI assistance
- **Technology Stack Support**: Python, Rust, Java, C++, TypeScript, Docker configs
- **MCP Integration**: Perplexity server for web research
- **Cross-session Memory**: Context preservation between Claude Code sessions

## Installation

```bash
git clone https://github.com/ondrasek/claude-code-forge.git
cd claude-code-forge

# Copy configurations to your Claude Code setup
# See docs/getting-started.md for detailed instructions
```

**Requirements:**
- Claude Code CLI installed and working
- Git for repository operations  
- Python 3.13+ for MCP server functionality
- Node.js for Claude Code operation

## Quick Start

```bash
# Test agent system
/agents-guide

# Multi-agent code analysis
/review

# GitHub Issues management  
/issue create
/issue list

# Web research via Perplexity MCP
/research python async patterns
```

## Agent System

### Foundation Agents (6)
- **patterns** - Code pattern analysis and recommendations
- **principles** - Design principle validation  
- **context** - Codebase context and architecture analysis
- **researcher** - Web research and best practices
- **critic** - Risk assessment and critical analysis
- **conflicts** - Decision mediation and trade-off analysis

### Specialist Agents (11)
- **code-cleaner** - Code quality improvements
- **constraint-solver** - Complex requirement analysis
- **git-workflow** - Automated git operations
- **github-issues-workflow** - GitHub Issues management
- **github-pr-workflow** - Pull request automation
- **meta-programmer** - Code generation and templates
- **options-analyzer** - Solution comparison and analysis
- **performance-optimizer** - Performance analysis and optimization
- **prompt-engineer** - AI prompt development
- **stack-advisor** - Technology-specific guidance
- **test-strategist** - Testing strategy and implementation

## Command System

27 slash commands organized in namespaces:

- `/agents/*` - Agent management and coordination
- `/issue/*` - GitHub Issues workflow (6 commands)
- `/commands/*` - Command system management
- Plus individual commands for git, review, research, testing, etc.

## Technology Stack Integration

Built-in configurations for:

- **Python**: Django, FastAPI, pytest, poetry
- **Rust**: Cargo, async, memory safety
- **Java**: Spring Boot, Maven/Gradle, JUnit
- **TypeScript**: Node.js, React, testing frameworks
- **C++**: Modern standards, CMake
- **Docker**: Multi-stage builds, optimization
- **Ruby**, **C#**, **Kotlin**: Basic configurations

Each stack includes:
- Automated detection
- Best practices and patterns
- Security guidelines  
- Testing strategies

## MCP Server

Includes Perplexity MCP server implementation:

```bash
cd src/perplexity-mcp
# See README.md for setup instructions
```

Provides real-time web search and research capabilities through the `/research` command.

## Architecture

```
├── .claude/               # Core Claude Code configuration
│   ├── agents/           # 17 AI agent definitions
│   └── commands/         # 27 slash commands
├── src/                  # Source code
│   └── perplexity-mcp/   # MCP server implementation  
├── templates/            # Configuration templates
│   ├── instructions/     # Setup and usage guides
│   ├── stacks/          # Technology-specific configs
│   └── prompts/         # AI interaction templates
├── scripts/             # Utility scripts
└── docs/               # Documentation
```

## Development Workflow

1. **Issue Management**: GitHub Issues integration with `/issue` commands
2. **Code Review**: Multi-agent analysis with `/review`
3. **Git Automation**: Automated commits, tagging, releases
4. **Research Integration**: Real-time web research via MCP
5. **Memory System**: Context preservation across sessions

## Configuration

The system uses template-based configuration:

- Agent definitions in `.claude/agents/`
- Command definitions in `.claude/commands/`
- Technology stack configurations in `templates/stacks/`
- Master prompts and instructions in `templates/`

## Documentation

- **[Getting Started](docs/getting-started.md)** - Setup instructions
- **[Agent Usage](docs/agent-usage.md)** - Working with AI agents
- **[Features](docs/features.md)** - Complete feature reference
- **[Configuration](docs/configuration-reference.md)** - Customization options
- **[Launch Scripts](docs/launch-claude-usage.md)** - Script configuration

## Contributing

- **Issues**: [Report bugs or request features](https://github.com/ondrasek/claude-code-forge/issues)
- **Development**: See [contributing guidelines](CONTRIBUTING.md)
- **Pull Requests**: [Submit improvements](https://github.com/ondrasek/claude-code-forge/pulls)

## Project Status

- **Version**: 2.70.0+ (actively maintained)
- **Issue Tracking**: GitHub Issues (30+ migrated from legacy specs)
- **Release Management**: Semantic versioning with detailed changelog
- **Community**: Open source with MIT license

## License

MIT License - see [LICENSE](LICENSE) file for details.

---

**Repository Structure**: Development workspace containing templates, agents, and tools for enhancing Claude Code with specialized AI workflows.