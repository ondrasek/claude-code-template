---
description: Create GitHub pull request with intelligent content generation, semantic analysis, and automated workflow management.
argument-hint: Optional custom PR title, "draft" flag, or custom base branch.
allowed-tools: Task
---

# Pull Request Creator

Creates a GitHub pull request for the current branch with intelligent content generation, semantic commit analysis, and comprehensive GitHub integration. Delegates to the github-pr-workflow specialist agent for autonomous workflow management.

## Instructions

1. **Parameter Processing**
   - Parse $ARGUMENTS for:
     - Custom PR title (quoted string)
     - Draft flag ("draft" keyword)
     - Base branch (--base <branch-name>)
     - Any additional GitHub CLI flags
   - Validate parameters before delegation
   - Pass structured arguments to github-pr-workflow agent

2. **Agent Delegation**
   - Verify github-pr-workflow agent availability before delegation
   - Delegate complete PR creation workflow with parsed parameters
   - Agent performs:
     - Branch analysis and validation
     - Intelligent title/body generation from commits
     - Smart label detection and assignment
     - Comprehensive error handling and recovery
   - Display agent results or error messages to user

## Usage Examples

```bash
# Create PR with auto-generated content
claude /pr
# Output: ✅ PR #123 created with semantic title from commits

# Create PR with custom title
claude /pr "feat: implement advanced search functionality"
# Output: ✅ PR created with custom title and intelligent body

# Create draft PR explicitly
claude /pr draft
# Output: ✅ Draft PR created, ready for review preparation

# Create PR with custom base branch
claude /pr --base develop
# Output: ✅ PR targeting develop branch with commit analysis

# Advanced usage with multiple parameters
claude /pr "fix: resolve authentication issue" --base main draft
# Output: ✅ Draft PR created with custom title targeting main
```

## Error Handling

**Agent Unavailable**: If github-pr-workflow agent cannot be found, display error message with manual PR creation guidance.

**Parameter Validation Failures**: 
- Invalid base branch → Display available branches and retry guidance
- Malformed title → Suggest conventional commit format examples
- Authentication errors → Provide `gh auth login` instructions

**GitHub Integration Issues**: Agent handles comprehensive error recovery including:
- Branch not pushed to remote (auto-push with confirmation)
- Existing PR detection (display existing PR URL)
- Permission/authentication failures (guided resolution steps)
- Network connectivity issues (offline mode suggestions)

## Advanced Features

The github-pr-workflow agent provides sophisticated capabilities beyond basic PR creation:

- **Semantic Analysis**: Automatic title generation from conventional commits
- **Intelligent Labeling**: File-based and commit-based label assignment
- **Content Generation**: Comprehensive PR body with test plans and impact analysis
- **Branch Validation**: Prevents PRs from main/default branches
- **Template Integration**: Uses repository PR templates when available
- **Multi-commit Handling**: Intelligent summarization for complex changesets