---
description: Fully automated Git Workflow Protocol implementation with intelligent commit messages.
argument-hint: Custom commit message to be appended to automatically determined commit message.
allowed-tools: Read, Write, Edit, MultiEdit, Glob, Bash, Task
---

# Git Workflow Protocol Automation

Fully automated Git Workflow Protocol implementation using git-workflow agent with intelligent commit message generation.

## Instructions

1. If $ARGUMENTS contains custom commit message, pass it to git-workflow agent
2. Otherwise, delegate complete Git Workflow Protocol automation to git-workflow agent
3. Check that the git-workflow agent committed all changes
4. Verify git-workflow agent completed all operations successfully

This command implements the complete Git Workflow Protocol as described in CLAUDE.md by delegating all git operations to the git-workflow agent. This prevents context window clutter while ensuring full protocol compliance.

The git-workflow agent provides comprehensive commit message generation, documentation updates, and release tagging using sophisticated validation criteria and conventional commit formats.

## Error Handling

The git-workflow agent provides comprehensive troubleshooting with systematic diagnosis and resolution for all git issues. See the git-workflow agent documentation for detailed troubleshooting framework covering:
- Repository state issues and corruption recovery
- Remote synchronization and authentication problems  
- Merge conflicts and history management
- Branch management and configuration issues

## Command Responsibilities

**Git Command (this file):**
- User interface and argument parsing
- Delegation to git-workflow agent
- Custom commit message pass-through

**Git-Workflow Agent:**
- All git operations and validation logic
- Intelligent staging and commit message generation
- Release tagging evaluation and execution
- Comprehensive troubleshooting and error resolution
- README.md and CHANGELOG.md update management
- Security validation and sensitive data protection
