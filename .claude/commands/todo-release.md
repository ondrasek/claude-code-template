# TODO Release Command

Generate CHANGELOG entry and create version release from completed TODOs.

## Usage
```
/todo-release [--dry-run] [--version <version>]
```

## Parameters
- `--dry-run`: Show what would be done without making changes
- `--version`: Override automatic version calculation (optional)

## Examples
```
/todo-release --dry-run
/todo-release
/todo-release --version 2.0.0
```

## Functionality

This command will:

1. **Collect Completed TODOs**: Gather all TODOs with status "completed"
2. **Calculate Version Bump**: Determine MAJOR.MINOR.PATCH increment based on TODO impacts
3. **Generate CHANGELOG Entry**: Create formatted changelog section with categorized changes
4. **Update Files**: Modify CHANGELOG.md and archive completed TODOs
5. **Create Git Tag**: Tag the release and push to origin

## Version Calculation Logic

The algorithm analyzes completed TODOs:
- **MAJOR bump**: Any TODO with `impact: major` or breaking changes
- **MINOR bump**: Any TODO with `type: feature` and `impact: minor`
- **PATCH bump**: All other completed TODOs (bugs, improvements, docs, etc.)

Highest impact level determines the version increment.

## CHANGELOG Generation

TODOs are categorized into CHANGELOG sections:
- **Added**: `type: feature` TODOs
- **Changed**: `type: improvement` and `type: refactor` TODOs
- **Fixed**: `type: bug` TODOs
- **Security**: `type: security` TODOs
- **Performance**: `type: performance` TODOs
- **Documentation**: `type: docs` TODOs
- **Removed**: TODOs with breaking changes

Each entry includes:
- TODO title as the change description
- TODO ID reference for traceability
- Breaking change warnings where applicable

## Example Output

```markdown
## [1.3.0] - 2025-01-28

### Added
- Add caching layer for user data
  - Implements TODO-001: Redis-based caching with TTL expiration
- Implement rate limiting for API endpoints
  - Resolves TODO-005: Prevent API abuse with configurable limits

### Fixed
- Fix memory leak in data processor
  - Fixes TODO-003: Resolved circular reference in data structures
- Correct authentication timeout handling
  - Resolves TODO-007: Improved session management

### Security
- Add input sanitization for user content
  - TODO-009: Prevent XSS attacks in user-generated content

### Performance
- Optimize database queries in user service
  - TODO-011: Reduced query time by 60% using indexing
```

## Git Integration

After updating files, the command:
1. Stages CHANGELOG.md and TODO.md changes
2. Creates commit with message: "Release version X.Y.Z"
3. Creates annotated git tag: `vX.Y.Z`
4. Pushes changes and tag to origin

## Integration

Works with:
- **TODO management system**: Processes completed TODOs
- **SemVer versioning**: Follows semantic versioning rules
- **Git workflow**: Creates proper release commits and tags
- **CHANGELOG format**: Maintains Keep a Changelog standard

## Safety Features

- **Dry-run mode**: Preview changes before execution
- **Validation**: Ensures at least one completed TODO exists
- **Backup**: Preserves original files during processing
- **Rollback**: Can revert changes if process fails

## Notes

- Requires at least one completed TODO to generate a release
- Archive completed TODOs to prevent re-processing
- Use semantic version overrides for special releases (e.g., major architecture changes)
- Integrates with Claude Code's trunk-based development workflow