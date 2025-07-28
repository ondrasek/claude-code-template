# Git Workflow Instructions

## Automatic Commit, Tag, and Push Policy

**CRITICAL: Commit, tag, and push after EVERY non-trivial change**

Claude Code MUST automatically:
1. Commit changes after completing each meaningful task
2. Create annotated tag for each commit (MANDATORY)
3. Push both commit and tag to origin/main immediately
4. Never batch multiple unrelated changes into one commit

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

### Continuous Tagging Strategy
- **Tag every commit**: Create annotated tag for each non-trivial change (MANDATORY)
- **Version format**: `v1.2.3` (following semantic versioning)
- **Incremental versioning**: Increment patch version for each commit
- **Release identification**: Major releases are simply specific tagged commits
- **Tag process** (automatic for every non-trivial change):
  1. Commit changes to main
  2. Create annotated tag: `git tag -a v1.2.3 -m "Brief description of change"`
  3. Push both commit and tag: `git push origin main && git push origin v1.2.3`

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

## Mandatory Workflow (Every Non-Trivial Change)
```bash
# After making changes
git add -A
git commit -m "Add feature X

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>"

# MANDATORY: Create annotated tag for each commit
git tag -a v1.2.3 -m "Add feature X - incremental development tag"

# Push both commit and tag
git push origin main
git push origin v1.2.3
```

## Tag Naming Strategy
- **Semantic versioning**: Use `v1.2.3` format for all tags
- **Incremental tags**: Tag every non-trivial commit (not just releases)
- **Tag messages**: Brief description of the change
- **Continuous tagging**: Enables easy navigation through development history

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