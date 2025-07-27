# Versioning Guidelines

This project follows **Semantic Versioning 2.0.0** (SemVer).

## Version Format

`MAJOR.MINOR.PATCH`

- **MAJOR**: Incompatible API changes or breaking changes
- **MINOR**: Backwards-compatible functionality additions
- **PATCH**: Backwards-compatible bug fixes

## When to Increment

### MAJOR (X.0.0)
Increment when making incompatible changes:
- Removing or renaming existing commands
- Changing agent interfaces or core behaviors
- Modifying configuration file structures in breaking ways
- Removing features without deprecation period
- Changes requiring manual migration steps

### MINOR (0.X.0)
Increment when adding functionality in a backwards-compatible manner:
- Adding new commands
- Adding new agents
- Adding new technology stacks
- Adding new MCP server configurations
- Adding new features to existing components
- Deprecating features (but not removing them)

### PATCH (0.0.X)
Increment for backwards-compatible bug fixes:
- Fixing typos in documentation
- Correcting agent behaviors without changing interfaces
- Fixing broken commands
- Updating dependencies for security patches
- Small improvements that don't add new features

## Version Tags

Use Git tags for releases:
```bash
git tag -a v1.2.3 -m "Release version 1.2.3"
git push origin v1.2.3
```

## Pre-release Versions

For pre-releases, use:
- Alpha: `1.0.0-alpha.1`
- Beta: `1.0.0-beta.1`
- Release Candidate: `1.0.0-rc.1`

## Changelog

Always update CHANGELOG.md when changing versions:
1. Add new version section with date
2. List changes under Added/Changed/Deprecated/Removed/Fixed/Security
3. Follow [Keep a Changelog](https://keepachangelog.com) format

## Examples

### Example: Adding a new agent
- Current version: 1.2.3
- New version: 1.3.0 (MINOR increment)
- Reason: New functionality, backwards-compatible

### Example: Changing MCP configuration format
- Current version: 1.3.0
- New version: 2.0.0 (MAJOR increment)
- Reason: Breaking change requiring user action

### Example: Fixing a typo in README
- Current version: 2.0.0
- New version: 2.0.1 (PATCH increment)
- Reason: Documentation fix, no functional change

## Automation

Consider using tools like:
- `npm version` for JavaScript projects
- `bumpversion` for Python projects
- GitHub Actions for automated releases

## Version Badge

Add a version badge to README.md:
```markdown
[![Version](https://img.shields.io/github/v/release/username/repo)](https://github.com/username/repo/releases)
```