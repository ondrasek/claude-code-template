# /test

TRIGGER: testing request
FOCUS: run tests, create tests, analyze coverage
FRAMEWORK_DETECTION: automatic (pytest, jest, go test, cargo test, etc.)

ENHANCED_ACTIONS:
1. invoke testing agent: comprehensive test strategy development with universal agent coordination
2. coordinate enhanced parallel testing analysis clusters:
   - **Coverage Analysis Cluster**: patterns + completer + whisper + critic (identify untested patterns, gaps, micro-improvements, critical assessment)
   - **Performance Testing Cluster**: performance + constraints + hypothesis + time (performance requirements, resource limitations, optimization theories, historical analysis)
   - **Security Testing Cluster**: vulnerability-scanner + threat-modeling + compliance-checker + researcher (security testing with threat intelligence)
   - **Quality & Strategy Cluster**: hypothesis + explorer + principles + invariants (edge case generation, alternative approaches, testing principles, design integrity)
   - **Implementation Validation Cluster**: completer + docs + guidelines-file + resolver (completeness verification, documentation sync, technology guidance, conflict resolution)
3. execute tests with framework-specific optimizations validated by guidelines-file + performance + critic agents
4. analyze results through enhanced validation cluster: critic + principles + completer + testing agents
5. generate comprehensive test improvement recommendations validated by resolver + docs + time agents

PARAMETERS:
--coverage (include coverage analysis)
--create-only (only create new tests)
--fix (attempt to fix failing tests)
--focus PATTERN (test name pattern)
--quick (fast tests only)
--watch (re-run on changes)
FILES... (specific files to test)

ENHANCED_AGENT_CLUSTERS:
Primary Testing: testing (comprehensive test strategy and methodology with universal coordination)
Coverage Analysis: patterns + completer + whisper + critic + researcher
Security Testing: vulnerability-scanner + threat-modeling + compliance-checker + researcher + patterns
Performance Testing: performance + constraints + hypothesis + time + axioms
Quality & Strategy: hypothesis + explorer + principles + invariants + context
Implementation Validation: completer + docs + guidelines-file + resolver + testing
Result Analysis: critic + principles + completer + testing + performance
Coordination: All enhanced clusters work in parallel under testing agent leadership with comprehensive integration

TEST_GENERATION:
- edge cases: null, empty, boundary values
- error paths: exceptions, timeouts
- mocks for external dependencies
- follow existing test patterns

OUTPUT:
- pass/fail counts
- failure details with stack traces
- coverage percentages if requested
- new test files created
- specific fix suggestions for failuresers and runs all tests in the project.

### Test Specific File
```
/test src/utils/validator.py
```
Tests a specific file and creates tests if missing.

### Create Tests Only
```
/test --create-only src/api/
```
Creates tests for untested code without running existing tests.

### Coverage Report
```
/test --coverage
```
Runs tests with coverage analysis and detailed report.

### Fix Failing Tests
```
/test --fix
```
Attempts to fix failing tests automatically.

## Output Format

```
## Test Execution Summary

**Framework**: pytest
**Tests Run**: 156
**Passed**: 152 (97.4%)
**Failed**: 3
**Skipped**: 1
**Duration**: 4.23s

### Failed Tests

1. **test_user_authentication**
   - File: `tests/api/test_auth.py:45`
   - Error: `AssertionError: Expected 200, got 401`
   - Likely Cause: Missing test fixture for auth token
   ```python
   # Current test
   def test_user_authentication(client):
       response = client.get('/api/user')
       assert response.status_code == 200  # Fails
   
   # Fixed test
   def test_user_authentication(client, auth_headers):
       response = client.get('/api/user', headers=auth_headers)
       assert response.status_code == 200
   ```

2. **test_database_connection**
   - File: `tests/db/test_connection.py:12`
   - Error: `ConnectionError: Cannot connect to test database`
   - Fix: Ensure test database is running

### Coverage Report

**Overall Coverage**: 84.3%

#### Uncovered Critical Code
1. `src/api/payments.py` - 45% coverage
   - Missing: Error handling in process_payment()
   - Missing: Refund logic tests

2. `src/utils/encryption.py` - 67% coverage
   - Missing: Edge cases for invalid inputs
   - Missing: Performance tests for large data

### New Tests Created

Created 8 new test files:
- `tests/api/test_payments.py` (12 tests)
- `tests/utils/test_encryption_edge_cases.py` (8 tests)

### Recommendations

1. **Immediate**: Fix authentication test fixtures
2. **High Priority**: Add payment processing error tests
3. **Medium Priority**: Improve encryption edge case coverage
4. **Low Priority**: Add performance benchmarks
```

