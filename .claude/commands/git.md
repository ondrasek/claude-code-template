# Git Protocol Command

**Name:** git
**Usage:** `/git [message] [options]`
**Description:** Automated Git Protocol implementation using specialist-git-workflow agent

## Purpose

This command implements the complete Git Protocol as described in CLAUDE.md by delegating all git operations to the specialist-git-workflow agent. This prevents context window clutter while ensuring full protocol compliance.

## Functionality

The `/git` command automatically:

1. **Detects Repository State**: Checks for uncommitted changes, staging status, and branch information
2. **Stages Changes**: Runs `git add -A` to stage all modifications if needed
3. **Creates Commits**: Generates appropriate commit messages if changes are present
4. **Evaluates for Tags**: Determines if commits warrant release tags (patch/minor/major)
5. **Creates Release Tags**: Automatically creates and annotates release tags when appropriate
6. **Updates CHANGELOG.md**: Adds release notes when tags are created
7. **Pushes Changes**: Pushes all commits and tags to the remote repository
8. **Error Recovery**: Handles git operation failures with systematic troubleshooting

## Usage Examples

### Basic Usage
```
/git
```
Automatically commits all changes with a generated message and follows the full Git Protocol.

### Custom Commit Message
```
/git "Add new authentication feature"
```
Uses the provided message for the commit while still following the complete Git Protocol.

### Options
```
/git --dry-run
```
Shows what actions would be taken without executing them.

```
/git --force-tag
```
Forces tag creation evaluation even for minor changes.

```
/git --no-push
```
Completes local git operations but skips pushing to remote.

## Agent Delegation

This command delegates ALL git operations to the `specialist-git-workflow` agent with the following prompt structure:

```
Execute the complete Git Protocol as specified in CLAUDE.md:

1. Check repository status for uncommitted changes
2. Stage all changes with `git add -A` if needed
3. Create appropriate commit with message: [USER_MESSAGE or GENERATED]
4. Evaluate commits for release tag creation (patch/minor/major)
5. Create release tags with proper versioning if warranted
6. Update CHANGELOG.md with release notes for any new tags
7. Push all changes and tags to remote repository
8. Provide comprehensive status report

Options: [PARSED_OPTIONS]
Working Directory: [CURRENT_DIRECTORY]

Report any errors and provide systematic troubleshooting if git operations fail.
```

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
- ✅ **Update CHANGELOG.md**: When tags are created, updates CHANGELOG.md with release notes
- ✅ **Push immediately**: `git push origin main` after every commit

## Benefits

1. **Context Preservation**: Keeps main conversation focused by delegating git operations
2. **Protocol Compliance**: Ensures 100% adherence to Git Protocol requirements
3. **Automated Releases**: Intelligent tag creation based on commit significance
4. **Error Recovery**: Systematic troubleshooting for git operation failures
5. **Comprehensive Reporting**: Detailed status and outcome reporting
6. **Consistency**: Standardized git workflow across all project operations

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