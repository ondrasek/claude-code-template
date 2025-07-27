#!/bin/bash
# pre-read-file-hook: Quick security scan

filename="$CLAUDE_FILE_PATH"

# Simple check for obvious secrets - Claude Code already handles file security
if grep -qiE "(BEGIN.*PRIVATE KEY|api[_-]?key.*=|password.*=|secret.*=|token.*=)" "$filename" 2>/dev/null; then
    echo "Note: File may contain sensitive values"
fi

# Warn about very large files
if [ -f "$filename" ]; then
    size=$(wc -c < "$filename" 2>/dev/null || echo 0)
    if [ "$size" -gt 10485760 ]; then  # 10MB
        echo "Note: Large file ($(($size / 1048576))MB)"
    fi
fi

exit 0