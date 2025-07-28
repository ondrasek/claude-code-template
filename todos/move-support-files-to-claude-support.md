---
status: pending
type: refactor
priority: medium
assignee: patterns
created: 2025-07-28
impact: patch
---

# Move Support Files to .claude/support Directory

## Problem Statement
Repository root is cluttered with support files that aren't core to the template functionality but are needed for Claude Code operation. These files make the repository appear messy and mix operational data with template content.

## Proposed Solution
Create `.claude/support/` directory for files that Claude Code doesn't process but are needed for operation, keeping the repository root clean and organized.

## Files to Move

### Current Structure:
```
/
├── .mcp/                    # MCP server storage
│   ├── memory.db
│   ├── project.db
│   └── README.md
├── memories/                # Memory dump files
│   ├── agent-parallelism-alternatives.md
│   ├── claude-md-analysis-task.md
│   └── successful-tag-v2-0-1.md
├── MEMORY.md               # Memory overview
└── TODO.md                 # Legacy TODO file
```

### Proposed Structure:
```
.claude/support/
├── mcp/                    # MCP server storage (renamed)
│   ├── memory.db
│   ├── project.db
│   └── README.md
├── memories/               # Memory dump files
│   ├── agent-parallelism-alternatives.md
│   ├── claude-md-analysis-task.md
│   └── successful-tag-v2-0-1.md
├── MEMORY.md              # Memory overview
└── TODO.md                # Legacy TODO file (archive)
```

## Implementation Steps

### 1. Create Support Directory Structure
```bash
mkdir -p .claude/support/{mcp,memories}
```

### 2. Move Files
```bash
# Move MCP storage
mv .mcp/* .claude/support/mcp/
rmdir .mcp

# Move memory files
mv memories/* .claude/support/memories/
rmdir memories
mv MEMORY.md .claude/support/

# Archive legacy TODO
mv TODO.md .claude/support/
```

### 3. Update Configuration Files

#### Update .mcp.json:
```json
{
  "mcpServers": {
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"],
      "env": {
        "MEMORY_DB_PATH": ".claude/support/mcp/memory.db"
      }
    },
    "sqlite": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sqlite", "--db-path", ".claude/support/mcp/project.db"]
    }
  }
}
```

#### Update .gitignore:
```gitignore
# MCP Memory Server Data - Support Files
.claude/support/mcp/memory.db
.claude/support/mcp/project.db
.claude/support/mcp/*.db-wal
.claude/support/mcp/*.db-shm
```

#### Update setup script:
```bash
# scripts/setup-claude-memory.sh
mkdir -p .claude/support/mcp
# Update all paths to use .claude/support/mcp/
```

### 4. Update Documentation
- Update README.md references to new paths
- Update script documentation
- Add note about .claude/support directory purpose

## Benefits

### Repository Organization
- **Clean Root**: Repository root contains only template files
- **Logical Grouping**: All Claude Code support files in one location
- **Hidden from Main View**: .claude/support naturally hidden in most file browsers
- **Professional Appearance**: Repository looks cleaner and more focused

### Operational Clarity
- **Clear Separation**: Template content vs operational support files
- **Easy Maintenance**: All support files in predictable location
- **Backup Friendly**: Single directory contains all operational data
- **Development Focus**: Template users see template content, not operational files

### Claude Code Integration
- **No Processing**: Claude Code ignores .claude/support directory
- **Still Accessible**: Files remain accessible when explicitly referenced
- **Path Consistency**: All support files use consistent .claude/support prefix
- **Future Expansion**: Room for additional support files as needed

## Considerations

### Pros:
- Cleaner repository appearance
- Better organization of operational vs template files
- Consistent location for all support data
- Professional template presentation

### Cons:
- Breaking change - requires path updates in multiple files
- Users with existing setups need migration
- Slightly deeper paths for accessing support files
- Need to update all documentation and scripts

## Migration Strategy

### For Existing Users:
1. **Automatic Migration**: Update setup script to detect old locations and migrate
2. **Backward Compatibility**: Check both old and new locations temporarily
3. **Clear Documentation**: Provide migration instructions in README
4. **Version Bump**: Increment version to indicate breaking change

### Migration Script Example:
```bash
# Add to setup-claude-memory.sh
if [ -d ".mcp" ]; then
    echo "Migrating .mcp to .claude/support/mcp..."
    mkdir -p .claude/support/mcp
    cp -r .mcp/* .claude/support/mcp/
    rm -rf .mcp
    echo "Migration complete!"
fi
```

## Success Criteria
- [ ] All support files moved to .claude/support directory
- [ ] MCP configuration updated with new paths
- [ ] Setup script updated for new location
- [ ] .gitignore updated for new paths
- [ ] Documentation updated to reflect new structure
- [ ] Migration path provided for existing users
- [ ] Repository root is clean and focused on template content
- [ ] All functionality continues to work with new paths

## Impact Assessment
- **Template Users**: Cleaner, more professional appearance
- **Repository Maintenance**: Better organization and easier management  
- **Claude Code Operation**: No functional impact, purely organizational
- **Version Impact**: Patch increment - organizational change, no feature changes

## Notes
The `.claude/support/` directory serves as a designated area for operational files that support Claude Code functionality but aren't part of the core template. This follows the principle of keeping template content separate from operational overhead.