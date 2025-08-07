#!/bin/bash

# Negative Triggers Validation Script
# Validates agent selection accuracy by testing against negative trigger scenarios

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
AGENTS_DIR="$ROOT_DIR/.claude/agents"
SCENARIOS_DIR="$ROOT_DIR/tests/scenarios"
RESULTS_DIR="$ROOT_DIR/tests/results"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

echo -e "${BLUE}=== Negative Triggers Validation Test Suite ===${NC}"
echo "Testing agent selection accuracy with negative trigger scenarios"
echo

# Create results directory if it doesn't exist
mkdir -p "$RESULTS_DIR"

# Function to test agent negative triggers
test_agent_negative_triggers() {
    local agent_file="$1"
    local agent_name=$(basename "$agent_file" .md)
    
    echo -e "${BLUE}Testing agent: ${agent_name}${NC}"
    
    # Check if agent has negative triggers section
    if grep -q "Do NOT choose" "$agent_file"; then
        echo -e "  ${GREEN}✓${NC} Has negative triggers section"
        PASSED_TESTS=$((PASSED_TESTS + 1))
    else
        # Check if this is critic or conflicts agent (should not have negative triggers)
        if [[ "$agent_name" == "critic" || "$agent_name" == "conflicts" ]]; then
            echo -e "  ${GREEN}✓${NC} Correctly has no negative triggers (policy compliance)"
            PASSED_TESTS=$((PASSED_TESTS + 1))
        else
            echo -e "  ${RED}✗${NC} Missing negative triggers section"
            FAILED_TESTS=$((FAILED_TESTS + 1))
        fi
    fi
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
}

# Function to validate specific scenario patterns
test_scenario_patterns() {
    local scenario_name="$1"
    local request_pattern="$2"
    local incorrect_agent="$3"
    local expected_behavior="$4"
    
    echo -e "${BLUE}Testing scenario: ${scenario_name}${NC}"
    
    local agent_file="$AGENTS_DIR"/*/"$incorrect_agent.md"
    
    if [[ -f $agent_file ]]; then
        # Check if the agent has appropriate negative triggers for this pattern
        if grep -q -i "$expected_behavior" "$agent_file"; then
            echo -e "  ${GREEN}✓${NC} Agent has appropriate negative trigger"
            PASSED_TESTS=$((PASSED_TESTS + 1))
        else
            echo -e "  ${RED}✗${NC} Agent missing specific negative trigger pattern"
            FAILED_TESTS=$((FAILED_TESTS + 1))
        fi
    else
        echo -e "  ${YELLOW}⚠${NC} Agent file not found: $incorrect_agent"
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
}

# Test 1: Validate all agents have appropriate negative triggers
echo -e "${YELLOW}=== Phase 1: Agent Negative Triggers Validation ===${NC}"

# Foundation agents
for agent_file in "$AGENTS_DIR"/foundation/*.md; do
    if [[ -f "$agent_file" ]]; then
        test_agent_negative_triggers "$agent_file"
    fi
done

# Specialist agents
for agent_file in "$AGENTS_DIR"/specialist/*.md; do
    if [[ -f "$agent_file" ]]; then
        test_agent_negative_triggers "$agent_file"
    fi
done

echo

# Test 2: Validate specific scenario patterns
echo -e "${YELLOW}=== Phase 2: Scenario Pattern Validation ===${NC}"

# Test scenario patterns from the documented test cases
test_scenario_patterns "Internal vs External Analysis" "codebase analysis" "researcher" "internal codebase"
test_scenario_patterns "Design vs Structure" "SOLID principles" "patterns" "design validation"
test_scenario_patterns "Simple vs Complex Git" "git status" "git-workflow" "simple git commands"
test_scenario_patterns "Session vs Specification" "track tasks" "github-issues-workflow" "session-only"
test_scenario_patterns "Bugs vs Performance" "wrong results" "performance-optimizer" "functional bugs"

echo

# Test 3: Policy Compliance Check
echo -e "${YELLOW}=== Phase 3: Policy Compliance Check ===${NC}"

# Verify critic and conflicts agents don't have negative triggers
if [[ -f "$AGENTS_DIR/foundation/critic.md" ]]; then
    if ! grep -q "Do NOT choose" "$AGENTS_DIR/foundation/critic.md"; then
        echo -e "  ${GREEN}✓${NC} Critic agent correctly unrestricted"
        PASSED_TESTS=$((PASSED_TESTS + 1))
    else
        echo -e "  ${RED}✗${NC} Critic agent incorrectly has negative triggers"
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
fi

if [[ -f "$AGENTS_DIR/foundation/conflicts.md" ]]; then
    if ! grep -q "Do NOT choose" "$AGENTS_DIR/foundation/conflicts.md"; then
        echo -e "  ${GREEN}✓${NC} Conflicts agent correctly unrestricted"
        PASSED_TESTS=$((PASSED_TESTS + 1))
    else
        echo -e "  ${RED}✗${NC} Conflicts agent incorrectly has negative triggers"
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
fi

echo

# Generate results summary
echo -e "${BLUE}=== Test Results Summary ===${NC}"
echo "Total Tests: $TOTAL_TESTS"
echo -e "Passed: ${GREEN}$PASSED_TESTS${NC}"
echo -e "Failed: ${RED}$FAILED_TESTS${NC}"

SUCCESS_RATE=0
if [[ $TOTAL_TESTS -gt 0 ]]; then
    SUCCESS_RATE=$(( (PASSED_TESTS * 100) / TOTAL_TESTS ))
fi

echo "Success Rate: $SUCCESS_RATE%"

# Write detailed results to file
RESULTS_FILE="$RESULTS_DIR/negative-triggers-validation-$(date +%Y%m%d-%H%M%S).log"
{
    echo "Negative Triggers Validation Results"
    echo "Generated: $(date)"
    echo "=================================="
    echo
    echo "Total Tests: $TOTAL_TESTS"
    echo "Passed: $PASSED_TESTS"
    echo "Failed: $FAILED_TESTS"
    echo "Success Rate: $SUCCESS_RATE%"
    echo
    echo "Target: 80% prevention rate"
    
    if [[ $SUCCESS_RATE -ge 80 ]]; then
        echo "Status: ✅ MEETS TARGET"
    else
        echo "Status: ❌ BELOW TARGET"
    fi
} > "$RESULTS_FILE"

echo
echo "Detailed results written to: $RESULTS_FILE"

# Exit with appropriate code
if [[ $SUCCESS_RATE -ge 80 ]]; then
    echo -e "${GREEN}✅ SUCCESS: Meets 80% target for negative trigger effectiveness${NC}"
    exit 0
else
    echo -e "${RED}❌ FAILURE: Below 80% target for negative trigger effectiveness${NC}"
    exit 1
fi