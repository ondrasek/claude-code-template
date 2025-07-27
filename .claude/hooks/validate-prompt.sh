#!/bin/bash
# user-prompt-submit-hook: Validate and log user prompts

# Log the prompt for audit purposes
echo "[$(date)] User prompt: $CLAUDE_PROMPT" >> ~/.claude-code/prompts.log

# Check for potentially dangerous commands
if echo "$CLAUDE_PROMPT" | grep -iE "(rm -rf|delete .*system|format.*drive)" > /dev/null; then
    echo "Error: This prompt contains potentially dangerous operations. Please review and confirm."
    exit 1
fi

# Check if prompt mentions sensitive files
if echo "$CLAUDE_PROMPT" | grep -iE "(password|\.env|secret|private.*key)" > /dev/null; then
    echo "Warning: This prompt mentions sensitive information. Proceeding with caution."
    # Don't block, just warn
fi

# Success - allow prompt to continue
exit 0