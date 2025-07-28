---
status: completed
type: enhancement
priority: high
assignee: patterns
created: 2025-07-28
completed: 2025-07-28
impact: minor
environment: codespaces
---

# Implement Codespace-Persistent MCP Memory Storage

## Problem Statement
GitHub Codespaces are ephemeral environments where MCP memory server data (SQLite databases) are lost when:
- Codespace is destroyed and recreated
- Codespace is rebuilt from devcontainer
- Files outside `/workspaces/<repo>/` directory are not persisted

Current `.gitignore` excludes `*.db` files, so memory is lost across codespace lifecycles.

## Proposed Solution

### Option 1: Workspace-Relative Storage (Recommended)
Store MCP memory databases within the repository workspace to ensure persistence across rebuilds:

```json
// .mcp.json
{
  "mcpServers": {
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"],
      "env": {
        "MEMORY_DB_PATH": "/workspaces/claude-code-template/.mcp/memory.db"
      }
    },
    "sqlite": {
      "command": "npx", 
      "args": ["-y", "@modelcontextprotocol/server-sqlite", "--db-path", "/workspaces/claude-code-template/.mcp/project.db"]
    }
  }
}
```

### Option 2: Git-Based Memory Persistence
Create separate branch for memory data:

```bash
# Initialize memory branch
git checkout -b mcp-memory --orphan
git rm -rf .
echo "# MCP Memory Storage Branch" > README.md
mkdir memory
git add .
git commit -m "Initialize MCP memory branch"
git checkout main

# Auto-sync script
#!/bin/bash
# .mcp/sync-memory.sh
git checkout mcp-memory
cp /workspaces/claude-code-template/.mcp/*.db ./memory/
git add memory/
git commit -m "Sync memory: $(date)" || true
git checkout main
```

### Option 3: External Storage Integration
Configure MCP servers to use external persistent storage:

```json
// .mcp.json with external storage
{
  "mcpServers": {
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"],
      "env": {
        "STORAGE_TYPE": "external",
        "DATABASE_URL": "${EXTERNAL_DB_URL}"
      }
    }
  }
}
```

## Implementation Plan

1. **Update .mcp.json** with workspace-relative database paths
2. **Create .mcp/ directory** structure in repository root
3. **Update .gitignore** to allow `.mcp/*.db` files (override global exclusion)
4. **Add devcontainer setup** to initialize MCP directories
5. **Document persistence strategy** in README.md
6. **Add optional external sync** for advanced users

## Considerations

**Pros:**
- Memory persists across codespace rebuilds
- No external dependencies required
- Works offline
- Simple to implement

**Cons:**
- Memory files tracked in git (can become large)
- Sensitive conversation data in repository
- Team members share memory state
- Potential merge conflicts with concurrent usage

## Alternative: Privacy-First Approach

Store memory in workspace but exclude from git, document setup process:

```gitignore
# .gitignore - Modified approach
# MCP Memory Server Data (local only, document setup)
# Remove these lines to enable persistence:
# .mcp/memory.db
# .mcp/project.db
# .mcp/*.db-wal
# .mcp/*.db-shm
```

Include setup instructions for users who want persistence vs privacy.

## Implementation Completed

### Changes Made:
1. **Updated .mcp.json** - Database paths now use relative paths `.mcp/` (works in any environment)
2. **Modified .gitignore** - MCP databases in `.mcp/` directory are excluded by default (privacy-first)  
3. **Created setup script** - `scripts/setup-claude-memory.sh` specifically for Claude Code memory setup
4. **Documentation** - Added README in `.mcp/` explaining Claude Code memory persistence

### Fixed Issues:
- **Removed hardcoded paths** - Changed from `/workspaces/claude-code-template/.mcp/` to `.mcp/`
- **Universal compatibility** - Now works in local development, codespaces, containers, any environment
- **Removed devcontainer** - This is a template repo, not a devcontainer project
- **Focused script** - Renamed to `setup-claude-memory.sh` and moved to `scripts/` directory
- **Clear purpose** - Script specifically sets up memory/SQLite for Claude Code, not generic MCP

### Success Criteria
- [x] MCP memory survives codespace rebuilds
- [x] No breaking changes to existing functionality  
- [x] Clear documentation of privacy implications
- [x] Optional external storage configuration (via environment variables)
- [x] Graceful handling of missing memory data (MCP servers handle this)