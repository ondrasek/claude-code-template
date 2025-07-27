# /test

TRIGGER: testing request
FOCUS: run tests, create tests, analyze coverage
FRAMEWORK_DETECTION: automatic (pytest, jest, go test, cargo test, etc.)

ACTIONS:
1. detect test framework from package files
2. locate test files using framework conventions
3. execute tests with appropriate command
4. if coverage requested: generate coverage report
5. if create requested: identify untested code, generate test cases
6. invoke complete agent: find missing test scenarios
7. parse results and categorize failures

PARAMETERS:
--coverage (include coverage analysis)
--create-only (only create new tests)
--fix (attempt to fix failing tests)
--focus PATTERN (test name pattern)
--quick (fast tests only)
--watch (re-run on changes)
FILES... (specific files to test)

AGENT_CHAIN:
complete -> patterns -> hypothesis

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

## Related Commands

- `/review` - Review test quality and coverage
- `/refactor` - Improve test structure
- `/debug` - Debug failing tests
- Use `complete` agent to find missing tests
- Use `patterns` agent to identify test patterns

## Best Practices

1. **Test Naming**: Use descriptive names that explain what is being tested
2. **One Assertion**: Each test should verify one specific behavior
3. **Independent Tests**: Tests should not depend on execution order
4. **Fast Tests**: Keep unit tests under 100ms each
5. **Clear Failures**: Failed tests should clearly indicate what went wrong
6. **Test Data**: Use factories or fixtures for consistent test data
7. **Coverage Goals**: Aim for 80%+ coverage, 100% for critical paths