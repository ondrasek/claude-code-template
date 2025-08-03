# Manual Setup Guide for Claude Code Template

## Overview

This guide provides step-by-step instructions for manually setting up the Claude Code Template configuration on your system. This replaces the automated installation methods and gives you full control over the setup process.

**Important**: The automated installation scripts have been removed. This manual setup approach is the current method until a future CLI tool is developed.

## Quick Start Guide

### Prerequisites

1. **Claude Code installed**: Install Claude Code globally
   ```bash
   npm install -g @anthropic/claude-code
   ```

2. **Required API Keys**: You'll need:
   - `CLAUDE_API_KEY` - Your Anthropic Claude API key
   - `PERPLEXITY_API_KEY` - (Optional) For research capabilities
   - `GITHUB_TOKEN` - (Optional) For GitHub integrations

### Step 1: Clone the Template

```bash
# Clone this repository
git clone https://github.com/yourusername/claude-code-template.git
cd claude-code-template
```

### Step 2: Copy Configuration Files

Copy the `.claude` directory to your home directory:

```bash
# Create the Claude Code configuration directory
mkdir -p ~/.claude

# Copy the entire .claude configuration
cp -r .claude/* ~/.claude/

# Verify the copy was successful
ls -la ~/.claude
```

### Step 3: Set Up Environment Variables

Add your API keys to your shell profile:

```bash
# Add to ~/.bashrc, ~/.zshrc, or your shell's profile file
echo 'export CLAUDE_API_KEY="your-api-key-here"' >> ~/.bashrc
echo 'export PERPLEXITY_API_KEY="your-perplexity-key-here"' >> ~/.bashrc
echo 'export GITHUB_TOKEN="your-github-token-here"' >> ~/.bashrc

# Reload your shell
source ~/.bashrc
```

### Step 4: Install Optional Dependencies

For enhanced functionality, install these tools:

```bash
# Install uv for Python project management
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install GitHub CLI (if not already installed)
# On macOS:
brew install gh
# On Ubuntu/Debian:
sudo apt install gh
# On other systems, see: https://cli.github.com/manual/installation
```

### Step 5: Verify Setup

Test that everything is working:

```bash
# Start Claude Code and verify configuration is loaded
claude

# In Claude Code, try these commands:
# /review
# /agents-guide  
# /stacks
```

## Detailed File-by-File Copying Guide

### Core Configuration Files

**1. Settings Files** (`~/.claude/`)
```bash
# Main settings file
cp .claude/settings.json ~/.claude/settings.json

# Local settings (permissions and overrides)
cp .claude/settings.local.json ~/.claude/settings.local.json
```

**What these do:**
- `settings.json`: Main Claude Code configuration
- `settings.local.json`: Local permissions and security settings

**2. Agents Directory** (`~/.claude/agents/`)
```bash
# Copy all agent definitions
cp -r .claude/agents ~/.claude/

# This includes:
# ~/.claude/agents/foundation/    - Core agents (research, patterns, criticism, etc.)
# ~/.claude/agents/specialists/   - Specialized agents (git, testing, optimization, etc.)
```

**What these do:**
- **Foundation agents**: Core AI assistants used for all complex tasks
- **Specialist agents**: Domain-specific experts for particular technologies or workflows

**3. Commands Directory** (`~/.claude/commands/`)
```bash
# Copy all custom commands
cp -r .claude/commands ~/.claude/

# This includes commands like:
# /review, /test, /refactor, /security, /stacks, etc.
```

**What these do:**
- Provide instant access to common development tasks
- Each `.md` file becomes a slash command in Claude Code

### Optional Support Files

**4. Support Directory** (Project-specific location)
```bash
# For project-specific setup, copy to your project root:
cp -r .support /path/to/your/project/

# Or copy specific components you need:
cp -r .support/prompts /path/to/your/project/.support/
cp -r .support/instructions /path/to/your/project/.support/
```

**What these do:**
- `.support/prompts/`: Reusable prompts and templates
- `.support/instructions/`: Additional guidelines for Claude Code
- `.support/mcp-servers/`: MCP server configurations and source code
- `.support/scripts/`: Utility scripts for setup and maintenance

### Directory Structure After Setup

Your `~/.claude` directory should look like this:

```
~/.claude/
├── agents/
│   ├── foundation/
│   │   ├── foundation-research.md
│   │   ├── foundation-patterns.md
│   │   ├── foundation-criticism.md
│   │   ├── foundation-principles.md
│   │   ├── foundation-context.md
│   │   └── foundation-conflicts.md
│   └── specialists/
│       ├── specialist-code-cleaner.md
│       ├── specialist-constraint-solver.md
│       ├── specialist-git-workflow.md
│       ├── specialist-options-analyzer.md
│       ├── specialist-performance-optimizer.md
│       ├── specialist-prompt-engineer.md
│       ├── specialist-stack-advisor.md
│       ├── specialist-test-strategist.md
│       ├── specialist-todo-manager.md
│       └── specialist-meta-programmer.md
├── commands/
│   ├── agents/
│   ├── commands/
│   ├── todo/
│   ├── deploy.md
│   ├── discuss.md
│   ├── doc-update.md
│   ├── fix.md
│   ├── generate.md
│   ├── git.md
│   ├── monitor.md
│   ├── performance.md
│   ├── refactor.md
│   ├── research.md
│   ├── review.md
│   ├── security.md
│   ├── stacks.md
│   ├── test.md
│   └── version-prepare.md
├── settings.json
└── settings.local.json
```

