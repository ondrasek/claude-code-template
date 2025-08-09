# Claude Code Forge

**AI Agent System for Claude Code**

[![Version](https://img.shields.io/github/v/release/ondrasek/claude-code-forge)](https://github.com/ondrasek/claude-code-forge/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Issues](https://img.shields.io/github/issues/ondrasek/claude-code-forge)](https://github.com/ondrasek/claude-code-forge/issues)

Development workspace and template system for enhancing Claude Code with specialized AI workflows and integrations.

## What It Provides

- **Agent Templates & Guidelines**: Framework for creating specialized AI agents
- **Technology Stack Templates**: Pre-configured guidelines for Python, Rust, Java, C++, TypeScript, Docker
- **GitHub Issues Workflow**: Project management integration and templates
- **MCP Server Implementation**: Perplexity server for web research capabilities
- **Development Scripts**: Setup and testing utilities for Claude Code enhancement
- **Documentation Templates**: Comprehensive guides and configuration examples

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
# Setup Claude Code memory system
./scripts/setup-claude-memory.sh

# Launch Claude Code with configuration
./scripts/launch-claude.sh

# Test agent system
./scripts/test-agents.sh
```

## Template System

### Agent Guidelines
Frameworks for creating specialized AI agents:
- **Foundation patterns** - Code analysis, principles validation, context understanding
- **Workflow automation** - Git operations, GitHub integration, testing strategies
- **Development support** - Performance optimization, security analysis, code generation

### Technology Stack Templates
Pre-configured development guidelines for:
- **Python**: Django, FastAPI, pytest, poetry patterns
- **Rust**: Cargo workflows, async patterns, memory safety
- **Java**: Spring Boot, Maven/Gradle, testing frameworks
- **C++**: Modern standards, CMake configuration
- **Docker**: Multi-stage builds, optimization strategies

## Script System

Utility scripts for Claude Code setup and operation:

- `launch-claude.sh` - Launch Claude Code with memory configuration
- `setup-claude-memory.sh` - Configure cross-session memory system
- `test-agents.sh` - Test agent system functionality
- `test-session-logging.sh` - Validate logging and session management

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
├── analysis/             # Project analysis and research
├── docs/                # Documentation and guides
├── research/            # Technical research documents
├── scripts/             # Setup and utility scripts
├── src/                 # Source code
│   └── perplexity-mcp/  # MCP server implementation
├── templates/           # Template system
│   ├── guidelines/      # Agent and workflow templates
│   ├── prompts/        # Master prompt templates
│   ├── specs/          # Specification templates
│   └── stacks/         # Technology stack configurations
├── CLAUDE.md           # Core operational rules
└── CHANGELOG.md        # Version history
```

## Development Workflow

1. **Template-Based Setup**: Use provided templates for agent and stack configuration
2. **GitHub Issues Integration**: Specification management through GitHub Issues
3. **Memory System**: Cross-session context preservation via CLAUDE.md
4. **Research Integration**: Real-time web research via Perplexity MCP server
5. **Automated Git Operations**: Consistent versioning and change management

## Configuration

The system provides template-based configuration:

- Technology stack guidelines in `templates/stacks/`
- Agent framework templates in `templates/guidelines/`
- Master prompt templates in `templates/prompts/`
- Core operational rules in `CLAUDE.md`

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

- **Version**: 2.78.0+ (actively maintained)
- **Issue Tracking**: GitHub Issues for specification management
- **Release Management**: Semantic versioning with detailed changelog
- **Community**: Open source with MIT license

## License

MIT License - see [LICENSE](LICENSE) file for details.

---

**Repository Structure**: Development workspace containing templates, agents, and tools for enhancing Claude Code with specialized AI workflows.