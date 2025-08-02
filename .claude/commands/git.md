# Git Protocol Command

**Name:** git
**Usage:** `/git`
**Description:** Fully automated Git Protocol implementation using specialist-git-workflow agent

## Purpose

This command implements the complete Git Protocol as described in CLAUDE.md by delegating all git operations to the specialist-git-workflow agent. This prevents context window clutter while ensuring full protocol compliance.

## Functionality

The `/git` command is **completely automated** and:

1. **Analyzes Changed Files**: Intelligently examines modifications to generate meaningful commit messages
2. **Detects Repository State**: Checks for uncommitted changes, staging status, and branch information
3. **Stages Changes**: Runs `git add -A` to stage all modifications automatically
4. **Creates Intelligent Commits**: Generates descriptive commit messages based on file analysis
5. **Evaluates for Tags**: Determines if commits warrant release tags (patch/minor/major)
6. **Creates Release Tags**: Automatically creates and annotates release tags when appropriate
7. **Updates CHANGELOG.md**: Adds release notes when tags are created
8. **Updates README.md**: Spawns separate agent to synchronize README.md with current repository state
9. **Pushes Changes**: Pushes all commits and tags to the remote repository
10. **Error Recovery**: Handles git operation failures with systematic troubleshooting

## Usage Examples

### Zero-Argument Usage
```
/git
```
**That's it!** No arguments, no options, no decisions. The command:
- Analyzes all changed files to understand what was modified
- Generates intelligent commit messages based on file patterns and changes
- Automatically follows the complete Git Protocol
- Updates both CHANGELOG.md and README.md when appropriate
- Handles everything transparently

**Example intelligent commit message generation:**
- Modified `.claude/agents/` → "Update agent definitions for improved functionality"
- Changed `src/components/` → "Enhance UI components with new features"
- Added `.claude/commands/` → "Add new slash commands for workflow automation"
- Updated `README.md` → "Update documentation to reflect current features"

## Agent Delegation

This command delegates ALL git operations to the `specialist-git-workflow` agent with intelligent automation:

```
Execute the complete Git Protocol as specified in CLAUDE.md with full automation:

1. Analyze changed files to generate intelligent commit message
2. Check repository status for uncommitted changes
3. Stage all changes with `git add -A`
4. Create commit with AI-generated descriptive message
5. Evaluate commits for release tag creation (patch/minor/major)
6. Create release tags with proper versioning if warranted
7. Update CHANGELOG.md with release notes for any new tags
8. Spawn specialist-code-cleaner agent to update README.md with current repository state
9. Push all changes and tags to remote repository
10. Provide comprehensive status report

Working Directory: [CURRENT_DIRECTORY]
Mode: FULLY_AUTOMATED (no user input required)

Generate intelligent commit messages by analyzing:
- File paths and types modified
- Nature of changes (new files, deletions, modifications)
- Context from file contents where relevant
- Conventional commit patterns where applicable

Report any errors and provide systematic troubleshooting if git operations fail.
```

## README.md Synchronization

When release tags are created, the command automatically spawns a **specialist-code-cleaner** agent to:
- Update README.md with current repository state
- Reflect new features, commands, and capabilities
- Update version information and installation instructions
- Ensure documentation accuracy matches codebase
- Maintain consistent formatting and structure

This keeps README.md always current without cluttering the main context window.

## Error Handling

The specialist-git-workflow agent handles:
- Merge conflicts and resolution guidance
- Authentication issues
- Network connectivity problems
- Repository corruption detection
- Branch synchronization issues
- Tag conflicts and resolution

## Integration with CLAUDE.md Protocol

This command ensures compliance with the Git Protocol mandates:
- ✅ **Stage immediately**: `git add -A` after any file modification
- ✅ **Commit at milestones**: When any meaningful task is complete
- ✅ **Always invoke git workflow**: Uses specialist-git-workflow agent after EVERY change
- ✅ **Update documentation**: When tags are created, updates CHANGELOG.md with release notes and README.md with current state
- ✅ **Push immediately**: `git push origin main` after every commit

## Benefits

1. **Zero Cognitive Load**: No arguments, options, or decisions required from user
2. **Intelligent Automation**: AI-generated commit messages based on file analysis
3. **Context Preservation**: Keeps main conversation focused by delegating git operations
4. **Protocol Compliance**: Ensures 100% adherence to Git Protocol requirements
5. **Documentation Sync**: Automatically keeps README.md current with repository state
6. **Automated Releases**: Intelligent tag creation based on commit significance
7. **Error Recovery**: Systematic troubleshooting for git operation failures
8. **Comprehensive Reporting**: Detailed status and outcome reporting
9. **Consistency**: Standardized git workflow across all project operations
10. **"Just Works" Philosophy**: Maximum automation with minimal user intervention

## Security Considerations

- Agent validates all git operations before execution
- Sensitive information is redacted from logs and reports
- Authentication credentials are handled securely
- Branch protection rules are respected
- Force pushes are avoided unless explicitly required

## Implementation Notes

- Command parses user input for custom commit messages and options
- All actual git operations are performed by the specialist-git-workflow agent
- Main context receives only summary status reports
- Full git operation details are handled in agent context
- Agent maintains comprehensive error logging and recovery procedures