#!/bin/bash
set -euo pipefail

# Git Worktree Creation Utility
# Creates and manages git worktrees for parallel development workflows
# Usage: ./worktree-create.sh <branch-name> [issue-number]

WORKTREE_BASE="/workspace/worktrees"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MAIN_REPO="$(cd "$SCRIPT_DIR/.." && pwd)"

# Determine repository name dynamically
get_repo_name() {
    local repo_name=""
    
    # Try GitHub CLI first (if available and authenticated)
    if command -v gh >/dev/null 2>&1; then
        repo_name=$(gh repo view --json name --jq .name 2>/dev/null || echo "")
    fi
    
    # Fallback to basename of repository directory
    if [[ -z "$repo_name" ]]; then
        repo_name=$(basename "$MAIN_REPO")
    fi
    
    # Validate repo name (security check)
    if [[ ! "$repo_name" =~ ^[a-zA-Z0-9._-]+$ ]] || [[ ${#repo_name} -gt 100 ]]; then
        print_error "Invalid repository name detected: $repo_name"
        return 1
    fi
    
    echo "$repo_name"
}

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
print_error() { echo -e "${RED}ERROR:${NC} $1" >&2; }
print_success() { echo -e "${GREEN}SUCCESS:${NC} $1"; }
print_warning() { echo -e "${YELLOW}WARNING:${NC} $1"; }
print_info() { echo -e "${BLUE}INFO:${NC} $1"; }

# Usage information
show_usage() {
    cat << EOF
Usage: $0 <branch-name> [issue-number]

Creates a git worktree for parallel development workflow.

Arguments:
  branch-name     Name of the branch to create worktree for
  issue-number    Optional GitHub issue number for validation

Examples:
  $0 feature/new-agent
  $0 claude/issue-105-worktree 105
  $0 hotfix/critical-bug

Location: Worktrees created in $WORKTREE_BASE/<repository>/<branch-name>
EOF
}

# Validate branch name
validate_branch_name() {
    local branch="$1"
    
    # Check for empty branch name
    if [[ -z "$branch" ]]; then
        print_error "Branch name cannot be empty"
        return 1
    fi
    
    # Check length (reasonable limit)
    if [[ ${#branch} -gt 100 ]]; then
        print_error "Branch name too long (max 100 characters)"
        return 1
    fi
    
    # Validate characters (alphanumeric, hyphens, underscores, forward slashes)
    if [[ ! "$branch" =~ ^[a-zA-Z0-9/_-]+$ ]]; then
        print_error "Branch name contains invalid characters. Only alphanumeric, hyphens, underscores, and forward slashes allowed"
        return 1
    fi
    
    # Prevent path traversal sequences
    if [[ "$branch" =~ \.\. ]] || [[ "$branch" =~ ^/ ]] || [[ "$branch" =~ //+ ]]; then
        print_error "Branch name contains invalid path sequences"
        return 1
    fi
    
    # Prevent git-sensitive names
    if [[ "$branch" =~ ^(HEAD|refs|objects|hooks)$ ]]; then
        print_error "Branch name conflicts with git internals"
        return 1
    fi
    
    return 0
}

# Validate issue number (optional)
validate_issue_number() {
    local issue="$1"
    
    if [[ -n "$issue" ]]; then
        if [[ ! "$issue" =~ ^[0-9]+$ ]] || [[ $issue -lt 1 ]] || [[ $issue -gt 99999 ]]; then
            print_error "Issue number must be a positive integer (1-99999)"
            return 1
        fi
        
        # Validate issue exists on GitHub (if gh CLI available)
        if command -v gh >/dev/null 2>&1; then
            if ! gh issue view "$issue" --repo ondrasek/ai-code-forge --json number >/dev/null 2>&1; then
                print_warning "Issue #$issue not found or not accessible (continuing anyway)"
            fi
        else
            print_info "GitHub CLI not available - skipping issue validation"
        fi
    fi
    
    return 0
}

# Create worktree directory safely
create_worktree_path() {
    local branch="$1"
    local repo_name
    repo_name=$(get_repo_name) || return 1
    local worktree_path="$WORKTREE_BASE/$repo_name/$branch"
    
    # Ensure base directories exist
    if [[ ! -d "$WORKTREE_BASE" ]]; then
        print_info "Creating worktree base directory: $WORKTREE_BASE" >&2
        mkdir -p "$WORKTREE_BASE"
    fi
    
    local repo_base="$WORKTREE_BASE/$repo_name"
    if [[ ! -d "$repo_base" ]]; then
        print_info "Creating repository worktree directory: $repo_base" >&2
        mkdir -p "$repo_base"
    fi
    
    # Check if worktree already exists
    if [[ -d "$worktree_path" ]]; then
        print_error "Worktree already exists at: $worktree_path"
        return 1
    fi
    
    # Validate final path is within worktree base (security check)
    local canonical_path
    canonical_path=$(realpath -m "$worktree_path")
    local canonical_base
    canonical_base=$(realpath -m "$WORKTREE_BASE")
    
    if [[ ! "$canonical_path" =~ ^"$canonical_base"/ ]]; then
        print_error "Path escapes worktree boundary: $canonical_path"
        return 1
    fi
    
    echo "$canonical_path"
}

# Create git worktree
create_git_worktree() {
    local branch="$1"
    local worktree_path="$2"
    
    print_info "Creating git worktree for branch: $branch"
    
    # Change to main repository directory
    cd "$MAIN_REPO"
    
    # Check if branch exists locally or remotely
    local branch_exists=false
    if git show-ref --verify --quiet "refs/heads/$branch"; then
        print_info "Using existing local branch: $branch"
        branch_exists=true
    elif git show-ref --verify --quiet "refs/remotes/origin/$branch"; then
        print_info "Using existing remote branch: origin/$branch"
        branch_exists=true
    else
        print_info "Creating new branch: $branch"
    fi
    
    # Create worktree
    if $branch_exists; then
        git worktree add "$worktree_path" "$branch"
    else
        # Create new branch based on current HEAD
        git worktree add -b "$branch" "$worktree_path"
    fi
    
    return $?
}

# Main execution
main() {
    local branch_name="$1"
    local issue_number="${2:-}"
    
    print_info "Git Worktree Creation Utility"
    print_info "=============================="
    
    # Validate inputs
    validate_branch_name "$branch_name" || exit 1
    validate_issue_number "$issue_number" || exit 1
    
    # Create worktree path
    local worktree_path
    worktree_path=$(create_worktree_path "$branch_name") || exit 1
    
    # Create git worktree
    if create_git_worktree "$branch_name" "$worktree_path"; then
        print_success "Worktree created successfully!"
        print_info "Location: $worktree_path"
        print_info ""
        print_info "To work in this worktree:"
        print_info "  cd \"$worktree_path\""
        print_info "  # Launch Claude Code from this directory"
    else
        print_error "Failed to create git worktree"
        # Cleanup partial directory if created
        [[ -d "$worktree_path" ]] && rmdir "$worktree_path" 2>/dev/null
        exit 1
    fi
}

# Check arguments
if [[ $# -lt 1 ]] || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    show_usage
    exit 0
fi

# Execute main function
main "$@"