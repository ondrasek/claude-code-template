# TODO and CHANGELOG Management System

This document defines the automated TODO and CHANGELOG management system for Claude Code projects.

## 1. Standardized TODO Entry Format

### TODO Entry Structure
```yaml
---
id: unique-todo-identifier
title: Brief description of the task
type: feature|bug|improvement|refactor|docs|test|security|performance
impact: major|minor|patch
status: pending|in_progress|completed|blocked|cancelled
priority: critical|high|medium|low
created: YYYY-MM-DD
updated: YYYY-MM-DD
assignee: agent-name|human
estimate: hours|days
dependencies: [list-of-todo-ids]
labels: [list-of-labels]
files: [list-of-affected-files]
---

## Description
Detailed description of what needs to be done.

### Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

### Implementation Notes
Technical details and considerations.

### Breaking Changes
List any breaking changes this TODO will introduce.
```

### SemVer Impact Classification

**MAJOR (Breaking Changes)**
- `type: feature` with `impact: major`
- Removing public APIs
- Changing configuration file formats
- Removing commands or agents
- Changing behavior that breaks existing workflows

**MINOR (New Features)**
- `type: feature` with `impact: minor`
- Adding new agents
- Adding new commands
- Adding new optional features
- Deprecating functionality (but not removing)

**PATCH (Fixes and Improvements)**
- `type: bug|improvement|refactor|docs|test|security|performance`
- Bug fixes
- Documentation updates
- Performance improvements
- Security patches
- Refactoring without API changes

## 2. Progress Tracking System

### Status Transitions
```
pending → in_progress → completed
        ↓             ↓
      blocked    → cancelled
```

### Tracking Rules
1. **Status Updates**: Must be updated when work begins/ends
2. **Dependencies**: Blocked TODOs cannot start until dependencies complete
3. **Time Tracking**: Update `updated` field on status changes
4. **Documentation**: Major changes require documentation updates

### Progress Commands
```bash
# Mark TODO as in progress
claude-todo start <todo-id>

# Mark TODO as completed
claude-todo complete <todo-id>

# Block TODO with reason
claude-todo block <todo-id> --reason "waiting for upstream fix"

# List TODOs by status
claude-todo list --status pending
claude-todo list --status in_progress
claude-todo list --assignee researcher
```

## 3. CHANGELOG Generation Algorithm

### Automatic CHANGELOG Update Process
```python
def generate_changelog_entry(completed_todos):
    """Generate CHANGELOG entry from completed TODOs"""
    
    # Group by SemVer impact
    major_changes = filter_by_impact(completed_todos, 'major')
    minor_changes = filter_by_impact(completed_todos, 'minor') 
    patch_changes = filter_by_impact(completed_todos, 'patch')
    
    # Determine version bump
    if major_changes:
        version_type = 'major'
    elif minor_changes:
        version_type = 'minor'
    else:
        version_type = 'patch'
    
    # Generate sections
    sections = {
        'Added': filter_by_type(completed_todos, ['feature']),
        'Changed': filter_by_type(completed_todos, ['improvement', 'refactor']),
        'Fixed': filter_by_type(completed_todos, ['bug', 'security']),
        'Removed': filter_by_breaking_change(completed_todos),
        'Security': filter_by_type(completed_todos, ['security']),
        'Performance': filter_by_type(completed_todos, ['performance'])
    }
    
    return format_changelog_entry(version_type, sections)
```

### CHANGELOG Entry Template
```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added
- New feature descriptions with TODO references
  - Implements TODO-123: Add caching layer for user data
  - Resolves TODO-456: Create automated backup system

### Changed
- Modified behavior descriptions
  - TODO-789: Improve error handling in API endpoints
  - TODO-012: Refactor authentication middleware

### Fixed
- Bug fix descriptions
  - Fixes TODO-345: Memory leak in data processing pipeline
  - Resolves TODO-678: Race condition in concurrent requests

### Removed
- Removed feature descriptions (BREAKING CHANGES)
  - TODO-901: Remove deprecated v1 API endpoints
  - TODO-234: Drop support for Node.js < 16

### Security
- Security improvement descriptions
  - TODO-567: Implement rate limiting for login attempts
  - TODO-890: Add input sanitization for user content

### Performance
- Performance improvement descriptions
  - TODO-123: Optimize database queries in user service
  - TODO-456: Implement connection pooling
```

## 4. Version Bump Logic

```python
def calculate_version_bump(current_version, completed_todos):
    """Calculate next version based on completed TODOs"""
    
    major, minor, patch = parse_version(current_version)
    
    # Check for major version bump
    has_major_changes = any(
        todo.impact == 'major' or has_breaking_changes(todo)
        for todo in completed_todos
    )
    
    if has_major_changes:
        return f"{major + 1}.0.0"
    
    # Check for minor version bump
    has_minor_changes = any(
        todo.type == 'feature' and todo.impact == 'minor'
        for todo in completed_todos
    )
    
    if has_minor_changes:
        return f"{major}.{minor + 1}.0"
    
    # Default to patch version bump
    return f"{major}.{minor}.{patch + 1}"

def has_breaking_changes(todo):
    """Check if TODO introduces breaking changes"""
    breaking_indicators = [
        'remove', 'delete', 'drop support',
        'change behavior', 'incompatible',
        'breaking change', 'migration required'
    ]
    
    content = f"{todo.title} {todo.description}".lower()
    return any(indicator in content for indicator in breaking_indicators)
```

## 5. File Management Operations

