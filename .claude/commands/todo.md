# Simple TODO Management Commands

Lightweight TODO management using Claude Code built-in tools and individual markdown files.

## Usage

### Add a new TODO
```
/todo-add "Fix authentication bug" --type bug --priority high --assignee researcher
```

### List TODOs  
```
/todo-list
/todo-list --status pending
/todo-list --assignee completer
```

### Complete a TODO
```
/todo-complete "authentication-bug"
```

### View TODO details
```
/todo-show "authentication-bug"
```

## Simple Architecture

**No complex scripts** - uses only Claude Code built-in tools:
- **Glob tool** to find TODO files
- **Read tool** to view TODO content  
- **Write tool** to create/update TODOs
- **Edit tool** to modify TODO status

**File Structure**: Individual TODO files are stored in the .support/todos/ directory as markdown files with kebab-case names.

## TODO File Format

Each TODO is a simple markdown file with YAML frontmatter:

```yaml
---
status: pending
type: bug  
priority: high
assignee: researcher
created: 2025-01-28
impact: patch
---

# Fix Authentication Bug

## Description
Users are getting logged out randomly after 5 minutes instead of the configured 30-minute session timeout.

## Context
- Happening since v1.4.0 deployment
- Affects both web and mobile clients
- JWT tokens seem to expire early

## Acceptance Criteria
- [ ] Session timeout works correctly (30 minutes)
- [ ] No random logouts occur
- [ ] Fix is backward compatible

## Notes
Check JWT expiration settings and Redis session storage.
```

## Commands Implementation

### `/todo-add` Command
```markdown
Use built-in tools to:
1. Create filename from title (kebab-case)
2. Generate YAML frontmatter with metadata
3. Write file to .support/todos/ directory
4. Update main TODO.md index if needed
```

### `/todo-list` Command  
```markdown
Use Glob tool to:
1. Find all .support/todos/*.md files
2. Read frontmatter for filtering
3. Display filtered results with status
```

### `/todo-complete` Command
```markdown
Use Edit tool to:
1. Change status: pending → completed
2. Add completion date
3. Move completed entry to CHANGELOG.md
4. Archive if needed
```

## Integration with Existing Agents

**completer agent**: 
- Scans .support/todos/ directory for incomplete TODOs
- Creates new TODO files for discovered gaps
- Updates TODO status after completing work

**docs agent**:
- Updates documentation when TODOs are completed
- Creates TODO files for documentation improvements

**researcher agent**:
- Investigates bug TODOs and adds findings
- Creates TODO files for discovered issues

## Benefits of Simple Approach

1. **No external dependencies** - uses only Claude Code tools
2. **Easy to browse** - individual files are human-readable
3. **Version control friendly** - each TODO is a separate file
4. **Flexible** - can be extended without complex scripts
5. **Maintainable** - no Python scripts to debug or maintain

## Quick Start

```bash
# Create your first TODO
/todo-add "Improve error handling" --type improvement --priority medium

# List all TODOs  
/todo-list

# Complete a TODO
/todo-complete "improve-error-handling"
```

## Migration from Complex System

If you have existing TODOs in other formats:
1. Create individual files in .support/todos/ directory
2. Convert to simple YAML + markdown format  
3. Remove complex scripts and dependencies
4. Use Claude Code built-in tools for management

This approach prioritizes simplicity and maintainability over feature richness.