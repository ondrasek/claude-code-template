---
description: Create GitHub pull request with intelligent content generation.
argument-hint: Optional custom PR title, "draft" flag, or custom base branch.
allowed-tools: Task
---

# Pull Request Creator

Creates a GitHub pull request for the current branch using the github-pr-workflow specialist agent.

## Instructions

**OPERATIONAL RULES DISPLAY:**
- RULE 1: Display ALL rules (0-4) at the start of EVERY response ✓
- RULE 2: Task(specialist-git-workflow) to commit, tag, and push after EVERY meaningful change
- RULE 3: NEVER create artificial timelines or weekly milestones
- RULE 4: Follow file structure locations EXACTLY

1. **Parameter Processing**
   - Parse $ARGUMENTS for custom PR title, draft flag, or base branch specification
   - Pass all arguments to github-pr-workflow agent for comprehensive processing

2. **Agent Delegation**
   - Delegate complete PR creation workflow to github-pr-workflow specialist agent
   - Pass $ARGUMENTS containing any custom parameters (title, draft mode, base branch)
   - Agent handles all GitHub integration, content generation, and error recovery

## Usage Examples

```bash
# Create PR with auto-generated content
claude /pr

# Create PR with custom title
claude /pr "feat: implement advanced search functionality"

# Create draft PR explicitly
claude /pr draft

# Create PR with custom base branch
claude /pr --base develop
```