## Permissions and Security

### File Permissions

Ensure proper permissions on configuration files:

```bash
# Set appropriate permissions
chmod 755 ~/.claude
chmod 644 ~/.claude/settings*.json
chmod 644 ~/.claude/agents/*/*.md
chmod 644 ~/.claude/commands/*/*.md
```

### Environment Variable Security

**Best Practices:**
1. Never commit API keys to git repositories
2. Use environment variables for all sensitive data
3. Consider using a `.env` file for local development (but don't commit it)

**Local .env Setup** (Optional):
```bash
# Create a .env file in your project root
cat > .env << 'EOF'
CLAUDE_API_KEY=your-api-key-here
PERPLEXITY_API_KEY=your-perplexity-key-here
GITHUB_TOKEN=your-github-token-here
EOF

# Make sure .env is in your .gitignore
echo ".env" >> .gitignore
```

## Verification Checklist

After completing the setup, verify everything works:

### ✅ Configuration Loading
```bash
# Start Claude Code
claude

# Check that settings are loaded (no errors about missing files)
```

### ✅ Custom Commands Available
```bash
# In Claude Code, test these commands:
/review
/stacks
/agents-guide
/discuss
```

### ✅ Agents Working
```bash
# Try a complex request that should trigger multiple agents
# Example: "Review this code and suggest improvements"
# You should see multiple agents working together
```

### ✅ Environment Variables
```bash
# Check that your API keys are available
echo $CLAUDE_API_KEY
echo $PERPLEXITY_API_KEY
```

### ✅ File Structure
```bash
# Verify all files copied correctly
ls -la ~/.claude/agents/foundation/
ls -la ~/.claude/commands/
cat ~/.claude/settings.json
```

## Troubleshooting

### Commands Not Working
**Problem**: Slash commands like `/review` not recognized
**Solution**: 
```bash
# Check if commands directory exists and has content
ls ~/.claude/commands/
# If empty, re-copy the commands
cp -r .claude/commands/* ~/.claude/commands/
```

### Agents Not Responding
**Problem**: Agents not being invoked automatically
**Solution**:
```bash
# Check agents directory
ls ~/.claude/agents/foundation/
ls ~/.claude/agents/specialists/
# If missing, re-copy the agents
cp -r .claude/agents/* ~/.claude/agents/
```

### Permission Denied Errors
**Problem**: Cannot read configuration files
**Solution**:
```bash
# Fix permissions
chmod -R 644 ~/.claude/
chmod 755 ~/.claude
find ~/.claude -type d -exec chmod 755 {} \;
```

### Environment Variables Not Available
**Problem**: API keys not found
**Solution**:
```bash
# Check your shell profile file
grep CLAUDE_API_KEY ~/.bashrc
# If not found, add it:
echo 'export CLAUDE_API_KEY="your-key"' >> ~/.bashrc
source ~/.bashrc
```

## Project-Specific Setup

### Adding to Existing Projects

For each project where you want to use the enhanced Claude Code features:

1. **Copy CLAUDE.md to your project root**:
   ```bash
   cp CLAUDE.md /path/to/your/project/
   ```

2. **Optionally copy support files**:
   ```bash
   cp -r .support /path/to/your/project/
   ```

3. **Update CLAUDE.md for your project**:
   Edit the file to include your project-specific guidelines.

### Team Setup

For team environments:

1. **Share the configuration**: Commit `.claude/` to your team's shared dotfiles repository
2. **Document API key setup**: Provide team members with API key setup instructions
3. **Standardize environment**: Ensure all team members use the same configuration

## Next Steps

After completing the manual setup:

1. **Explore the features**: Try `/agents-guide` to see what's available
2. **Customize for your needs**: Edit agents and commands in `~/.claude/`
3. **Add project-specific guidelines**: Update `CLAUDE.md` for your projects
4. **Stay updated**: Watch this repository for updates to configuration files

## Future CLI Tool

**Note**: A CLI tool for automated setup is planned for future development. The manual setup you're performing now will be fully compatible with the future automated tool, so your configuration won't need to change.

The planned CLI tool will:
- Automate the file copying process
- Handle environment variable setup
- Provide update mechanisms
- Validate configuration integrity

Until then, this manual approach ensures you have full control and understanding of your Claude Code setup.