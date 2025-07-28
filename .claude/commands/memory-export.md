# Memory Export Command

Export all memories from MCP memory server to individual markdown files in the .support/memories/ folder.

## Usage
```
/memory-export
```

## What it does
- Reads all entities and relations from MCP memory server
- Creates individual .md files in .support/memories/ folder (one per entity)
- Uses YAML frontmatter with entity metadata
- Preserves memory structure for git-friendly version control
- Prevents context pollution by delegating to memory-export agent

## Agent Delegation
This command delegates to the `memory-export` agent to:
- Query MCP memory server using `mcp__memory__read_graph`
- Create .support/memories/ directory if needed
- Convert each entity to markdown format with YAML frontmatter
- Write individual files named by entity (sanitized for filesystem)
- Provide summary of exported memories

## Output Format
Each memory becomes a separate markdown file in the .support/memories/ directory, with filenames based on sanitized entity names.

## File Structure
```yaml
---
entity_name: "original_entity_name"
entity_type: "research_topic"
created: "2025-07-28"
source: "mcp_export"
exported: "2025-07-28T10:30:00Z"
---

# Memory Title

## Observations
- Observation 1
- Observation 2

## Context
Additional context and relationships...
```

## Use Cases
- Backup memories before major changes
- Share memory state with team members via git
- Migrate memories between environments
- Review and manually edit memory content
- Version control memory evolution

## Git Integration
Individual files enable:
- Parallel collaboration without merge conflicts
- Selective memory version control
- Clear diff/blame history per memory
- Easy removal of outdated memories