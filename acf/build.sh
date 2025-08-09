#!/bin/bash
set -e

# ACF package data build script
# Copies source files from repository root to package data directory

echo "Building ACF package data..."

# Get repository root (parent of acf directory)
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACKAGE_DATA="$(cd "$(dirname "${BASH_SOURCE[0]}")/src/acf/data" && pwd)"

echo "Repository root: $REPO_ROOT"
echo "Package data dir: $PACKAGE_DATA"

# Clean existing data
rm -rf "$PACKAGE_DATA"/{claude,acf,CLAUDE.md}

# Create data structure
mkdir -p "$PACKAGE_DATA"/{claude,acf}

# Copy .claude directory (Claude Code recognized files)
echo "Copying .claude directory..."
cp -r "$REPO_ROOT/.claude"/* "$PACKAGE_DATA/claude/"

# Copy ACF-managed files (non-Claude Code files)
echo "Copying templates, scripts, docs..."
cp -r "$REPO_ROOT"/templates "$PACKAGE_DATA/acf/"
cp -r "$REPO_ROOT"/scripts "$PACKAGE_DATA/acf/"
cp -r "$REPO_ROOT"/docs "$PACKAGE_DATA/acf/"

# Copy CLAUDE.md to root
echo "Copying CLAUDE.md..."
cp "$REPO_ROOT/CLAUDE.md" "$PACKAGE_DATA/"

echo "Build complete!"
echo "Package data structure:"
find "$PACKAGE_DATA" -type d | head -20