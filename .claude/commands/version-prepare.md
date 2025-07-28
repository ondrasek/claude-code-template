# Prepare Version Release

Analyze completed TODOs and prepare for version release with automatic CHANGELOG generation.

## Usage
```
/version-prepare [version-type]
```

## Version Types
- `auto`: Automatically detect version bump based on completed TODO types
- `major`: Force major version bump (x.0.0)
- `minor`: Force minor version bump (0.x.0)  
- `patch`: Force patch version bump (0.0.x)

## Example
```
/version-prepare auto
```

---

I'll help you prepare a version release by analyzing completed TODOs and generating the appropriate CHANGELOG entries.

## Process

1. **Analyze completed TODOs** using parallel agent coordination:
   - **todo**: Primary TODO analysis and version calculation coordination
   - **completer + patterns**: Comprehensive completion analysis and implementation validation
   - **researcher + time**: Historical version pattern analysis and semantic versioning research
   - **docs + git-tagger**: Release documentation and git tag preparation coordination
2. **Calculate version bump** based on semantic versioning analysis:
   - Any `break` tasks → MAJOR version
   - Any `feat` tasks (no breaks) → MINOR version
   - Only `fix`/`docs`/`perf`/`refactor`/`test`/`chore` → PATCH version
3. **Generate CHANGELOG entries** from completed tasks
4. **Update version number** in relevant files
5. **Prepare release commit** with proper formatting

## Automatic Version Detection

The system scans completed TODOs since the last release:

```
MAJOR (x.0.0): Any `break` type tasks found
MINOR (0.x.0): Any `feat` type tasks found (if no MAJOR)
PATCH (0.0.x): Only maintenance tasks found
```

## CHANGELOG Generation

Completed TODOs are converted to CHANGELOG entries:

### Task Type → CHANGELOG Section Mapping
- `feat` → "### Added"
- `fix` → "### Fixed"
- `break` (removing features) → "### Removed"
- `break` (changing behavior) → "### Changed"
- `docs` → "### Changed" (if user-facing)
- `perf` → "### Changed"
- `refactor` → Usually excluded from user-facing changelog
- `test`, `chore` → Usually excluded

### Entry Format
```markdown
## [1.2.3] - 2024-01-28

### Added
- New feature description from feat TODO
  - Additional implementation details
  - TODO reference: #task-1

### Fixed  
- Bug fix description from fix TODO
  - TODO reference: #task-3
```

## Release Preparation Steps

1. **Version Calculation**: Determine new version number
2. **CHANGELOG Update**: Generate entries from completed TODOs
3. **Archive Cleanup**: Move completed TODOs from archive to CHANGELOG
4. **Version Commit**: Create commit with version bump
5. **Tag Preparation**: Prepare annotated git tag command

## Files Updated

- `CHANGELOG.md`: Add new version section with entries
- `TODO.md`: Clear completed tasks from archive section
- Any version files (package.json, etc.) if present

## Integration with Git Workflow

Following trunk-based development:
1. All changes committed to main branch
2. Version tag created: `git tag -a v1.2.3 -m "Release version 1.2.3"`
3. Push to origin: `git push origin main && git push origin v1.2.3`

## Memory Integration

**Before Version Preparation**: Use `mcp__memory__search_nodes()` to check for:
- Previous version release patterns and semantic versioning decisions
- Historical TODO completion rates and release scope patterns
- Successful release documentation strategies and CHANGELOG effectiveness
- Version bump decision criteria and their long-term impact

**After Version Preparation**: Store findings with `mcp__memory__create_entities()` and `mcp__memory__create_relations()`:
- Version release effectiveness and semantic versioning accuracy
- TODO completion pattern evolution and release planning optimization
- Release documentation quality and user engagement metrics
- Cross-release relationship patterns and version strategy evolution

## Agent Integration

**Primary Coordination**: todo agent orchestrates version preparation with systematic TODO analysis

**Supporting Clusters**:
- **Completion Analysis**: completer + patterns for comprehensive implementation validation
- **Historical Analysis**: researcher + time for version pattern analysis
- **Documentation**: docs + git-tagger for release preparation and tag coordination
- **Quality Validation**: critic + testing for release readiness assessment

This command ensures systematic version management with complete traceability from TODO tasks to release documentation, enhanced by memory-informed decision making and parallel agent coordination.

## Related Commands

- `/todo-cleanup-done` - Clean completed TODOs before version preparation
- `/doc-update` - Ensure documentation synchronization with release
- `/agent-ecosystem-review` - Analyze version management process effectiveness