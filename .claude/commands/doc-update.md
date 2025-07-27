# Documentation Update Command

Help me update documentation to reflect recent code changes.

## What This Command Does

Analyzes recent changes and updates all relevant documentation to keep it synchronized with the code. This includes:

- README.md for features and usage
- CHANGELOG.md for version history
- API documentation for interface changes
- Configuration docs for settings changes
- Code examples and tutorials

## When to Use This Command

Run this command:
- After implementing a new feature
- After changing APIs or interfaces
- After modifying configuration options
- Before committing significant changes
- When documentation feels out of sync

## Documentation Checklist

The command will check and update:

### README.md
- [ ] Features list
- [ ] Installation instructions
- [ ] Usage examples
- [ ] Configuration options
- [ ] Dependencies

### CHANGELOG.md
- [ ] Version entries
- [ ] Breaking changes
- [ ] New features
- [ ] Bug fixes
- [ ] Migration guides

### API Documentation
- [ ] Endpoint changes
- [ ] Parameter updates
- [ ] Response format changes
- [ ] Authentication updates
- [ ] Deprecation notices

### Other Documentation
- [ ] CLAUDE.md for development guidelines
- [ ] Code comments and docstrings
- [ ] Example code snippets
- [ ] Tutorial updates

## Usage

Simply say: "Update the documentation to reflect the recent changes"

Or be specific: "Update the README to document the new caching feature"

## Best Practices

1. **Update immediately**: Don't let documentation lag behind code
2. **Be thorough**: Check all affected documentation
3. **Test examples**: Ensure code examples still work
4. **Version everything**: Note which version introduces changes
5. **Think like a user**: Write for those who don't know the code

## Integration with Git

Documentation updates should be included in the same commit as code changes:

```bash
git add src/ README.md CHANGELOG.md
git commit -m "Add caching feature with documentation"
```

This ensures documentation is always in sync with the code at every commit.