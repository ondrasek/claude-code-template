# /refactor

TRIGGER: refactoring request
FOCUS: structure, performance, maintainability
SCOPE: full codebase or specified files

ACTIONS:
1. invoke patterns agent: find duplication
2. invoke principles agent: check SOLID
3. invoke constraints agent: map dependencies
4. generate refactoring plan
5. apply changes incrementally
6. invoke whisper agent: micro-improvements
7. invoke complete agent: verify completeness
8. run tests to validate
9. invoke docsync agent: update docs

PARAMETERS:
--pattern [extract-method|extract-class|inline|rename]
--focus [performance|readability|structure|patterns]
--safe (backward-compatible only)
--dry-run (preview changes)
--incremental (confirm each change)
--max-changes N
FILES... (specific files to refactor)

AGENT_SEQUENCE:
patterns -> principles -> constraints -> hypothesis -> whisper -> complete -> docsync -> critic

REFACTORING_PATTERNS:
- extract method/class
- replace conditional with polymorphism
- introduce parameter object
- remove duplication
- simplify complex conditionals

OUTPUT:
- refactoring opportunities count
- complexity reduction estimate
- specific changes by category
- breaking changes warnings
- phased implementation plan

```
## Refactoring Analysis Report

**Files Analyzed**: 23
**Refactoring Opportunities**: 47
**Estimated Improvement**: 35% reduction in complexity

### Pattern Detection (patterns agent)

1. **Duplicate Authentication Logic**
   - Found in: 5 files
   - Lines saved: ~120
   - Recommendation: Extract to AuthenticationService
   ```python
   # Before (repeated in 5 places)
   def verify_user(token):
       decoded = jwt.decode(token, SECRET)
       user = db.get_user(decoded['id'])
       if not user or not user.active:
           raise AuthError()
       return user
   
   # After (single implementation)
   class AuthenticationService:
       def verify_user(self, token: str) -> User:
           # Centralized implementation
   ```

2. **Data Validation Pattern**
   - Found in: 8 endpoints
   - Recommendation: Use decorator pattern

### SOLID Violations (principles agent)

1. **Single Responsibility Violation**
   - File: `src/services/user_service.py`
   - Issue: UserService handles auth, data, and email
   - Fix: Split into UserService, AuthService, EmailService

2. **Open/Closed Violation**
   - File: `src/processors/data_processor.py`
   - Issue: Switch statement for types
   - Fix: Use strategy pattern

### Performance Improvements (hypothesis agent)

1. **N+1 Query Problem**
   - Location: `src/api/list_users.py`
   - Impact: 100+ DB queries per request
   - Solution: Use eager loading
   ```python
   # Before
   users = User.query.all()
   for user in users:
       user.profile  # Triggers query
   
   # After
   users = User.query.options(joinedload('profile')).all()
   ```

### Micro-Improvements Applied (whisper agent)

- Renamed 47 variables for clarity
- Added type hints to 23 functions
- Removed 12 unused imports
- Fixed 18 inconsistent indentations
- Simplified 9 boolean expressions

### Refactoring Plan

1. **Phase 1**: Extract shared authentication (2 hours)
2. **Phase 2**: Implement service layer pattern (4 hours)
3. **Phase 3**: Optimize database queries (2 hours)
4. **Phase 4**: Apply micro-improvements (1 hour)

### Breaking Changes

⚠️ **API Changes Required**:
- `UserService.authenticate()` → `AuthService.authenticate()`
- Database schema migration needed for query optimization
```

## Parameters

- `--pattern <type>`: Apply specific refactoring pattern
  - `extract-method`, `extract-class`, `inline`, `rename`
- `--focus <area>`: Focus on specific aspect
  - `performance`, `readability`, `structure`, `patterns`
- `--safe`: Only backward-compatible changes
- `--dry-run`: Show what would be changed without applying
- `--incremental`: Apply changes one at a time with confirmation
- `--max-changes <n>`: Limit number of changes

## Refactoring Patterns Library

### Extract Method
```python
# Before
def process_order(order):
    # 50 lines of validation logic
    # 30 lines of calculation logic
    # 20 lines of notification logic

# After
def process_order(order):
    validate_order(order)
    total = calculate_total(order)
    send_notifications(order, total)
```

### Replace Conditional with Polymorphism
```python
# Before
if shape_type == "circle":
    area = 3.14 * radius ** 2
elif shape_type == "square":
    area = side ** 2

# After
class Shape(ABC):
    @abstractmethod
    def area(self): pass

class Circle(Shape):
    def area(self):
        return 3.14 * self.radius ** 2
```

### Introduce Parameter Object
```python
# Before
def create_user(name, email, age, address, phone):
    # ...

# After
@dataclass
class UserData:
    name: str
    email: str
    age: int
    address: str
    phone: str

def create_user(user_data: UserData):
    # ...
```

## Agent Integration

The command automatically invokes:
- **patterns agent**: Find duplication (runs first)
- **principles agent**: Verify SOLID principles
- **constraints agent**: Understand dependencies
- **whisper agent**: Apply micro-improvements
- **complete agent**: Ensure nothing missed
- **hypothesis agent**: For performance analysis
- **docsync agent**: Update documentation
- **critic agent**: Validate proposed changes

## Related Commands

- `/review` - Review code before refactoring
- `/test` - Ensure tests pass after refactoring
- `/security` - Check security implications
- Use `meta` agent for generating refactoring tools
- Use `resolve` agent when patterns conflict

## Best Practices

1. **Always run tests** before and after refactoring
2. **Refactor incrementally** - small, tested changes
3. **Preserve behavior** - refactoring shouldn't change functionality
4. **Document changes** - especially breaking changes
5. **Use version control** - commit before major refactoring
6. **Measure impact** - track complexity metrics
7. **Get review** - have changes reviewed by team