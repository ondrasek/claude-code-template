# Git Workflow Instructions

## Automatic Commit and Push Policy

**IMPORTANT: Commit and push after EVERY non-trivial change**

Claude Code MUST automatically:
1. Commit changes after completing each meaningful task
2. Push to origin/main immediately after committing
3. Never batch multiple unrelated changes into one commit
4. Create tags ONLY for value-adding increments that lead to releases

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

### Selective Tagging Strategy
- **Tag only releases**: Create tags when repository is in working state with completed value-adding increment
- **Version format**: `v1.2.3` (following semantic versioning)
- **Release criteria**: Repository must be stable and feature-complete for that increment
- **When to tag**:
  - Major feature completion
  - Significant bug fixes or improvements
  - Documentation milestones
  - Configuration improvements that add value
  - When multiple related commits form a coherent release
- **Tag process** (only for releases):
  1. Ensure repository is in working state
  2. Verify all tests pass and functionality works
  3. Update CHANGELOG.md with release notes
  4. Create annotated tag: `git tag -a v1.2.3 -m "Release version 1.2.3 - brief description"`
  5. Push both commit and tag: `git push origin main && git push origin v1.2.3`

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

## Standard Workflow (Every Non-Trivial Change)
```bash
# After making changes - commit and push immediately
git add -A
git commit -m "Add feature X

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>"

git push origin main
```

## Release Workflow (Only for Value-Adding Increments)
```bash
# After completing a meaningful increment
git add -A
git commit -m "Complete feature X - ready for release

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>"

# Update CHANGELOG.md with release notes
# Verify repository is in working state

# Create release tag
git tag -a v1.2.3 -m "Release version 1.2.3 - feature X completion"

# Push both commit and tag
git push origin main
git push origin v1.2.3
```

## Tag Guidelines
- **Quality over quantity**: Only tag stable, working increments
- **Semantic versioning**: Use `v1.2.3` format for release tags
- **Meaningful releases**: Each tag should represent completed value
- **Working state**: Repository must be functional when tagged

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