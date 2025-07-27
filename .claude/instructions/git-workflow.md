# Git Workflow Instructions

## Automatic Commit and Push Policy

**IMPORTANT: Commit and push after EVERY non-trivial change**

Claude Code MUST automatically:
1. Commit changes after completing each meaningful task
2. Push to origin/main immediately after committing
3. Never batch multiple unrelated changes into one commit

Examples of when to commit:
- After creating or modifying any file
- After implementing a function or feature
- After fixing a bug
- After updating documentation
- After changing configuration

## Trunk-Based Development

**MANDATORY: Always work directly on the main branch**

### Branch Strategy
- **Default behavior**: ALL work happens on `main` branch
- **Feature branches**: ONLY create if explicitly instructed by the user
- **No long-lived branches**: Merge immediately if a branch was created
- **Continuous integration**: Every commit to main should be deployable

### Release Strategy
- **Use tags for versions**: Tag releases directly on main branch
- **Version format**: `v1.2.3` (following semantic versioning)
- **Release process**:
  1. Commit all changes to main
  2. Update CHANGELOG.md with version
  3. Create annotated tag: `git tag -a v1.2.3 -m "Release version 1.2.3"`
  4. Push tag: `git push origin v1.2.3`

### When NOT to Create Branches
- Regular feature development
- Bug fixes
- Documentation updates
- Refactoring
- Configuration changes
- ANY work unless explicitly told to branch

### When to Create Branches (ONLY if instructed)
- User explicitly says "create a feature branch"
- User mentions working on a specific branch
- User requests a pull request workflow

## Commit Strategy
- **Commit frequently**: Make small, atomic commits after each meaningful change
- **Trunk-based development**: Always work on main branch unless explicitly instructed otherwise
- **No feature branches**: Push directly to main to maintain continuous integration
- **Commit after**: 
  - Adding new features
  - Fixing bugs
  - Refactoring code
  - Updating documentation
  - Modifying configurations
- **Auto-push**: Push commits to origin/main immediately after committing

## Example Workflow
```bash
# After making changes
git add -A
git commit -m "Add feature X"
git push origin main
```

## Commit Message Format
- Use clear, concise messages describing what changed
- Start with a verb in present tense (Add, Update, Fix, Remove, etc.)
- Keep the first line under 50 characters
- Add detailed description after blank line if needed
- End with Claude Code attribution:
  ```
  🤖 Generated with [Claude Code](https://claude.ai/code)
  
  Co-Authored-By: Claude <noreply@anthropic.com>
  ```