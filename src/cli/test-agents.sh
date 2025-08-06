#!/usr/bin/env bash

# Quick test to verify Claude Code sees all agents

echo "🧪 Testing Claude Code Agent Recognition"
echo ""

# Test agent activation phrases
TESTS=(
    "Find patterns in this code:patterns"
    "Research Python best practices:researcher"  
    "Is this a good idea:critic"
    "Complete all TODOs:complete"
    "Update documentation:docsync"
)

echo "Run these prompts in Claude Code to test agents:"
echo ""

for test in "${TESTS[@]}"; do
    IFS=':' read -r prompt agent <<< "$test"
    echo "✓ To test '$agent' agent:"
    echo "  claude \"$prompt\""
    echo ""
done

echo "Or run all at once:"
echo "claude \"List all available agents and their activation triggers\""