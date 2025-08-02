---
description: Fully automated Git Protocol implementation with intelligent commit messages.
argument-hint: Custom commit message to be appended to automatically determined commit message.
allowed-tools: Read, Write, Edit, MultiEdit, Glob, Bash, Task
---

# Git Protocol Automation

Fully automated Git Protocol implementation using specialist-git-workflow agent with intelligent commit message generation.

## Instructions

1. If $ARGUMENTS contains custom commit message, pass it to specialist-git-workflow agent
2. Otherwise, delegate complete Git Protocol automation to specialist-git-workflow agent
3. Check that the specialist-git-workflow agent committed all changes
4. Use agents to check that the specialist-git-workflow agent updated CHANGELOG.md, use agents to update it otherwise
5. Use agents to check that the specialist-git-workflow agent updated README.md, use agents to update it otherwise

This command implements the complete Git Protocol as described in CLAUDE.md by delegating all git operations to the
specialist-git-workflow agent. This prevents context window clutter while ensuring full protocol compliance.

**Example intelligent commit message generation:**
- Modified `.claude/agents/` → "Update agent definitions for improved functionality"
- Changed `src/components/` → "Enhance UI components with new features"
- Added `.claude/commands/` → "Add new slash commands for workflow automation"
- Updated `README.md` → "Update documentation to reflect current features"

## README.md Update Instructions

When release tags are created, the command automatically spawns a **specialist-code-cleaner** agent to:
- Update README.md with current repository state
- Reflect new features, commands, and capabilities
- Update version information and installation instructions
- Ensure documentation accuracy matches codebase
- Maintain consistent formatting and structure

This keeps README.md always current without cluttering the main context window.

## Error Handling

The specialist-git-workflow agent handles:
- Merge conflicts and resolution guidance
- Authentication issues
- Network connectivity problems
- Repository corruption detection
- Branch synchronization issues
- Tag conflicts and resolution

## Security Considerations

- Agent validates all git operations before execution
- Sensitive information is redacted from logs and reports
- Authentication credentials are handled securely
- Branch protection rules are respected
- Force pushes are avoided unless explicitly required
