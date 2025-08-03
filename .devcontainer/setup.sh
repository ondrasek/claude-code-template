#!/bin/bash

# DevContainer Setup Script - Replicates Codespace Environment
# This script sets up the exact same environment as the GitHub Codespace

set -e

echo "🚀 Setting up Claude Code Template DevContainer..."

# Detect if we're in a container environment
export CONTAINER_ENV=1
export CODESPACES=true

# Install uv (modern Python package manager)
echo "📦 Installing uv Python package manager..."
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.cargo/bin:$PATH"
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc

# Install Claude CLI globally
echo "🤖 Installing Claude CLI..."
npm install -g claude-ai-cli

# Install MCP tools
echo "🔗 Installing MCP tools..."
npm install -g @modelcontextprotocol/inspector @modelcontextprotocol/client-cli @modelcontextprotocol/server-memory

# Set up Python environment for MCP servers
echo "🐍 Setting up Python environment for MCP servers..."
cd .support/mcp-servers/perplexity
uv sync
cd - > /dev/null

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
alias cc='claude'
alias claude-init='claude /init'
alias launch-claude='/.support/scripts/launch-claude.sh'

# Environment variables for Claude Code
export CLAUDE_DEBUG=1
export MCP_DEBUG=1
export CLAUDE_CODE_ENABLE_TELEMETRY=1
export PYTHONIOENCODING=UTF-8

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Security aliases
alias validate-security='.devcontainer/security-validation.sh'
alias setup-secrets='.devcontainer/secure-secrets.sh'

EOF

# Configure zsh with same environment
cat >> ~/.zshrc << 'EOF'

# Claude Code Template Aliases
alias cc='claude'
alias claude-init='claude /init'
alias launch-claude='/.support/scripts/launch-claude.sh'

# Environment variables for Claude Code
export CLAUDE_DEBUG=1
export MCP_DEBUG=1
export CLAUDE_CODE_ENABLE_TELEMETRY=1
export PYTHONIOENCODING=UTF-8

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Security aliases
alias validate-security='.devcontainer/security-validation.sh'
alias setup-secrets='.devcontainer/secure-secrets.sh'

# Load secure secrets on shell startup
if [ -f ".devcontainer/secure-secrets.sh" ]; then
    source .devcontainer/secure-secrets.sh
fi

EOF

# Set up Git configuration (if not already configured)
if [ -z "$(git config --global user.name)" ]; then
    echo "⚙️ Setting up basic Git configuration..."
    git config --global init.defaultBranch main
    git config --global pull.rebase false
fi

# Set up Git configuration and aliases
echo "🔧 Setting up Git configuration..."
git config --global credential.helper "!gh auth git-credential"
git config --global alias.claude-commit '!claude "Please create a git commit with the staged changes"'
git config --global alias.claude-pr '!claude "Please create a pull request"'

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

# Claude CLI authentication setup
echo "📋 Claude CLI authentication status:"
if claude auth status >/dev/null 2>&1; then
    echo "✅ Claude CLI is already authenticated"
else
    echo "⚠️  Claude CLI not authenticated"
    echo "   Set your CLAUDE_API_KEY environment variable:"
    echo "   export CLAUDE_API_KEY='<your-api-key-here>'"
    echo "   Or run 'claude auth login' for interactive setup"
fi

# Create authentication helper script
cat > /tmp/setup-auth.sh << 'EOF'
#!/bin/bash
echo "🔐 DevContainer Authentication Setup"
echo "==================================="
echo ""
echo "1. GitHub Authentication:"
echo "   gh auth login"
echo ""
echo "2. Claude Authentication:"
echo "   Option A: Set environment variable"
echo "   export CLAUDE_API_KEY='<your-api-key-here>'"
echo "   echo 'export CLAUDE_API_KEY=\"<your-api-key-here>\"' >> ~/.bashrc"
echo ""
echo "   Option B: Interactive login"
echo "   claude auth login"
echo ""
echo "3. Verify authentication:"
echo "   gh auth status"
echo "   claude auth status"
echo ""
echo "4. Optional: Set Perplexity API key for MCP server"
echo "   export PERPLEXITY_API_KEY='<your-perplexity-key>'"
echo "   echo 'export PERPLEXITY_API_KEY=\"<your-key>\"' >> ~/.bashrc"
EOF
chmod +x /tmp/setup-auth.sh

# Verify installations
echo "✅ Verifying installations..."
echo "Node.js: $(node --version)"
echo "npm: $(npm --version)"
echo "Python: $(python3 --version)"
echo "uv: $(uv --version)"
echo "Git: $(git --version)"
echo "Claude CLI: $(claude --version 2>/dev/null || echo 'Claude CLI installed, requires API key for full verification')"

# Create a validation script
cat > /tmp/validate-environment.sh << 'EOF'
#!/bin/bash
echo "🔍 DevContainer Environment Validation"
echo "======================================"
echo "Node.js: $(node --version)"
echo "npm: $(npm --version)" 
echo "Python: $(python3 --version)"
echo "uv: $(uv --version)"
echo "Git: $(git --version)"
echo "Docker: $(docker --version 2>/dev/null || echo 'Docker available via docker-outside-of-docker')"
echo "GitHub CLI: $(gh --version | head -1)"
echo ""
echo "Python packages:"
uv tool list 2>/dev/null || echo "uv tools not installed"
echo ""
echo "npm global packages:"
npm list -g --depth=0 2>/dev/null | grep -E "(claude-ai-cli|@modelcontextprotocol)" || echo "MCP packages need verification"
echo ""
echo "Environment variables:"
echo "CODESPACES: $CODESPACES"
echo "CLAUDE_DEBUG: $CLAUDE_DEBUG"
echo "MCP_DEBUG: $MCP_DEBUG"
echo ""
echo "✅ DevContainer setup complete!"
EOF
chmod +x /tmp/validate-environment.sh

echo ""
echo "🎉 DevContainer setup completed successfully!"
echo "📋 Run '/tmp/validate-environment.sh' to validate the environment"
echo "🔐 Run '/tmp/setup-auth.sh' for authentication setup instructions"
echo ""
echo "⚡ Quick authentication setup:"
echo "   1. GitHub: gh auth login"
echo "   2. Claude: export CLAUDE_API_KEY='<your-api-key>'"
echo "   3. Optional: export PERPLEXITY_API_KEY='<your-key>'"
echo ""