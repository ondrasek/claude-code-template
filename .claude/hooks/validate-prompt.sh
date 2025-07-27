#!/bin/bash
# user-prompt-submit-hook: Minimal prompt validation
# Most validation is better handled by Claude Code's built-in safeguards

# Only warn about sensitive information - Claude Code already handles dangerous operations
if echo "$CLAUDE_PROMPT" | grep -iE "(password|\.env|secret|private.*key)" > /dev/null; then
    echo "Note: Working with potentially sensitive information"
fi

# Always allow prompt to continue
exit 0