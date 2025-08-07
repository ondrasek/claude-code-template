# Automated Testing Framework

This directory contains automated tests for the Claude Code Forge ecosystem, including agent selection validation and negative trigger effectiveness testing.

## Test Structure

- `agent-selection/` - Tests for agent selection accuracy and negative trigger validation
- `scripts/` - Automated shell scripts for running tests
- `scenarios/` - Test scenario definitions and expected outcomes
- `results/` - Test execution results and reports

## Running Tests

```bash
# Run all tests
./scripts/run-all-tests.sh

# Run specific test suite
./scripts/run-agent-selection-tests.sh

# Validate negative triggers
./scripts/validate-negative-triggers.sh
```

## Test Categories

1. **Agent Selection Tests** - Validate correct agent selection based on request patterns
2. **Negative Trigger Tests** - Ensure negative triggers prevent inappropriate agent usage
3. **Boundary Tests** - Verify agent coordination and handoff scenarios
4. **Performance Tests** - Measure selection accuracy and speed improvements