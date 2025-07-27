#!/usr/bin/env bash

# Claude Code Dotfiles Installation Script
# This script is automatically run by GitHub Codespaces when setting up dotfiles

set -e # Exit on error

echo "🚀 Setting up Claude Code dotfiles..."

# Detect the home directory (works in both local and Codespaces environments)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${HOME}/.config/claude"

# Create necessary directories
echo "📁 Creating configuration directories..."
mkdir -p "${CONFIG_DIR}"
mkdir -p "${HOME}/.claude"

# Install Claude Code via npm if not already installed
if ! command -v claude &> /dev/null; then
    echo "📦 Installing Claude Code..."
    npm install -g claude-ai-cli
else
    echo "✅ Claude Code is already installed"
fi

# Link Claude configuration
echo "🔗 Setting up Claude Code configuration..."

# For dotfiles setup (when in Codespaces or using as dotfiles repo)
if [ -d "${DOTFILES_DIR}/.claude" ]; then
    # Create symlinks for each subdirectory
    for dir in "${DOTFILES_DIR}/.claude"/*; do
        if [ -d "$dir" ]; then
            dirname=$(basename "$dir")
            ln -sfn "$dir" "${HOME}/.claude/${dirname}"
            echo "   Linked .claude/${dirname}"
        fi
    done
fi

# Handle claude_config.json based on context
if [ -f "${DOTFILES_DIR}/claude_config.json" ]; then
    # When used as a template repository, claude_config.json should stay in project root
    # When used as dotfiles, we need it in ~/.claude/
    if [[ "${DOTFILES_DIR}" == *"dotfiles"* ]] || [[ "${CODESPACES}" == "true" ]]; then
        # This is a dotfiles setup
        mkdir -p "${HOME}/.claude"
        ln -sfn "${DOTFILES_DIR}/claude_config.json" "${HOME}/.claude/config.json"
        echo "   Linked claude_config.json for dotfiles setup"
    else
        # This is a project template - claude_config.json stays in project root
        echo "   Project template detected - claude_config.json remains in project root"
    fi
fi

# Set up shell aliases
echo "🐚 Setting up shell aliases..."
cat >> "${HOME}/.bashrc" << 'EOF'

# Claude Code aliases
alias cc='claude'
alias ccode='claude'
alias claude-init='claude /init'
alias claude-review='claude /review'
alias claude-test='claude /test'
alias claude-security='claude /security'

# Claude Code environment
export CLAUDE_CONFIG_PATH="${HOME}/.claude/config.json"
EOF

# Also add to .zshrc if it exists
if [ -f "${HOME}/.zshrc" ]; then
    cat >> "${HOME}/.zshrc" << 'EOF'

# Claude Code aliases
alias cc='claude'
alias ccode='claude'
alias claude-init='claude /init'
alias claude-review='claude /review'
alias claude-test='claude /test'
alias claude-security='claude /security'

# Claude Code environment
export CLAUDE_CONFIG_PATH="${HOME}/.claude/config.json"
EOF
fi

# Install MCP tools
echo "🔧 Installing MCP tools..."
npm install -g @modelcontextprotocol/inspector \
               @modelcontextprotocol/client-cli \
               @modelcontextprotocol/server-filesystem \
               @modelcontextprotocol/server-memory \
               @modelcontextprotocol/server-fetch || true

# Install uv for Python development
echo "🐍 Installing uv for Python development..."
if ! command -v uv &> /dev/null; then
    curl -LsSf https://astral.sh/uv/install.sh | sh || true
    echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> "${HOME}/.bashrc"
    echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> "${HOME}/.zshrc" 2>/dev/null || true
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# Install Python development tools using uv
echo "🤖 Installing Python development tools..."
if command -v uv &> /dev/null; then
    uv tool install ruff || true
    uv tool install pytest || true
    echo "   Note: Project-specific dependencies (langchain, crewai) should be added with 'uv add' in each project"
fi

# Set up Git configuration for Claude Code
echo "🔐 Configuring Git for Claude Code..."
git config --global alias.claude-commit '!claude "Please create a git commit with the staged changes"'
git config --global alias.claude-pr '!claude "Please create a pull request"'

# Create a welcome message
echo "✨ Claude Code dotfiles installation complete!"
echo ""
echo "Available commands:"
echo "  claude          - Start Claude Code"
echo "  cc              - Alias for claude"
echo "  claude-init     - Initialize project with CLAUDE.md"
echo "  claude-review   - Run code review"
echo "  claude-test     - Run test assistance"
echo "  claude-security - Run security audit"
echo ""
echo "Git aliases:"
echo "  git claude-commit - Create commit with Claude"
echo "  git claude-pr     - Create PR with Claude"
echo ""
echo "Run 'source ~/.bashrc' to reload your shell configuration."