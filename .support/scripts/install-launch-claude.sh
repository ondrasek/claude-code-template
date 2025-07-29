#!/bin/bash

# install-launch-claude.sh - Install launch-claude alias for enhanced Claude Code wrapper
# This script adds the launch-claude alias to your shell configuration

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAUNCH_CLAUDE_SCRIPT="$SCRIPT_DIR/launch-claude.sh"

# Function to print colored output
print_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
print_success() { echo -e "${GREEN}✅ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }

# Function to detect shell
detect_shell() {
    if [[ -n "${ZSH_VERSION:-}" ]]; then
        echo "zsh"
    elif [[ -n "${BASH_VERSION:-}" ]]; then
        echo "bash"
    else
        echo "unknown"
    fi
}

# Function to get shell config file
get_shell_config() {
    local shell_type="$1"
    case $shell_type in
        zsh)
            if [[ -f "$HOME/.zshrc" ]]; then
                echo "$HOME/.zshrc"
            else
                echo "$HOME/.zshrc"
            fi
            ;;
        bash)
            if [[ -f "$HOME/.bashrc" ]]; then
                echo "$HOME/.bashrc"
            elif [[ -f "$HOME/.bash_profile" ]]; then
                echo "$HOME/.bash_profile"
            else
                echo "$HOME/.bashrc"
            fi
            ;;
        *)
            echo ""
            ;;
    esac
}

# Function to add alias to shell config
add_alias() {
    local config_file="$1"
    local alias_line="alias launch-claude='$LAUNCH_CLAUDE_SCRIPT'"
    
    # Check if alias already exists
    if grep -q "alias launch-claude=" "$config_file" 2>/dev/null; then
        print_warning "launch-claude alias already exists in $config_file"
        print_info "Updating existing alias..."
        
        # Remove old alias and add new one
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS
            sed -i '' "/alias launch-claude=/d" "$config_file"
        else
            # Linux
            sed -i "/alias launch-claude=/d" "$config_file"
        fi
    fi
    
    # Add the alias
    echo "" >> "$config_file"
    echo "# launch-claude - Enhanced Claude Code wrapper" >> "$config_file"
    echo "$alias_line" >> "$config_file"
    
    print_success "Added launch-claude alias to $config_file"
}

# Function to install for specific shell
install_for_shell() {
    local shell_type="$1"
    local config_file
    config_file=$(get_shell_config "$shell_type")
    
    if [[ -z "$config_file" ]]; then
        print_error "Could not determine config file for $shell_type"
        return 1
    fi
    
    print_info "Installing launch-claude alias for $shell_type shell"
    print_info "Config file: $config_file"
    
    # Create config file if it doesn't exist
    if [[ ! -f "$config_file" ]]; then
        touch "$config_file"
        print_info "Created $config_file"
    fi
    
    add_alias "$config_file"
    
    print_success "Installation complete for $shell_type"
    print_info "To use immediately, run: source $config_file"
    print_info "Or start a new terminal session"
}

# Main installation function
main() {
    print_info "Installing launch-claude - Enhanced Claude Code wrapper"
    print_info "Script location: $LAUNCH_CLAUDE_SCRIPT"
    
    # Verify launch-claude.sh exists and is executable
    if [[ ! -f "$LAUNCH_CLAUDE_SCRIPT" ]]; then
        print_error "launch-claude.sh not found at $LAUNCH_CLAUDE_SCRIPT"
        exit 1
    fi
    
    if [[ ! -x "$LAUNCH_CLAUDE_SCRIPT" ]]; then
        print_warning "Making launch-claude.sh executable"
        chmod +x "$LAUNCH_CLAUDE_SCRIPT"
    fi
    
    # Detect current shell
    local current_shell
    current_shell=$(detect_shell)
    
    if [[ "$current_shell" == "unknown" ]]; then
        print_warning "Could not detect shell type"
        print_info "Please manually add this alias to your shell config:"
        print_info "alias launch-claude='$LAUNCH_CLAUDE_SCRIPT'"
        exit 1
    fi
    
    print_info "Detected shell: $current_shell"
    
    # Install for current shell
    install_for_shell "$current_shell"
    
    # Also install for other common shells if their config files exist
    for shell in bash zsh; do
        if [[ "$shell" != "$current_shell" ]]; then
            local config_file
            config_file=$(get_shell_config "$shell")
            if [[ -n "$config_file" && -f "$config_file" ]]; then
                print_info "Found $shell config, installing there too..."
                install_for_shell "$shell"
            fi
        fi
    done
    
    echo
    print_success "🎉 launch-claude installation complete!"
    print_info "Usage examples:"
    echo "  launch-claude \"Review my code\""
    echo "  launch-claude --verbose --debug \"Complex analysis\""
    echo "  launch-claude --save-logs \"Debug session\""
    echo "  launch-claude --analyze-logs"
    echo "  launch-claude --help"
    echo
    print_info "To start using launch-claude immediately:"
    print_info "source $(get_shell_config "$current_shell")"
    print_info "Or open a new terminal"
}

# Run main function
main "$@"