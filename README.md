# Claude Code Forge

**Professional Claude Code Enhancement Platform**

[![Version](https://img.shields.io/github/v/release/ondrasek/claude-code-forge)](https://github.com/ondrasek/claude-code-forge/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Issues](https://img.shields.io/github/issues/ondrasek/claude-code-forge)](https://github.com/ondrasek/claude-code-forge/issues)

Transform Claude Code into an AI-powered development environment with **20+ specialized agents**, automated workflows, and comprehensive technology stack integration.

## 🎬 What You Get

**Before**: Basic Claude Code with limited capabilities  
**After**: Professional development environment with specialized AI agents for every task

- **🤖 20+ AI Agents**: Code review, performance optimization, testing, security analysis, and more
- **⚡ Automated Workflows**: Git operations, GitHub Issues integration, project management  
- **🏗️ Technology Stacks**: Built-in expertise for Python, Rust, Java, C++, TypeScript, and more
- **🔍 Real-time Research**: Perplexity MCP integration for current information
- **💾 Persistent Memory**: Cross-session context and learning capabilities

## ⚡ Quick Start (30 seconds)

```bash
# Install with one command
uvx --from claude-code-forge init

# Verify installation
claude-code
/agents-guide  # See your new AI capabilities

# Try it out
/review        # AI code review with multiple specialists
/issue create  # GitHub Issues integration
/research      # Real-time web research via Perplexity
```

## 🚀 Core Capabilities

### 🧠 Multi-Agent Intelligence
- **Foundation Agents**: patterns, principles, context, researcher, critic
- **Specialists**: performance-optimizer, test-strategist, constraint-solver, code-cleaner
- **Workflows**: git-workflow, github-issues-workflow, github-pr-workflow
- **Coordinated Analysis**: Multiple agents work together for comprehensive insights

### 🔧 Development Automation  
- **Smart Commands**: 25+ slash commands for common development tasks
- **Git Integration**: Automated commits, tagging, and release management
- **GitHub Issues**: Seamless project management with AI-assisted workflows
- **Technology Detection**: Automatic stack identification and best practices

### 🌐 Real-World Integration
- **MCP Servers**: Perplexity integration for web research and current information
- **Memory System**: Persistent context across development sessions  
- **Template System**: Technology-specific configurations and guidelines
- **Multi-Stack Support**: 8+ technology stacks with built-in expertise

### 📊 Professional Features
- **Code Quality**: Automated pattern detection, principle validation, and improvement suggestions  
- **Performance Analysis**: Systematic optimization recommendations with complexity analysis
- **Security Workflows**: Vulnerability detection and defensive security practices
- **Documentation**: Automated generation and maintenance of project documentation

## 📚 Documentation Hub

### Getting Started
- **[Installation Guide](docs/getting-started.md)** - Comprehensive setup instructions
- **[Configuration](docs/configuration-reference.md)** - Customization options and settings
- **[Agent Usage](docs/agent-usage.md)** - How to work with AI agents effectively

### Advanced Usage  
- **[Features Overview](docs/features.md)** - Complete capabilities reference
- **[Customization Guide](docs/customization.md)** - Extending and modifying the system
- **[Launch Scripts](docs/launch-claude-usage.md)** - Advanced launch configurations

### Development
- **[Contributing](CONTRIBUTING.md)** - How to contribute to the project
- **[Architecture](docs/architecture.md)** - System design and component interaction
- **[Changelog](CHANGELOG.md)** - Version history and evolution

## 🔧 Advanced Features

<details>
<summary><strong>Technology Stack Integration</strong></summary>

Built-in expertise for major development stacks:

- **Python**: Django, FastAPI, pytest, poetry, virtual environments
- **Rust**: Cargo, async patterns, memory safety, performance optimization  
- **Java**: Spring Boot, Maven/Gradle, JUnit, enterprise patterns
- **TypeScript/JavaScript**: Node.js, React, testing frameworks
- **C++**: Modern standards, CMake, performance optimization
- **Docker**: Multi-stage builds, optimization, security best practices
- **And more**: Ruby, C#, Kotlin with comprehensive guidelines

Each stack includes:
- Automated detection and configuration
- Best practices and common patterns  
- Security guidelines and optimization tips
- Testing strategies and tooling recommendations

</details>

<details>
<summary><strong>MCP Server Development</strong></summary>

Create and deploy custom MCP (Model Context Protocol) servers:

- **Perplexity Integration**: Real-time web research and current information
- **Custom Servers**: Framework for building domain-specific integrations
- **Logging & Debugging**: Comprehensive development and troubleshooting tools
- **Template System**: Quick setup for new MCP server projects

Example MCP servers included:
- Perplexity web search and research
- GitHub Issues management  
- Development workflow automation
- Custom API integrations

</details>

<details>
<summary><strong>Memory & Context Management</strong></summary>

Persistent intelligence across development sessions:

- **Cross-Session Memory**: Context preservation between Claude Code sessions
- **Pattern Recognition**: Learn from your codebase and development patterns
- **Historical Analysis**: Track changes and improvements over time
- **Context Optimization**: Prevent context window pollution with smart delegation

</details>

## 🏗️ Architecture Overview

```
Claude Code Forge Architecture:

┌─ /templates/           # Clean distribution package
│  ├─ instructions/      # Template instructions and guidelines  
│  ├─ stacks/           # Technology-specific configurations
│  └─ prompts/          # AI interaction templates
│
├─ /.claude/            # Core Claude Code configuration
│  ├─ agents/           # 20+ specialized AI agents
│  └─ commands/         # 25+ slash commands
│
├─ /src/               # Development source code
│  └─ perplexity-mcp/  # MCP server implementation
│
├─ /scripts/           # Utility scripts  
└─ /docs/             # Comprehensive documentation
```

**How It Works Together:**
1. **Commands** coordinate multiple AI agents for complex tasks
2. **Agents** provide specialized analysis and recommendations
3. **MCP Servers** supply real-time data and external integrations
4. **Templates** provide technology-specific guidance and best practices

## 🤝 Community & Contributing

### 🎯 Quick Contributions
- **[Report Issues](https://github.com/ondrasek/claude-code-forge/issues)** - Bug reports and feature requests
- **[GitHub Discussions](https://github.com/ondrasek/claude-code-forge/discussions)** - Questions and community support
- **[Pull Requests](https://github.com/ondrasek/claude-code-forge/pulls)** - Code contributions and improvements

### 🔥 Development Setup
```bash
# Clone and setup
git clone https://github.com/ondrasek/claude-code-forge.git
cd claude-code-forge

# Install dependencies  
uvx --from claude-code-forge dev-setup

# Run tests
./scripts/test-agents.sh
```

### 📈 Project Management
- **GitHub Issues**: All development tracked via [GitHub Issues](https://github.com/ondrasek/claude-code-forge/issues)
- **Roadmap**: See [open issues](https://github.com/ondrasek/claude-code-forge/issues) for planned features
- **Releases**: Follow [semantic versioning](https://semver.org/) with detailed [changelog](CHANGELOG.md)

## 📋 System Requirements

- **Node.js**: Required for Claude Code CLI
- **Python 3.13+**: For MCP server functionality  
- **Git**: Repository operations and workflow integration
- **Bash**: Launch scripts and automation (Linux/macOS/WSL)

## 🆘 Support & Help

### 🚀 Quick Help
- **Installation Issues**: Check [getting started guide](docs/getting-started.md)
- **Command Reference**: Use `/help` in Claude Code or see [documentation](docs/)
- **Agent Problems**: See [agent usage guide](docs/agent-usage.md)

### 💬 Community Support
- **[GitHub Issues](https://github.com/ondrasek/claude-code-forge/issues)** - Bug reports and feature requests
- **[Discussions](https://github.com/ondrasek/claude-code-forge/discussions)** - Community Q&A and sharing
- **Documentation** - Comprehensive guides in [/docs](docs/) directory

### 🔧 Advanced Support  
- **MCP Development**: See [MCP integration guide](src/perplexity-mcp/README.md)
- **Custom Agents**: Agent development patterns in [/analysis](analysis/)
- **System Integration**: Architecture details in [documentation](docs/)

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---

**Ready to supercharge your Claude Code experience?**

```bash
uvx --from claude-code-forge init
```

*Transform your development workflow with AI-powered intelligence and automation.*