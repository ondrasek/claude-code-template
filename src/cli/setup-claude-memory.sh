#!/bin/bash
# Claude Code Memory Setup Script
# Sets up memory export/import workflow for Claude Code

echo "Setting up Claude Code memory workflow..."

# Create .support/memories directory for exported memory files
mkdir -p .support/memories

# Set appropriate permissions
chmod -R 755 .support/memories/

# Create info file explaining Claude Code memory workflow
cat > .support/memories/README.md << 'EOF'
# Claude Code Memory Files

This directory contains exported memory files from Claude Code's MCP memory server.

## Purpose:
Enables version control and sharing of Claude Code memory state through:
- **Memory Export**: Export memory entities to individual markdown files
- **Memory Import**: Import memory entities from markdown files
- **Git Integration**: Human-readable files suitable for version control

## Workflow:
1. Use `/memory-export` to save current memory state to .md files
2. Commit memory files to git for team collaboration
3. Use `/memory-import` to restore memory state from .md files
4. Memory persists across Claude Code sessions and environments

## File Format:
Each memory entity becomes a separate markdown file with:
- YAML frontmatter containing entity metadata
- Markdown content with observations and context

## Benefits:
- **Git-friendly**: Individual files prevent merge conflicts
- **Human-readable**: Markdown format for manual review/editing
- **Collaborative**: Share memory state across team members
- **Portable**: Works across different environments

## Commands:
- `/memory-export` - Export current memory to files
- `/memory-import` - Import memory from files
EOF

echo "✅ Claude Code memory workflow setup complete!"
echo "💾 Use /memory-export and /memory-import to manage persistent memory"
echo "📁 Memory files will be stored in .support/memories/ directory"