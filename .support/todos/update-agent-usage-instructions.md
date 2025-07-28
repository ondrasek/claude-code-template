---
status: completed
type: docs
priority: medium
assignee: docs
created: 2025-01-28
impact: patch
dependencies: [document-parallel-agent-clusters, remove-artificial-sequential-dependencies, create-workflow-templates-parallel-execution]
---

# Update Agent Usage Instructions

## Description
Revise CLAUDE.md and agent-usage.md to reflect parallel execution best practices

## Context
Current documentation needs updating to reflect the new parallel execution patterns and remove outdated sequential workflow descriptions.

## Changes Needed
- Update "Automatic Agent Invocation" section with parallel cluster guidance
- Replace sequential workflow descriptions with parallel cluster patterns
- Add performance hints for different agent combinations
- Document resource coordination for file-modifying agents

## Acceptance Criteria
- [ ] CLAUDE.md updated with parallel cluster guidance
- [ ] agent-usage.md updated with new workflow patterns
- [ ] Performance hints documented for agent combinations
- [ ] Resource coordination guidelines added

## Notes
Documentation should clearly explain when and how to use parallel agent clusters effectively.