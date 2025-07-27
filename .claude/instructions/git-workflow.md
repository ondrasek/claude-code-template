# Git Workflow Instructions

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