# mycc - Enhanced Claude Code Wrapper

`mycc` is a powerful alias wrapper for Claude Code that provides enhanced functionality, better defaults, and advanced logging capabilities.

## Features

- **Optimized Defaults**: Verbose mode disabled by default, Sonnet model as default
- **Master Prompt Loading**: Automatic loading of custom prompts from `.claude.support/master-prompt.md`
- **Advanced Logging**: Comprehensive logging with debug mode and MCP server logging
- **Log Analysis**: Built-in log analysis using Claude Code agents
- **Easy Installation**: Automated installation script for multiple shells

## Installation

### Quick Install

```bash
# Run the installation script
./.support/scripts/install-mycc.sh

# Or manually add the alias to your shell config
echo "alias mycc='$(pwd)/.support/scripts/mycc.sh'" >> ~/.bashrc
source ~/.bashrc
```

### Verify Installation

```bash
mycc --help
```

## Usage

### Basic Usage

```bash
# Simple query with optimized defaults
mycc "Review my code"

# Interactive mode (same as claude without arguments)
mycc
```

### Advanced Options

```bash
# Enable verbose mode (overrides default disable)
mycc --verbose "Analyze performance issues"

# Use debug mode with extensive logging
mycc --debug "Complex debugging session"

# Set custom model
mycc --model opus "Complex reasoning task"

# Enable MCP server debugging
mycc --mcp-debug "MCP server interaction analysis"
```

### Logging Features

```bash
# Save logs to specific file
mycc --log-file debug.log "Debug session"

# Save logs to timestamped file in .logs/
mycc --save-logs "Important session"

# Analyze existing log files using Claude Code agents
mycc --analyze-logs
```

### Combined Options

```bash
# Full debug session with logging
mycc --debug --mcp-debug --save-logs "Comprehensive analysis"

# Verbose mode with custom model and logging
mycc --verbose --model opus --log-file analysis.log "Deep code review"
```

## Configuration

### Master Prompt

Create a custom master prompt that gets automatically prepended to all queries:

```bash
# Create/edit the master prompt file
vim .claude.support/master-prompt.md
```

Example master prompt content:
```markdown
# Project-Specific Instructions

You are working on a specialized project. Please:
- Follow our coding standards
- Use TypeScript for all new code
- Write comprehensive tests
- Update documentation
```

### Environment Variables

The following environment variables are set when using debug mode:

- `CLAUDE_DEBUG=1` - Enable Claude Code debug output
- `MCP_LOG_LEVEL=debug` - Set MCP server log level to debug
- `ANTHROPIC_DEBUG=1` - Enable Anthropic API debug logging

## Log Analysis

The `--analyze-logs` feature uses multiple Claude Code agents to analyze your log files:

- **researcher agent**: Investigates log patterns and issues
- **patterns agent**: Identifies recurring patterns and anti-patterns
- **Additional agents**: As needed for comprehensive analysis

### Log Analysis Process

1. Finds up to 5 most recent log files in `.logs/` directory
2. Uses Claude Code with multiple agents for analysis
3. Provides actionable insights for:
   - Performance issues
   - Error patterns
   - Optimization opportunities
   - Code quality improvements

## Command Reference

| Option | Description | Example |
|--------|-------------|---------|
| `-h, --help` | Show help message | `mycc --help` |
| `-v, --verbose` | Enable verbose mode | `mycc --verbose "query"` |
| `-d, --debug` | Enable debug mode | `mycc --debug "query"` |
| `-m, --model MODEL` | Set model | `mycc --model opus "query"` |
| `--mcp-debug` | Enable MCP debug logging | `mycc --mcp-debug "query"` |
| `--log-file FILE` | Save logs to file | `mycc --log-file log.txt "query"` |
| `--save-logs` | Save to timestamped file | `mycc --save-logs "query"` |
| `--analyze-logs` | Analyze existing logs | `mycc --analyze-logs` |

## Default Behavior Changes

| Feature | Claude Default | mycc Default | Override |
|---------|----------------|--------------|----------|
| Verbose Mode | Off | Off (explicit) | `--verbose` |
| Model | Various | sonnet | `--model` |
| Master Prompt | None | Auto-loaded | Edit `.claude.support/master-prompt.md` |
| Logging | Basic | Enhanced | Various log options |

## Troubleshooting

### Common Issues

**mycc command not found**
```bash
# Check if alias is installed
type mycc

# Reinstall if needed
./.support/scripts/install-mycc.sh
```

**Permission denied**
```bash
# Make script executable
chmod +x .support/scripts/mycc.sh
```

**Master prompt not loading**
```bash
# Check if file exists
ls -la .claude.support/master-prompt.md

# Create if missing
mkdir -p .claude.support
touch .claude.support/master-prompt.md
```

### Debug Mode Output

When using `--debug`, you'll see:
- Command being executed
- Environment variables set
- Master prompt loading status
- Log file locations
- All parameters passed to Claude

## Integration with Claude Code Features

`mycc` is fully compatible with all Claude Code features:

- **Agents**: All 20+ specialized agents work normally
- **Commands**: Slash commands (e.g., `/review`, `/test`) work as expected  
- **MCP Servers**: Full MCP server support with enhanced debugging
- **Memory**: MCP memory servers work with all logging features
- **Project Settings**: Respects `.claude/settings.json` configurations

## Examples

### Development Workflow

```bash
# Start development session with logging
mycc --save-logs "Let's implement the user authentication feature"

# Debug performance issues
mycc --debug --mcp-debug "Why is the login endpoint slow?"

# Review code with verbose output
mycc --verbose "Review the authentication module for security issues"

# Analyze previous session logs
mycc --analyze-logs
```

### Team Usage

```bash
# Share master prompt across team
git add .claude.support/master-prompt.md
git commit -m "Add team coding standards to master prompt"

# Use consistent model for team sessions
mycc --model sonnet "Implement feature X according to our standards"
```

### CI/CD Integration

```bash
# Automated code review in scripts
mycc --log-file ci-review.log "Review this PR for issues" < pr-description.txt

# Generate analysis reports
mycc --analyze-logs > code-quality-report.md
```

## File Structure

```
.support/scripts/
├── mycc.sh              # Main mycc script
├── install-mycc.sh      # Installation script
.claude.support/
├── master-prompt.md     # Custom master prompt (auto-created)
.logs/                   # Log files (auto-created when using --save-logs)
├── mycc-20240128-143022.log
├── mycc-20240128-151045.log
└── ...
```