---
description: Fully automated Git Workflow Protocol implementation with intelligent commit messages.
argument-hint: Custom commit message to be appended to automatically determined commit message.
allowed-tools: Task
---

1. If $ARGUMENTS contains custom commit message, pass it to git-workflow agent
2. Otherwise, delegate complete Git Workflow Protocol automation to git-workflow agent
3. Check that the git-workflow agent committed all changes