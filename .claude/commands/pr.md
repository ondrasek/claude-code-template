---
description: Create GitHub pull request with intelligent content generation and workflow integration.
argument-hint: Optional custom PR title or "draft" to create draft PR.
allowed-tools: Bash, Task, Read
---

# Pull Request Creator

Creates a GitHub pull request for the current branch with intelligent title and body generation. Integrates with existing git-workflow automation and follows operational rules.

## Instructions

1. **Branch Validation**
   - Check if current branch is main branch - if so, display warning and exit
   - Verify branch exists and has commits different from main branch
   - If no differences found, inform user and exit gracefully

2. **Existing PR Check**
   - Use `gh pr list --head "$(git branch --show-current)" --state open` to check for existing PR
   - If PR exists, display PR URL and open in browser with `gh pr view --web`
   - Skip creation if PR already exists

3. **Pre-flight Requirements**
   - Ensure branch is pushed to remote origin
   - If not pushed, delegate to git-workflow agent: `Task(git-workflow) to push current branch to remote`
   - Verify GitHub CLI authentication with `gh auth status`

4. **Intelligent Content Generation**
   - Generate PR title from recent commits using conventional commit format
   - Extract semantic meaning from commit messages (docs:, feat:, fix:, refactor:)
   - Create comprehensive PR body with:
     - Summary section with bullet points of changes
     - Test plan section with validation checklist
     - File changes summary from git diff
     - Standard footer with Claude Code attribution

5. **PR Creation with Smart Defaults**
   - Use git-workflow agent for complex git operations: `Task(git-workflow) to analyze branch changes and generate PR content`
   - Create draft PR by default (can be changed to ready later)
   - Auto-assign to current user (@me)
   - Detect and apply relevant labels based on file changes and commit types
   - Set base branch to main (or detected default branch)

6. **Error Handling**
   - Handle authentication errors with clear guidance
   - Manage permission issues for fork repositories
   - Provide fallback if automated content generation fails
   - Graceful handling of rate limiting or network issues

7. **Post-Creation Actions**
   - Display PR URL and key details
   - Open PR in browser for review
   - Provide next steps guidance (reviewers, labels, etc.)

## Error Recovery

- If PR creation fails, provide diagnostic information
- Suggest manual PR creation via GitHub web interface as fallback
- Preserve generated content for manual use
- Guide user through authentication setup if needed