# /refactor

TRIGGER: refactoring request
FOCUS: structure, performance, maintainability
SCOPE: full codebase or specified files

ENHANCED_ACTIONS:
1. coordinate enhanced parallel analysis clusters for comprehensive refactoring:
   - **Pattern Analysis Cluster**: patterns + researcher + context + critic (find duplication with research validation)
   - **Architecture Quality Cluster**: principles + invariants + axioms + completer (check SOLID with design integrity)
   - **Dependency Mapping Cluster**: constraints + resolver + connector + time (map dependencies with conflict resolution)
   - **Performance Analysis Cluster**: performance + hypothesis + patterns + critic (identify optimization opportunities)
2. generate comprehensive refactoring plan validated by resolver + principles + critic agents
3. apply changes incrementally with testing + completer + docs validation at each step
4. invoke whisper agent: micro-improvements coordinated with principles + critic agents
5. invoke completer agent: verify completeness with patterns + testing validation
6. run comprehensive tests with testing + performance + security agent coordination
7. invoke docs agent: update documentation with completer + principles validation

PARAMETERS:
--pattern [extract-method|extract-class|inline|rename]
--focus [performance|readability|structure|patterns]
--safe (backward-compatible only)
--dry-run (preview changes)
--incremental (confirm each change)
--max-changes N
FILES... (specific files to refactor)

ENHANCED_AGENT_CLUSTERS:
Pattern Analysis: patterns + researcher + context + critic + time
Architecture Quality: principles + invariants + axioms + completer + resolver
Dependency Mapping: constraints + resolver + connector + time + context
Performance Analysis: performance + hypothesis + patterns + critic + constraints
Implementation Excellence: whisper + completer + invariants + guidelines-file + principles
Quality Assurance: critic + testing + performance + security + completer
Documentation: docs + guidelines-repo + completer + principles + time
Validation: explorer + resolver + axioms + testing + invariants
Coordination: All enhanced clusters execute in parallel with comprehensive systematic integration

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

**Enhanced Advanced Multi-Cluster Coordination**:

**Pattern Analysis Cluster** (patterns + researcher + context + critic + time):
- Comprehensive code pattern analysis with research validation and historical context
- Critical assessment of pattern effectiveness and evolution tracking
- Deep system understanding across entire codebase with temporal analysis

**Architecture Quality Cluster** (principles + invariants + axioms + completer + resolver):
- Architectural principle validation with design integrity and conflict resolution
- Completeness assessment ensuring no gaps in principle application
- Fundamental soundness validation with systematic resolution of conflicts

**Dependency Mapping Cluster** (constraints + resolver + connector + time + context):
- Multi-dimensional dependency analysis with cross-domain insights
- Historical dependency evolution and system context understanding
- Conflict resolution in complex dependency relationships

**Performance Analysis Cluster** (performance + hypothesis + patterns + critic + constraints):
- Performance bottleneck hypothesis generation with pattern recognition
- Critical assessment of optimization strategies within resource constraints
- Systematic performance pattern analysis and validation

**Implementation Excellence Cluster** (whisper + completer + invariants + guidelines-file + principles):
- Micro-improvements with completeness validation and principle compliance
- Type-safe refactoring with invariant preservation and guideline adherence
- Technology-specific guidance ensuring optimal principle-based implementations

**Quality Assurance Cluster** (critic + testing + performance + security + completer):
- Critical evaluation with comprehensive testing and security validation
- Performance optimization validation with gap identification
- Multi-dimensional risk assessment and quality metrics tracking

**Documentation Cluster** (docs + guidelines-repo + completer + principles + time):
- Synchronized documentation with architectural context and historical evolution
- Repository-level guideline compliance with completeness verification
- Principle-based documentation standards with temporal context

**Validation Cluster** (explorer + resolver + axioms + testing + invariants):
- Alternative approach exploration with systematic testing validation
- Fundamental principle validation with design integrity preservation
- Comprehensive conflict resolution with type-safe design assurance

**Enhanced Memory-Coordinated Integration**: Leverages historical refactoring outcomes through time + researcher + context agents for optimized decision-making with comprehensive validation by critic + principles + resolver agents

## Memory Integration

**Before Refactoring**: Use `mcp__memory__search_nodes()` to check for:
- Previous refactoring outcomes and effectiveness patterns
- Historical code quality improvements and architectural decisions
- Team-specific refactoring preferences and successful approaches
- Pattern-specific refactoring strategies and their long-term impact

**After Refactoring**: Store findings with `mcp__memory__create_entities()` and `mcp__memory__create_relations()`:
- Refactoring pattern effectiveness and code quality improvements
- Architectural decision outcomes and maintainability impact
- Team learning patterns and successful refactoring strategies
- Cross-domain relationships between refactoring and system performance

## Related Commands

- `/review` - Comprehensive code review with parallel agent clusters before refactoring
- `/test` - Ensure comprehensive test coverage with testing agent coordination
- `/security` - Security impact analysis with security specialist agents
- `/agent-ecosystem-review` - Analyze refactoring process effectiveness and agent coordination

## Best Practices

1. **Always run tests** before and after refactoring
2. **Refactor incrementally** - small, tested changes
3. **Preserve behavior** - refactoring shouldn't change functionality
4. **Document changes** - especially breaking changes
5. **Use version control** - commit before major refactoring
6. **Measure impact** - track complexity metrics
7. **Get review** - have changes reviewed by team