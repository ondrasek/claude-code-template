#!/bin/bash
# post-edit-file-hook: Auto-format code after edits

# Get file extension
filename="$CLAUDE_FILE_PATH"
extension="${filename##*.}"

# Format based on file type
case "$extension" in
    py)
        # Format Python files with black
        if command -v black &> /dev/null; then
            black "$filename" 2>/dev/null
        fi
        # Run flake8 for linting
        if command -v flake8 &> /dev/null; then
            flake8 "$filename" || true  # Don't block on lint errors
        fi
        ;;
    
    js|jsx|ts|tsx)
        # Format JavaScript/TypeScript with prettier
        if command -v prettier &> /dev/null; then
            prettier --write "$filename" 2>/dev/null
        fi
        # Run eslint
        if command -v eslint &> /dev/null; then
            eslint --fix "$filename" 2>/dev/null || true
        fi
        ;;
    
    go)
        # Format Go files
        if command -v gofmt &> /dev/null; then
            gofmt -w "$filename" 2>/dev/null
        fi
        ;;
    
    rs)
        # Format Rust files
        if command -v rustfmt &> /dev/null; then
            rustfmt "$filename" 2>/dev/null
        fi
        ;;
    
    json)
        # Format JSON files with jq
        if command -v jq &> /dev/null; then
            jq . "$filename" > "$filename.tmp" && mv "$filename.tmp" "$filename" 2>/dev/null || true
        fi
        ;;
esac

# Always succeed to not block Claude's workflow
exit 0