### TODO.md Structure
```markdown
# Project TODOs

## Statistics
- Total TODOs: 25
- Pending: 15
- In Progress: 5
- Completed (this version): 8
- Blocked: 2

## Quick Actions
- [Add New TODO](#add-new-todo)
- [Start Work](#start-work)
- [Complete TODO](#complete-todo)

## TODOs by Status

### 🚀 In Progress
[TODO-001]: Update authentication system (researcher, high priority)
[TODO-005]: Add caching layer (completer, medium priority)

### ⏳ Pending
[TODO-002]: Implement rate limiting (security, high priority)
[TODO-003]: Add integration tests (testing, medium priority)

### ⛔ Blocked
[TODO-007]: Migrate to new API (blocked by upstream, high priority)

### ✅ Completed (Current Version)
[TODO-004]: Fix memory leak in data processor (completed 2024-01-15)
[TODO-006]: Update documentation (completed 2024-01-16)

---

<!-- Detailed TODO entries follow -->
```

### File Edit Operations

```python
class TODOManager:
    def add_todo(self, todo_data):
        """Add new TODO entry to TODO.md"""
        todo_entry = self.format_todo_entry(todo_data)
        
        # Find insertion point in pending section
        content = self.read_file('TODO.md')
        insertion_point = self.find_section_end('### ⏳ Pending')
        
        # Insert new TODO
        new_content = self.insert_at_position(
            content, insertion_point, todo_entry
        )
        
        # Update statistics
        new_content = self.update_statistics(new_content)
        
        self.write_file('TODO.md', new_content)
    
    def update_todo_status(self, todo_id, new_status):
        """Move TODO between status sections"""
        content = self.read_file('TODO.md')
        
        # Extract TODO entry
        todo_entry = self.extract_todo_entry(content, todo_id)
        
        # Remove from current section
        content = self.remove_todo_entry(content, todo_id)
        
        # Update status in entry
        todo_entry = self.update_entry_status(todo_entry, new_status)
        
        # Add to new section
        target_section = self.get_status_section(new_status)
        content = self.add_to_section(content, target_section, todo_entry)
        
        # Update statistics and timestamps
        content = self.update_statistics(content)
        
        self.write_file('TODO.md', content)
    
    def generate_changelog_update(self, completed_todos):
        """Update CHANGELOG.md with completed TODOs"""
        changelog = self.read_file('CHANGELOG.md')
        
        # Calculate version bump
        current_version = self.extract_current_version(changelog)
        new_version = self.calculate_version_bump(current_version, completed_todos)
        
        # Generate new entry
        new_entry = self.format_changelog_entry(new_version, completed_todos)
        
        # Insert after [Unreleased] section
        insertion_point = self.find_unreleased_section_end(changelog)
        updated_changelog = self.insert_at_position(
            changelog, insertion_point, new_entry
        )
        
        # Update [Unreleased] section with remaining TODOs
        updated_changelog = self.update_unreleased_section(updated_changelog)
        
        self.write_file('CHANGELOG.md', updated_changelog)
        
        return new_version
```

### Automated Workflow Commands

```bash
#!/bin/bash
# claude-todo-complete: Complete a TODO and update CHANGELOG

TODO_ID=$1
if [ -z "$TODO_ID" ]; then
    echo "Usage: claude-todo-complete <todo-id>"
    exit 1
fi

# Mark TODO as completed
claude-todo complete $TODO_ID

# Check if we have enough completed TODOs for a release
COMPLETED_COUNT=$(claude-todo list --status completed --count)

if [ $COMPLETED_COUNT -ge 5 ]; then
    echo "Ready for release with $COMPLETED_COUNT completed TODOs"
    echo "Run 'claude-release' to generate CHANGELOG and create version tag"
fi
```

```bash
#!/bin/bash
# claude-release: Generate release from completed TODOs

# Get completed TODOs
COMPLETED_TODOS=$(claude-todo list --status completed --format json)

# Generate CHANGELOG entry
NEW_VERSION=$(claude-changelog generate "$COMPLETED_TODOS")

# Archive completed TODOs
claude-todo archive --status completed

# Create git tag
git add CHANGELOG.md TODO.md
git commit -m "Release version $NEW_VERSION

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>"

git tag -a "v$NEW_VERSION" -m "Release version $NEW_VERSION"
git push origin main
git push origin "v$NEW_VERSION"

echo "Released version $NEW_VERSION"
```

## 6. Integration with Claude Code

### Agent Integration
- **completer**: Automatically scan for missing TODOs
- **patterns**: Identify TODO patterns and suggest improvements
- **docs**: Update documentation when TODOs are completed
- **researcher**: Research best practices for TODO implementation

### Command Integration
```markdown
# .claude/commands/todo.md
Add new TODO item with proper SemVer classification and priority assignment.

Usage: /todo <description>

This command will:
1. Create properly formatted TODO entry
2. Classify SemVer impact automatically
3. Assign to appropriate agent
4. Update TODO.md file
5. Link to related issues/PRs
```

### MCP Tool Integration
```json
{
  "mcpServers": {
    "todo-manager": {
      "command": "npx",
      "args": ["@claude-code/todo-manager"],
      "env": {
        "TODO_FILE": "./TODO.md",
        "CHANGELOG_FILE": "./CHANGELOG.md"
      }
    }
  }
}
```

This system provides comprehensive automation for TODO and CHANGELOG management while maintaining Claude Code's principles of automation, consistency, and semantic versioning.