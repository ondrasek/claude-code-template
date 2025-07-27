#!/usr/bin/env bash

# Claude Code Template Validation Script
# 
# Purpose: Validates that the Claude Code template structure is complete and correct.
# This is a health check that ensures all required files, directories, and configurations
# are present and properly formatted. Run this after cloning or modifying the template
# to ensure everything is in working order.
#
# Usage: ./validate-template.sh
# Returns: 0 if all checks pass, 1 if any check fails

set -e

echo "🔍 Verifying Claude Code Template Setup..."
echo ""

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check function
check() {
    if eval "$2"; then
        echo -e "${GREEN}✓${NC} $1"
        return 0
    else
        echo -e "${RED}✗${NC} $1"
        return 1
    fi
}

# Warning function
warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

echo "📂 Checking directory structure..."
check ".claude directory exists" "[ -d .claude ]"
check "Commands directory exists" "[ -d .claude/commands ]"
check "Agents directory exists" "[ -d .claude/agents ]"
check "MCP servers directory exists" "[ -d .claude/mcp-servers ]"
check "Settings file exists" "[ -f .claude/settings.json ]"
echo ""

echo "📜 Checking command files..."
COMMANDS=(review test refactor security debug-mcp langchain-agent crewai-crew python-uv agent-guide doc-update stacks use-python create-prompt discuss)
for cmd in "${COMMANDS[@]}"; do
    check "Command /$cmd exists" "[ -f .claude/commands/$cmd.md ]"
done
echo ""

echo "🤖 Checking agent files..."
AGENTS=(context patterns explore whisper constraints time connect complete hypothesis meta principles axioms invariants resolve docsync researcher python-expert prompt-engineer critic)
for agent in "${AGENTS[@]}"; do
    check "Agent $agent exists" "[ -f .claude/agents/$agent.md ]"
done
echo ""

echo "🔧 Checking MCP configurations..."
check "Project MCP config exists" "[ -f .mcp.json ]"
check "Example MCP config exists" "[ -f .claude/mcp-servers/example-config.json ]"
check "AI agent MCP config exists" "[ -f .claude/mcp-servers/ai-agent-development.json ]"
check "MCP servers README exists" "[ -f .claude/mcp-servers/README.md ]"
echo ""

echo "📚 Checking technology stacks..."
check "Stacks directory exists" "[ -d .claude/stacks ]"
check "Python stack exists" "[ -f .claude/stacks/python.md ]"
echo ""

echo "📚 Checking documentation..."
check "README.md exists" "[ -f README.md ]"
check "CLAUDE.md exists" "[ -f CLAUDE.md ]"
check "CHANGELOG.md exists" "[ -f CHANGELOG.md ]"
check "LICENSE exists" "[ -f LICENSE ]"
echo ""

echo "🚀 Checking installation scripts..."
check "install.sh exists" "[ -f install.sh ]"
check "install.sh is executable" "[ -x install.sh ]"
check "bootstrap.sh exists" "[ -f bootstrap.sh ]"
check "bootstrap.sh is executable" "[ -x bootstrap.sh ]"
echo ""

echo "🔍 Checking for deprecated references..."
if grep -r "claude_config.json" . --exclude-dir=.git --exclude="validate-template.sh" 2>/dev/null | grep -v "Binary file"; then
    warn "Found references to deprecated claude_config.json"
else
    echo -e "${GREEN}✓${NC} No deprecated claude_config.json references found"
fi

if grep -r "github.*mcp.*server" .claude/mcp-servers/ 2>/dev/null | grep -i github; then
    warn "Found references to deprecated GitHub MCP server"
else
    echo -e "${GREEN}✓${NC} No deprecated GitHub MCP server references"
fi
echo ""

echo "📝 Checking agent descriptions for proactive keywords..."
if grep -l "PROACTIVELY\|MUST BE USED" .claude/agents/*.md > /dev/null 2>&1; then
    echo -e "${GREEN}✓${NC} Found agents with proactive usage instructions"
else
    warn "No agents found with explicit proactive usage instructions"
fi
echo ""

echo "🔐 Checking security files..."
check ".gitignore exists" "[ -f .gitignore ]"
echo ""

echo "✨ Verification complete!"
echo ""
echo "To use this template:"
echo "1. As GitHub dotfiles: Fork as 'dotfiles' repo and enable in GitHub Codespaces"
echo "2. As template: Use 'Use this template' button on GitHub"
echo "3. Direct install: Run ./install.sh"
echo ""
echo "For more information, see README.md"