# MCP Storage Directory

This directory contains MCP (Model Context Protocol) server data that persists across GitHub Codespace rebuilds.

## Files:
- `memory.db` - MCP memory server database (conversations, entities, relationships)
- `project.db` - SQLite database for structured data storage
- `*.db-wal`, `*.db-shm` - SQLite Write-Ahead Log and Shared Memory files

## Persistence Strategy:
- Stored in workspace directory to survive codespace rebuilds
- Excluded from git by default for privacy (see .gitignore)
- To enable git persistence, comment out exclusions in .gitignore

## Privacy Note:
Memory databases may contain sensitive conversation data. 
Consider the privacy implications before committing to version control.
