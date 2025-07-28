Define principles to determine when and what agents should we create: generic and repo-specific ones.

For example:
1. Claude Code sub-agents are AI-first and AI-optimized. There is no need for sub-agents to reflect human roles in human-centric teams or organizations.
2. Claude Code sub-agents reflect thinking patterns or perspectives. For example: one agent focuses on opportunistic and optimistic ideation whereas another agent focuses on eliminating sycophancy and provides assertive criticism.
3. Claude Code sub-agents exist to eliminate context window clutter. Actions which can be self-contained without leaking into the main cotext window should be encapsulated as agents. For example, we can have an agent that analyzes the codebase and determines whether the recent changes mandate creating a git tag to preresent a new semantic version.
