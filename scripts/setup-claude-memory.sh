#!/bin/bash
# Claude Code Memory Setup Script
# Sets up persistent memory and SQLite storage for Claude Code MCP servers

echo "Setting up Claude Code persistent memory storage..."

# Create .mcp directory for memory/sqlite storage
mkdir -p .mcp

# Set appropriate permissions
chmod -R 755 .mcp/

# Create info file explaining Claude Code memory persistence
cat > .mcp/README.md << 'EOF'
# Claude Code Memory Storage

This directory contains persistent storage for Claude Code MCP (Model Context Protocol) servers.

## Purpose:
Enables Claude Code to maintain memory and data across sessions using:
- **Memory Server**: Persistent conversations, entities, relationships
- **SQLite Server**: Structured data storage and queries

## Files:
- `memory.db` - MCP memory server database (conversations, entities, relationships)
- `project.db` - SQLite database for structured data storage and queries
- `*.db-wal`, `*.db-shm` - SQLite Write-Ahead Log and Shared Memory files

## Privacy & Storage:
- **Git Exclusion**: Memory files are excluded from version control by default
- **Local Storage**: Each environment maintains its own memory state
- **Cross-Session**: Memory persists between Claude Code sessions
- **Environment Portable**: Works in local dev, codespaces, containers

## To Enable Git Persistence:
If you want to commit memory data to share with team members, comment out these lines in .gitignore:
```
# .mcp/memory.db
# .mcp/project.db
# .mcp/*.db-wal
# .mcp/*.db-shm
```

**Warning**: Memory databases may contain sensitive conversation data.
EOF

echo "✅ Claude Code memory setup complete!"
echo "💾 Memory and SQLite data will persist in .mcp/ directory"
echo "🔒 Database files are excluded from git by default for privacy"