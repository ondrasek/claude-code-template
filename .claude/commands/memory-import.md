# Memory Import Command

Import memories from markdown files in the .support/memories/ folder to the MCP memory server.

## Usage
```
/memory-import [--merge|--replace]
```

## Options
- `--merge` (default): Add new memories, preserve existing ones
- `--replace`: Clear existing memories and import from files

## What it does
- Reads all .md files from .support/memories/ folder
- Parses YAML frontmatter for entity metadata
- Creates entities and relations in MCP memory server
- Handles duplicate entities intelligently based on merge strategy
- Prevents context pollution by delegating to memory-import agent

## Agent Delegation
This command delegates to the `memory-import` agent to:
- Scan .support/memories/ folder for .md files
- Parse YAML frontmatter and markdown content
- Use MCP memory functions to create entities/relations
- Handle merge conflicts and duplicates
- Provide summary of imported memories

## Input Format
Expects files with this structure:
```yaml
---
entity_name: "research_topic_name"
entity_type: "research_topic"
created: "2025-07-28"
source: "mcp_export"
---

# Memory Content

## Observations
- Key finding 1
- Key finding 2
```

## Merge Strategies

### --merge (Default)
- Preserves existing memories in MCP server
- Adds new memories from files
- Updates existing memories if file is newer
- Safe for incremental imports

### --replace
- Clears all existing memories from MCP server
- Imports all memories from files
- Use for complete memory restoration
- **WARNING**: Destroys current memory state

## Error Handling
- Skips files with invalid YAML frontmatter
- Reports parsing errors without stopping import
- Validates entity_name and entity_type fields
- Continues import if individual memories fail

## Use Cases
- Restore memories after environment reset
- Import shared memories from team members
- Merge memories from different branches
- Recover from memory corruption
- Migrate memories between projects

## Safety Features
- Default merge mode preserves existing data
- Validation prevents malformed memory imports
- Detailed logging of import operations
- Rollback capability (MCP server dependent)