## Parameters

- `--coverage`: Include detailed coverage analysis
- `--create-only`: Only create new tests, don't run existing
- `--fix`: Attempt to fix failing tests
- `--focus <pattern>`: Only run tests matching pattern
- `--quick`: Run only fast tests (skip integration/slow tests)
- `--watch`: Run tests in watch mode (re-run on file changes)
- `--parallel`: Run tests in parallel (if supported)

## Test Generation Patterns

### Unit Test Template
```python
def test_function_name_describes_behavior():
    # Arrange
    input_data = create_test_data()
    expected = calculate_expected_result()
    
    # Act
    result = function_under_test(input_data)
    
    # Assert
    assert result == expected
```

### Edge Case Testing
- Null/None inputs
- Empty collections
- Boundary values
- Invalid types
- Concurrent access
- Resource exhaustion

### Mock/Stub Usage
```python
@patch('module.external_service')
def test_with_mock(mock_service):
    mock_service.return_value = {'status': 'success'}
    result = function_using_service()
    assert result.success
    mock_service.assert_called_once()
```

## Framework-Specific Features

### Python (pytest)
- Fixtures for reusable test setup
- Parametrized tests for multiple scenarios
- Markers for test categorization
- Coverage with pytest-cov

### JavaScript (Jest/Vitest)
- Snapshot testing for UI components
- Mock modules and timers
- Async test support
- Coverage reporting built-in

### Go
- Table-driven tests
- Benchmark tests
- Example tests for documentation
- Race condition detection

### Rust
- Doc tests in comments
- Integration tests in tests/
- Benchmark with criterion
- Property-based testing

## Memory Integration

**Before Testing**: Use `mcp__memory__search_nodes()` to check for:
- Previous test strategy decisions and outcomes
- Historical test coverage patterns and gaps
- Known testing framework optimization approaches
- Test failure patterns and resolution strategies

**After Testing**: Store findings with `mcp__memory__create_entities()` and `mcp__memory__create_relations()`:
- Test strategy effectiveness and coverage improvements
- Testing framework performance and optimization outcomes
- Test failure patterns and successful resolution approaches
- Security and performance testing insights

## Agent Integration

**Enhanced Primary Testing Integration**:

**Primary Testing Agent**: 
- **testing**: Comprehensive test strategy development with 308-line systematic methodology enhanced by universal agent coordination

**Enhanced Supporting Analysis Clusters**:
- **Coverage Analysis**: patterns + completer + whisper + critic + researcher for comprehensive gap identification with research validation
- **Security Testing**: vulnerability-scanner + threat-modeling + compliance-checker + researcher + patterns for security validation with threat intelligence
- **Performance Testing**: performance + constraints + hypothesis + time + axioms for optimization with historical analysis and fundamental principles
- **Quality & Strategy**: hypothesis + explorer + principles + invariants + context for comprehensive test quality assurance with system understanding
- **Implementation Validation**: completer + docs + guidelines-file + resolver + testing for implementation verification with documentation and conflict resolution
- **Result Analysis**: critic + principles + completer + testing + performance for comprehensive result validation with quality assurance

**Enhanced Advanced Coordination**: Testing agent orchestrates all specialized testing approaches with universal agent support while maintaining systematic methodology focus through resolver + critic + principles integration

## Related Commands

- `/review` - Review test quality and coverage with agent coordination
- `/refactor` - Improve test structure with patterns and principles agents
- `/security` - Integrate security testing with security specialist agents
- `/agent-ecosystem-review` - Analyze testing agent ecosystem effectiveness

## Best Practices

1. **Test Naming**: Use descriptive names that explain what is being tested
2. **One Assertion**: Each test should verify one specific behavior
3. **Independent Tests**: Tests should not depend on execution order
4. **Fast Tests**: Keep unit tests under 100ms each
5. **Clear Failures**: Failed tests should clearly indicate what went wrong
6. **Test Data**: Use factories or fixtures for consistent test data
7. **Coverage Goals**: Aim for 80%+ coverage, 100% for critical paths