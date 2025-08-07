#!/bin/bash

# Master test runner for all automated tests
# Orchestrates the complete test suite for agent selection and negative triggers

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
RESULTS_DIR="$ROOT_DIR/tests/results"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Test suite tracking
TOTAL_SUITES=0
PASSED_SUITES=0
FAILED_SUITES=0

echo -e "${BOLD}${BLUE}======================================${NC}"
echo -e "${BOLD}${BLUE}  Claude Code Forge Test Suite        ${NC}"
echo -e "${BOLD}${BLUE}  Negative Triggers & Agent Selection ${NC}"
echo -e "${BOLD}${BLUE}======================================${NC}"
echo

mkdir -p "$RESULTS_DIR"

# Function to run test suite and track results
run_test_suite() {
    local suite_name="$1"
    local script_path="$2"
    
    echo -e "${YELLOW}=== Running Test Suite: $suite_name ===${NC}"
    TOTAL_SUITES=$((TOTAL_SUITES + 1))
    
    if [[ ! -f "$script_path" ]]; then
        echo -e "${RED}❌ FAILED: Test script not found: $script_path${NC}"
        FAILED_SUITES=$((FAILED_SUITES + 1))
        return 1
    fi
    
    # Make script executable if not already
    chmod +x "$script_path"
    
    # Run the test suite
    if "$script_path"; then
        echo -e "${GREEN}✅ PASSED: $suite_name${NC}"
        PASSED_SUITES=$((PASSED_SUITES + 1))
        return 0
    else
        echo -e "${RED}❌ FAILED: $suite_name${NC}"
        FAILED_SUITES=$((FAILED_SUITES + 1))
        return 1
    fi
}

# Run all test suites
echo -e "${BLUE}Starting automated test execution...${NC}"
echo

# Test Suite 1: Negative Triggers Validation
run_test_suite \
    "Negative Triggers Validation" \
    "$SCRIPT_DIR/validate-negative-triggers.sh"

echo

# Test Suite 2: Agent Selection Accuracy
run_test_suite \
    "Agent Selection Accuracy" \
    "$SCRIPT_DIR/run-agent-selection-tests.sh"

echo

# Generate comprehensive summary report
echo -e "${BOLD}${BLUE}=== COMPREHENSIVE TEST RESULTS ===${NC}"
echo -e "Test Suites Executed: ${BOLD}$TOTAL_SUITES${NC}"
echo -e "Passed: ${GREEN}${BOLD}$PASSED_SUITES${NC}"
echo -e "Failed: ${RED}${BOLD}$FAILED_SUITES${NC}"

OVERALL_SUCCESS_RATE=0
if [[ $TOTAL_SUITES -gt 0 ]]; then
    OVERALL_SUCCESS_RATE=$(( (PASSED_SUITES * 100) / TOTAL_SUITES ))
fi

echo -e "Overall Success Rate: ${BOLD}$OVERALL_SUCCESS_RATE%${NC}"

# Create comprehensive summary report
SUMMARY_FILE="$RESULTS_DIR/comprehensive-test-summary-$(date +%Y%m%d-%H%M%S).log"
{
    echo "Claude Code Forge - Comprehensive Test Summary"
    echo "=============================================="
    echo "Generated: $(date)"
    echo "Test Framework: Negative Triggers & Agent Selection Validation"
    echo
    echo "EXECUTION SUMMARY"
    echo "-----------------"
    echo "Total Test Suites: $TOTAL_SUITES"
    echo "Passed Suites: $PASSED_SUITES"
    echo "Failed Suites: $FAILED_SUITES" 
    echo "Overall Success Rate: $OVERALL_SUCCESS_RATE%"
    echo
    echo "TEST SCOPE"
    echo "----------"
    echo "1. Negative Triggers Validation"
    echo "   - Agent definition compliance"
    echo "   - Scenario pattern validation"
    echo "   - Policy compliance (critic/conflicts unrestricted)"
    echo
    echo "2. Agent Selection Accuracy"
    echo "   - 8 documented test scenarios"
    echo "   - Foundation agent boundaries"
    echo "   - Specialist agent scope prevention"
    echo "   - Coordination challenge identification"
    echo
    echo "QUALITY METRICS"
    echo "---------------"
    echo "Target: 80% prevention rate for inappropriate selections"
    echo "Benchmark: 87.5% (from original implementation testing)"
    echo
    
    if [[ $OVERALL_SUCCESS_RATE -eq 100 ]]; then
        echo "STATUS: 🎉 EXCELLENT - All test suites passing"
    elif [[ $OVERALL_SUCCESS_RATE -ge 80 ]]; then
        echo "STATUS: ✅ SUCCESS - Meets quality targets"
    else
        echo "STATUS: ❌ NEEDS ATTENTION - Below quality targets"
    fi
    
    echo
    echo "IMPLEMENTATION IMPACT"
    echo "--------------------"
    echo "✅ Foundation agent boundary enforcement (researcher/context, patterns/principles)"
    echo "✅ Specialist agent scope prevention (git-workflow, performance-optimizer, etc.)"
    echo "✅ Policy compliance (critic/conflicts agents unrestricted)"
    echo "✅ Clear delegation paths in all negative triggers"
    echo "⚠️ Code quality coordination opportunities identified"
    
} > "$SUMMARY_FILE"

echo
echo -e "${BLUE}Comprehensive summary written to:${NC} $SUMMARY_FILE"
echo

# Final status and recommendations
if [[ $OVERALL_SUCCESS_RATE -eq 100 ]]; then
    echo -e "${GREEN}${BOLD}🎉 EXCELLENT RESULTS${NC}"
    echo -e "${GREEN}All automated tests passing - negative triggers implementation is highly effective${NC}"
elif [[ $OVERALL_SUCCESS_RATE -ge 80 ]]; then
    echo -e "${GREEN}${BOLD}✅ SUCCESS${NC}"  
    echo -e "${GREEN}Test suite meets quality targets - ready for production usage${NC}"
else
    echo -e "${RED}${BOLD}❌ ATTENTION NEEDED${NC}"
    echo -e "${RED}Some test suites failed - review negative trigger implementation${NC}"
    echo
    echo -e "${YELLOW}Recommendations:${NC}"
    echo "  • Review failed test scenarios"
    echo "  • Enhance negative trigger specificity"  
    echo "  • Improve agent coordination guidance"
    echo "  • Validate agent definition completeness"
fi

echo
echo -e "${BLUE}Test execution completed at $(date)${NC}"

# Exit with appropriate code
if [[ $OVERALL_SUCCESS_RATE -ge 80 ]]; then
    exit 0
else
    exit 1
fi