#!/bin/bash
# pre-read-file-hook: Security checks before reading files

filename="$CLAUDE_FILE_PATH"

# Check if file contains sensitive information
sensitive_patterns=(
    "BEGIN.*PRIVATE KEY"
    "api[_-]?key.*=.*['\"]"
    "password.*=.*['\"]"
    "secret.*=.*['\"]"
    "token.*=.*['\"]"
)

for pattern in "${sensitive_patterns[@]}"; do
    if grep -qiE "$pattern" "$filename" 2>/dev/null; then
        echo "Warning: File may contain sensitive information. Redacting sensitive values..."
        
        # Create a temporary redacted version
        temp_file="/tmp/claude_redacted_$(basename "$filename")"
        cp "$filename" "$temp_file"
        
        # Redact sensitive information
        sed -i -E 's/(api[_-]?key.*=.*['\"])[^'\"]+/\1REDACTED/gi' "$temp_file"
        sed -i -E 's/(password.*=.*['\"])[^'\"]+/\1REDACTED/gi' "$temp_file"
        sed -i -E 's/(secret.*=.*['\"])[^'\"]+/\1REDACTED/gi' "$temp_file"
        sed -i -E 's/(token.*=.*['\"])[^'\"]+/\1REDACTED/gi' "$temp_file"
        
        # Note: In a real implementation, you might want to modify how Claude reads the file
        # For now, we just warn
        echo "Note: Sensitive values detected. Please be careful not to expose them."
        rm -f "$temp_file"
    fi
done

# Check file size (warn for very large files)
if [ -f "$filename" ]; then
    size=$(stat -f%z "$filename" 2>/dev/null || stat -c%s "$filename" 2>/dev/null)
    if [ "$size" -gt 10485760 ]; then  # 10MB
        echo "Warning: Large file ($(($size / 1048576))MB). This may impact performance."
    fi
fi

# Always allow read to continue
exit 0