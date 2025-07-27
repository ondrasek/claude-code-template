# TODO Items

## High Priority

### 1. SemVer is being ignored and tags are not created, FIX IT
- **Issue**: The versioning instructions in `.claude/instructions/versioning.md` specify semantic versioning with git tags, but this is not being followed
- **Impact**: No proper version tracking, releases are not tagged
- **Solution**: 
  - Review and fix the versioning process
  - Ensure tags are created for releases
  - Follow semantic versioning properly
- **Status**: Open
- **Priority**: High

### 2. Add command to add TODOs to a specific file, such as TODO.md. Modify completer to also check this file for TODOs
- **Issue**: Currently no standardized way to manage TODOs across the repository
- **Impact**: TODOs may be scattered in code comments without central tracking
- **Solution**:
  - Create a slash command (e.g., `/todo`) to add items to TODO.md
  - Update the completer agent to scan TODO.md in addition to code comments
  - Integrate TODO management into the workflow
- **Status**: Open
- **Priority**: High

## Notes
- TODOs should be tracked both in code comments and in this centralized file
- The completer agent should provide comprehensive TODO scanning across all sources
- Version management needs immediate attention for proper release tracking