# Claude Code Hooks

Minimal, efficient hooks that complement Claude Code's built-in capabilities.

## Philosophy

- **Lightweight**: Quick checks that don't slow down workflow
- **Non-blocking**: Always exit 0 to avoid interrupting Claude
- **Complementary**: Don't duplicate Claude Code's existing safeguards
- **Informative**: Provide helpful notes, not strict enforcement

## Active Hooks

### validate-prompt.sh
- **Purpose**: Note when working with sensitive data
- **Why kept**: Helpful awareness without blocking
- **Removed**: Prompt logging (unbounded growth), dangerous command blocking (Claude already handles)

### format-after-edit.sh  
- **Purpose**: Auto-format code after edits
- **Why kept**: Maintains consistent code style automatically
- **Efficient**: Only runs if formatting tools are available

### pre-read-security.sh
- **Purpose**: Quick scan for secrets and large files
- **Why kept**: Helpful warnings without performance impact
- **Removed**: Complex redaction logic that wasn't used

## Removed Features

1. **Prompt logging**: Creates unbounded log files
2. **Dangerous command blocking**: Claude Code already has safeguards
3. **Complex secret redaction**: Created temp files but didn't use them
4. **Overly specific patterns**: Basic grep is sufficient for awareness

## Configuration

Hooks are configured in `.claude/config.json`:

```json
"hooks": {
  "user-prompt-submit-hook": ".claude/hooks/validate-prompt.sh",
  "post-edit-file-hook": ".claude/hooks/format-after-edit.sh",
  "pre-read-file-hook": ".claude/hooks/pre-read-security.sh"
}
```

## Performance Impact

- validate-prompt.sh: ~5ms (simple grep)
- format-after-edit.sh: 50-200ms (only when saving code files)
- pre-read-security.sh: ~10ms (quick file scan)

Total overhead: Minimal and worth the benefits.