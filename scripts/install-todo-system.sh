#!/bin/bash
# Install Claude Code TODO Management System
# Integrates the TODO and CHANGELOG automation into existing Claude Code setup

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

error() { echo -e "${RED}Error: $1${NC}" >&2; exit 1; }
success() { echo -e "${GREEN}✓ $1${NC}"; }
info() { echo -e "${BLUE}ℹ $1${NC}"; }
warning() { echo -e "${YELLOW}⚠ $1${NC}"; }

info "Installing Claude Code TODO Management System..."

# Check dependencies
if ! command -v python3 &> /dev/null; then
    error "Python 3 is required but not installed"
fi

# Install Python dependencies
info "Installing Python dependencies..."
pip3 install --user pyyaml || error "Failed to install PyYAML"

# Make scripts executable
info "Setting script permissions..."
chmod +x "$SCRIPT_DIR/claude-todo"
chmod +x "$SCRIPT_DIR/todo-manager.py"

# Add to PATH if not already there
PROFILE_FILE=""
if [[ -f "$HOME/.bashrc" ]]; then
    PROFILE_FILE="$HOME/.bashrc"
elif [[ -f "$HOME/.zshrc" ]]; then
    PROFILE_FILE="$HOME/.zshrc"
fi

if [[ -n "$PROFILE_FILE" ]]; then
    if ! grep -q "claude-todo" "$PROFILE_FILE"; then
        info "Adding claude-todo to PATH in $PROFILE_FILE..."
        echo "" >> "$PROFILE_FILE"
        echo "# Claude Code TODO Management" >> "$PROFILE_FILE"
        echo "export PATH=\"$SCRIPT_DIR:\$PATH\"" >> "$PROFILE_FILE"
        echo "alias todo='claude-todo'" >> "$PROFILE_FILE"
        echo "alias todo-list='claude-todo list'" >> "$PROFILE_FILE"
        echo "alias todo-stats='claude-todo stats'" >> "$PROFILE_FILE"
        success "Added aliases to $PROFILE_FILE"
        warning "Run 'source $PROFILE_FILE' or restart your shell to use the aliases"
    else
        info "PATH already contains claude-todo"
    fi
fi

# Create initial TODO.md if it doesn't exist
if [[ ! -f "$PROJECT_ROOT/TODO.md" ]]; then
    info "Creating initial TODO.md..."
    cat > "$PROJECT_ROOT/TODO.md" << 'EOF'
# Project TODOs

## Statistics
- Total TODOs: 0
- Pending: 0
- In Progress: 0
- Completed (this version): 0
- Blocked: 0
- Cancelled: 0

## Quick Actions
- [Add New TODO](#add-new-todo)
- [Start Work](#start-work)
- [Complete TODO](#complete-todo)

## TODOs by Status

### 🚀 In Progress

### ⏳ Pending

### ⛔ Blocked

### ✅ Completed (Current Version)

### ❌ Cancelled

---

<!-- Detailed TODO entries follow -->

<!-- Use /todo command or claude-todo CLI to add new TODOs -->
<!-- Example: claude-todo add "Fix authentication bug" --type bug --impact patch --priority high -->
EOF
    success "Created initial TODO.md"
else
    info "TODO.md already exists"
fi

# Create git aliases for TODO workflow
info "Adding git aliases for TODO workflow..."
git config --global alias.todo-commit '!f() { git add -A && git commit -m "$1" -m "" -m "🤖 Generated with [Claude Code](https://claude.ai/code)" -m "" -m "Co-Authored-By: Claude <noreply@anthropic.com>"; }; f'
git config --global alias.todo-release '!f() { claude-todo release && git push origin main && git push --tags; }; f'

# Update .gitignore to include TODO system files
GITIGNORE="$PROJECT_ROOT/.gitignore"
if [[ -f "$GITIGNORE" ]]; then
    if ! grep -q "# TODO Management" "$GITIGNORE"; then
        info "Updating .gitignore..."
        echo "" >> "$GITIGNORE"
        echo "# TODO Management System" >> "$GITIGNORE"
        echo "*.todo-backup" >> "$GITIGNORE"
        echo ".todo-cache/" >> "$GITIGNORE"
    fi
fi

# Test the installation
info "Testing installation..."
if "$SCRIPT_DIR/claude-todo" help &> /dev/null; then
    success "claude-todo command works correctly"
else
    error "claude-todo command failed"
fi

# Integration with existing Claude Code commands
info "Integrating with Claude Code commands..."

# Update CLAUDE.md to reference TODO system
CLAUDE_MD="$PROJECT_ROOT/CLAUDE.md"
if [[ -f "$CLAUDE_MD" ]]; then
    if ! grep -q "TODO Management System" "$CLAUDE_MD"; then
        info "Adding TODO system documentation to CLAUDE.md..."
        cat >> "$CLAUDE_MD" << 'EOF'

## TODO Management System

This project includes an automated TODO and CHANGELOG management system:

### Commands
- `/todo` - Add new TODO with SemVer impact classification
- `/todo-release` - Generate release from completed TODOs
- `claude-todo` - CLI utility for TODO management

### Workflow
1. Add TODOs with semantic versioning impact: `/todo "Fix bug" --type bug --impact patch`
2. Assign to agents: `--assignee researcher`
3. Track progress: `claude-todo start TODO-001`
4. Complete work: `claude-todo complete TODO-001`
5. Generate releases: `claude-todo release`

### SemVer Integration
- **major**: Breaking changes, API removals
- **minor**: New features, backward-compatible additions  
- **patch**: Bug fixes, documentation, improvements

See `docs/todo-management-system.md` for complete documentation.
EOF
        success "Added TODO system documentation to CLAUDE.md"
    fi
fi

# Create example TODOs to demonstrate the system
info "Creating example TODOs..."
"$SCRIPT_DIR/claude-todo" add "Improve error handling in API endpoints" --type improvement --impact patch --priority medium --assignee patterns --description "Add comprehensive error handling and validation to all API endpoints" 2>/dev/null || true
"$SCRIPT_DIR/claude-todo" add "Add integration tests for authentication" --type test --impact patch --priority high --assignee completer --description "Create comprehensive integration tests for user authentication flows" 2>/dev/null || true

success "Installation completed successfully!"

echo ""
info "Next steps:"
echo "  1. Run 'source ~/.bashrc' (or ~/.zshrc) to enable aliases"
echo "  2. Try 'claude-todo help' to see available commands"
echo "  3. Use '/todo' command in Claude Code to add TODOs"
echo "  4. Use 'claude-todo list' to see current TODOs"
echo "  5. Read docs/todo-management-system.md for full documentation"
echo ""
info "Quick start:"
echo "  claude-todo add \"Your first TODO\" --type feature --impact minor --priority high"
echo "  claude-todo list"
echo "  claude-todo stats"