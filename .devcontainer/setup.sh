#!/bin/bash

# DevContainer Setup Script - Replicates Codespace Environment
# This script sets up the exact same environment as the GitHub Codespace

set -e

echo "🚀 Setting up Claude Code Template DevContainer..."
sudo mkdir -p /workspace && sudo chown vscode:vscode /workspace && cd /workspace

# Detect if we're in a container environment
export CONTAINER_ENV=1

# Install uv (modern Python package manager)
echo "📦 Installing uv Python package manager..."
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install Claude CLI globally
echo "🤖 Installing Claude CLI..."
npm install -g @anthropic-ai/claude-code

# Install MCP tools
echo "🔗 Installing MCP tools..."
npm install -g @modelcontextprotocol/inspector @modelcontextprotocol/server-sequential-thinking @modelcontextprotocol/server-memory

# Install Python development tools
echo "🛠️ Installing Python development tools..."
uv tool install ruff
uv tool install pytest
uv tool install mypy

# Create necessary directories
echo "📁 Creating necessary directories..."
mkdir -p ~/.claude
mkdir -p .support/logs
chmod 755 .support/logs

# Install and configure zsh
echo "🐚 Setting up zsh shell environment..."
sudo apt-get update && sudo apt-get install -y zsh

# Install Oh My Zsh for better zsh experience
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Set zsh as default shell
sudo chsh -s $(which zsh) $USER

# Set up shell aliases and environment for both bash and zsh
echo "🐚 Configuring shell environment..."
cat >> ~/.bashrc << 'EOF'

# Claude Code Template Aliases
alias launch-claude='/workspace/claude-code-template/.support/scripts/launch-claude.sh'

# Environment variables for Claude Code
export CLAUDE_DEBUG=1
export MCP_DEBUG=1
export CLAUDE_CODE_ENABLE_TELEMETRY=1
export PYTHONIOENCODING=UTF-8

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"
EOF

# Configure zsh with same environment
cat >> ~/.zshrc << 'EOF'

# Claude Code Template Aliases
alias launch-claude='/workspace/claude-code-template/.support/scripts/launch-claude.sh'

# Environment variables for Claude Code
export CLAUDE_DEBUG=1
export MCP_DEBUG=1
export CLAUDE_CODE_ENABLE_TELEMETRY=1
export PYTHONIOENCODING=UTF-8

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"
EOF

# Set up Git configuration (if not already configured)
if [ -z "$(git config --global user.name)" ]; then
    echo "⚙️ Setting up basic Git configuration..."
    git config --global init.defaultBranch main
    git config --global pull.rebase false
fi

# Set up Git configuration and aliases
echo "🔧 Setting up Git configuration..."
echo 1. Credential Helper
git config --global credential.helper "!gh auth git-credential"
echo 2. Safe Directory: /workspace
git config --global --add safe.directory /workspace

# Set up authentication guidance
echo "🔐 Setting up authentication..."

# GitHub CLI authentication setup
echo "📋 GitHub CLI authentication status:"
if gh auth status >/dev/null 2>&1; then
    echo "✅ GitHub CLI is already authenticated"
    gh auth status
else
    echo "⚠️  GitHub CLI not authenticated"
    echo "   Run 'gh auth login' after container setup completes"
    echo "   This will authenticate both GitHub CLI and git operations"
fi

# Create authentication helper script
echo "🔐 Authentication Setup"
if [ ! -z $GH_TOKEN ]; then 
  echo Setting up GH login with token from GH_TOKEN
  echo $GH_TOKEN | gh auth login --with-token
  gh auth status
else
  echo GH_TOKEN is empty, run `gh auth login`
fi

# Verify installations
echo "✅ Verifying installations..."
echo "Node.js: $(node --version)"
echo "npm: $(npm --version)"
echo "Python: $(python3 --version)"
echo "uv: $(uv --version)"
echo "Git: $(git --version)"
echo "gh: $(gh --version)"
echo "Claude CLI: $(claude --version 2>/dev/null || echo 'Claude CLI installed, requires API key for full verification')"

echo ""
echo "🎉 DevContainer setup completed successfully!"
echo ""
