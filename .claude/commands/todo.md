# TODO Management Command

Add, track, and manage TODOs with automatic SemVer impact classification and CHANGELOG integration.

## Usage
```
/todo <description> [--type <type>] [--impact <impact>] [--priority <priority>] [--assignee <agent>]
```

## Parameters
- `description`: Brief description of the TODO item
- `--type`: feature|bug|improvement|refactor|docs|test|security|performance (required)
- `--impact`: major|minor|patch (required for SemVer classification)
- `--priority`: critical|high|medium|low (default: medium)
- `--assignee`: Agent or person responsible (e.g., researcher, completer, human)

## Examples
```
/todo "Add caching layer for user data" --type feature --impact minor --priority high --assignee completer
/todo "Fix memory leak in data processor" --type bug --impact patch --priority critical --assignee researcher
/todo "Update API documentation" --type docs --impact patch --priority medium --assignee docs
```

## SemVer Impact Guidelines

### Major (Breaking Changes)
- Removing public APIs or features
- Changing configuration file formats
- Modifying behavior that breaks existing workflows
- Dropping support for versions/platforms

### Minor (New Features)
- Adding new agents or commands
- Adding new optional features
- Deprecating functionality (but not removing)
- Adding backward-compatible API changes

### Patch (Fixes & Improvements)
- Bug fixes and security patches
- Documentation updates
- Performance improvements
- Refactoring without API changes

## Workflow Integration

This command will:
1. Generate unique TODO ID (TODO-XXX format)
2. Create properly formatted TODO entry in TODO.md
3. Assign to appropriate agent based on type
4. Update TODO statistics and status sections
5. Link to related files and dependencies
6. Enable automatic CHANGELOG generation upon completion

## Agent Assignment Suggestions
- **feature**: `completer` (finds missing functionality)
- **bug**: `researcher` (investigates issues)
- **security**: `researcher` + `patterns` (security analysis)
- **docs**: `docs` (documentation updates)
- **refactor**: `patterns` + `principles` (code improvement)
- **performance**: `researcher` + `patterns` (optimization)
- **test**: `completer` (test coverage gaps)

## TODO Entry Format

Each TODO includes structured YAML metadata:
```yaml
---
id: TODO-001
title: Add caching layer for user data
type: feature
impact: minor
status: pending
priority: high
created: 2025-01-28
updated: 2025-01-28
assignee: completer
estimate: 2 days
dependencies: []
labels: [performance, database]
files: [src/cache.py, src/models.py]
---

## Description
Implement Redis-based caching layer to improve API response times for frequently accessed user data.

### Acceptance Criteria
- [ ] Cache implements TTL-based expiration
- [ ] Cache invalidation on user data updates
- [ ] Performance improvement > 50% for user queries
- [ ] Graceful fallback to database on cache miss

### Implementation Notes
Use Redis with connection pooling. Consider cache warming strategies for critical user data.

### Breaking Changes
None - this is an additive feature with backward compatibility.
```

## Status Management
After creating TODOs, use these companion commands:
- `/todo-start <TODO-ID>` - Mark as in progress
- `/todo-complete <TODO-ID>` - Mark as completed  
- `/todo-block <TODO-ID> --reason "explanation"` - Mark as blocked
- `/todo-list [--status <status>] [--assignee <agent>]` - List TODOs

## Release Integration
When enough TODOs are completed:
- `/todo-release` - Generate CHANGELOG entry and version bump
- Automatically calculates SemVer increment based on TODO impacts
- Archives completed TODOs and creates git tag

## Integration
This command integrates with:
- **Python script**: `scripts/todo-manager.py` for backend processing
- **completer agent**: Automatically scans for missing TODOs
- **docs agent**: Updates documentation when TODOs are resolved
- **researcher agent**: Investigates bug reports and feature requirements
- **patterns + principles agents**: Guide refactoring and improvement TODOs
- **CHANGELOG.md**: Automatic generation from completed TODOs
- **Git workflow**: Semantic versioning and release tagging

## Advanced Features
- **Dependency tracking**: Link TODOs that depend on others
- **File associations**: Track which files are affected by each TODO
- **Label system**: Categorize TODOs with custom labels
- **Time estimation**: Add effort estimates for planning
- **Automatic assignment**: Suggest agents based on TODO type
- **Progress tracking**: Visual status indicators and statistics
- **Batch operations**: Process multiple TODOs efficiently

## Notes
- TODOs should be actionable and specific with clear acceptance criteria
- Use SemVer impact classification to prepare for releases
- Link to relevant issues, PRs, or documentation when applicable
- Break large TODOs into smaller, manageable tasks with dependencies
- Leverage agent assignments to distribute work effectively