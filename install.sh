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

# The .claude directory contains all configuration
# When using as dotfiles, it will be symlinked to ~/.claude
# When using as a template, .claude/settings.json will be in the project

# Set up shell configuration
echo "🐚 Setting up shell configuration..."

# Create a shell configuration snippet
SHELL_CONFIG=$(cat << EOF

# Claude Code aliases
alias cc='claude'
alias ccode='claude'
alias claude-init='claude /init'
alias claude-review='claude /review'
alias claude-test='claude /test'
alias claude-security='claude /security'

# Dotfiles directory location
export CLAUDE_DOTFILES_DIR="${DOTFILES_DIR}"

# Dotfiles update alias
alias update-dotfiles='if [ -n "\${CLAUDE_DOTFILES_DIR}" ] && [ -d "\${CLAUDE_DOTFILES_DIR}" ]; then cd "\${CLAUDE_DOTFILES_DIR}" && git pull && echo "✅ Dotfiles updated!"; else echo "❌ Dotfiles directory not found. You may need to re-run install.sh"; fi'

# Claude Code environment
export CLAUDE_CONFIG_PATH="\${HOME}/.claude/config.json"
EOF
)

# Add to .bashrc
echo "${SHELL_CONFIG}" >> "${HOME}/.bashrc"
echo "   Added configuration to .bashrc"

# Add to .zshrc if it exists
if [ -f "${HOME}/.zshrc" ]; then
    echo "${SHELL_CONFIG}" >> "${HOME}/.zshrc"
    echo "   Added configuration to .zshrc"
fi

# Add to .profile for login shells
if [ -f "${HOME}/.profile" ]; then
    echo "${SHELL_CONFIG}" >> "${HOME}/.profile"
    echo "   Added configuration to .profile"
fi

# Install MCP tools (only non-redundant ones)
echo "🔧 Installing MCP tools..."
echo "   Note: Claude Code has built-in filesystem and web tools"
echo "   Only installing MCP servers that add unique functionality"
npm install -g @modelcontextprotocol/inspector \
               @modelcontextprotocol/client-cli \
               @modelcontextprotocol/server-memory || true

# Install uv for Python development
echo "🐍 Installing uv for Python development..."
if ! command -v uv &> /dev/null; then
    curl -LsSf https://astral.sh/uv/install.sh | sh || true
    
    # Add uv to PATH in all shell configs
    UV_PATH_EXPORT='export PATH="$HOME/.cargo/bin:$PATH"'
    echo "${UV_PATH_EXPORT}" >> "${HOME}/.bashrc"
    [ -f "${HOME}/.zshrc" ] && echo "${UV_PATH_EXPORT}" >> "${HOME}/.zshrc"
    [ -f "${HOME}/.profile" ] && echo "${UV_PATH_EXPORT}" >> "${HOME}/.profile"
    
    # Also export for current session
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
echo "  update-dotfiles - Pull latest dotfiles changes"
echo ""
echo "Git aliases:"
echo "  git claude-commit - Create commit with Claude"
echo "  git claude-pr     - Create PR with Claude"
echo ""
echo "Run 'source ~/.bashrc' to reload your shell configuration."