# Versioning Guidelines

This project follows **Semantic Versioning (SemVer)**.

## Version Number Format
`MAJOR.MINOR.PATCH`

## When to Increment

### MAJOR (breaking changes)
- Removing features
- Changing configurations incompatibly  
- Breaking API changes
- Removing deprecated functionality

### MINOR (new features)
- Adding agents
- Adding commands
- New capabilities
- New optional features
- Deprecating functionality (but not removing)

### PATCH (fixes)
- Bug fixes
- Typos
- Small improvements
- Documentation updates
- Performance improvements

## Versioning Process

Always:
1. Update version in CHANGELOG.md
2. Create git tag: `git tag -a v1.2.3 -m "Release version 1.2.3"`
3. Push tag: `git push origin v1.2.3`

## CHANGELOG Format

```markdown
## [1.2.3] - 2024-01-20

### Added
- New feature descriptions

### Changed
- Modified behavior descriptions

### Fixed
- Bug fix descriptions

### Removed
- Removed feature descriptions
```

## Pre-release Versions
- Alpha: `1.0.0-alpha.1`
- Beta: `1.0.0-beta.1`
- Release Candidate: `1.0.0-rc.1`