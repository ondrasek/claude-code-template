# Git Workflow Instructions

## Automatic Commit and Push Policy

**IMPORTANT: Commit and push after EVERY non-trivial change**

Claude Code MUST automatically:
1. **Export memories**: Use `/memory-export` to sync MCP memory to files before every commit
2. **Stage all changes**: Include both code changes AND exported memory files
3. Commit changes after completing each meaningful task
4. Push to origin/main immediately after committing
5. Never batch multiple unrelated changes into one commit
6. Create tags ONLY for value-adding increments that lead to releases

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

### Automatic Tagging Strategy
- **Automatic tag detection**: Claude Code MUST automatically determine when to create tags
- **Version format**: `v1.2.3` (following semantic versioning)
- **Release criteria**: Repository must be stable and feature-complete for that increment

**AUTOMATIC TAG TRIGGERS** (Claude Code decides without user instruction):
- **Major feature completion**: When a significant new capability is fully implemented
- **Significant bug fixes**: When critical issues are resolved and functionality restored
- **Documentation milestones**: When major documentation updates are complete and consistent
- **Configuration improvements**: When setup/tooling changes add meaningful value
- **Coherent release points**: When multiple related commits form a logical increment
- **TODO completion clusters**: When multiple TODOs are completed forming a valuable release
- **Agent/command additions**: When new agents or commands are fully implemented and tested

**AUTOMATIC TAG ASSESSMENT** (evaluate after each commit):
1. **Functionality completeness**: Is a meaningful feature/fix/improvement complete?
2. **Repository stability**: Are there no broken features or incomplete implementations?
3. **Value threshold**: Does this change provide substantial value to users?
4. **Logical breakpoint**: Is this a natural stopping point in development?
5. **Test status**: Do existing functionalities still work as expected?

**TAG PROCESS** (delegated to tagger agent):
1. After each commit, automatically invoke `tagger` agent
2. Tagger agent evaluates commit against 5-point criteria autonomously  
3. If criteria met, tagger agent creates tag without polluting main context
4. Tagger agent updates CHANGELOG.md and pushes tag automatically
5. Main workflow continues without tag-related context pollution

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

## Automated Workflow with Claude Code Hooks

**AUTOMATIC MEMORY EXPORT**: Claude Code hook system automatically exports memories before every commit.

### Hook Configuration (`.claude/settings.json`):
```json
{
  "hooks": {
    "beforeBashExecution": {
      "patterns": [
        "git commit*",
        "git add -A && git commit*"
      ],
      "command": "/memory-export"
    }
  }
}
```

### Simplified Commit Process:
```bash
# Just commit normally - memory export happens automatically!
git add -A
git commit -m "Add feature X

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>"

git push origin main
```

### What Happens Automatically:
1. **Pre-commit hook**: `/memory-export` runs before `git commit`
2. **Memory sync**: Current MCP memory exported to `memories/` folder
3. **Auto-staging**: Exported memory files automatically included in commit
4. **Knowledge preservation**: All session insights, patterns, and decisions saved

## Agent-Delegated Release Workflow
```bash
# Simple commit - memory export happens via hook
git add -A
git commit -m "Complete feature X"
git push origin main

# Automatically invoke tagger agent (happens in background):
# Task: "Evaluate latest commit for potential tagging" 
# - Tagger agent assesses 5-point criteria independently
# - If warranted, tagger creates tag and updates CHANGELOG autonomously
# - Main context stays clean, focused on primary development work
```

## Automatic Tag Guidelines
- **Autonomous decision-making**: Claude Code decides when to tag without user instruction
- **Quality assessment**: Only tag when repository is stable and increment is complete
- **Semantic versioning**: Auto-determine appropriate version increment (major/minor/patch)
- **Value-based tagging**: Each tag represents meaningful, completed value
- **Working state verification**: Ensure repository functionality before tagging
- **No user prompting**: Never ask user "should I create a tag?" - make the decision automatically

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