# TODO/CHANGELOG Protocol with Semantic Versioning

This document defines the comprehensive protocol for managing persistent TODO items and automatic changelog generation with semantic versioning in Claude Code.

## Overview

The TODO/CHANGELOG protocol ensures systematic tracking of development tasks and automatic documentation of changes with proper semantic versioning. It integrates with Claude Code's agent system to provide seamless workflow from task creation to release documentation.

## 1. TODO.md Management Protocol

### Structure and Format

```markdown
# TODO: [Primary Focus Title]

## Overview
Brief description of the primary focus area and context.

## High Priority Tasks

### [Task Number]. [Task Title]
**Status**: [pending|in_progress|completed|blocked|cancelled]
**Type**: [feat|fix|break|docs|perf|refactor|test|chore]
**SemVer Impact**: [major|minor|patch]
**Assigned**: [agent-name or human]
**Dependencies**: [task-ids or external requirements]
**Description**: Detailed task description
**Acceptance Criteria**:
- [ ] Criterion 1
- [ ] Criterion 2

## Medium Priority Tasks
[Same format as High Priority]

## Low Priority Tasks
[Same format as High Priority]

## Completed Tasks (Archive)
[Completed tasks for reference - cleared on version release]
```

### Task Types and SemVer Mapping

| Task Type | Description | SemVer Impact | Examples |
|-----------|-------------|---------------|----------|
| `feat` | New features | MINOR | New agents, commands, capabilities |
| `fix` | Bug fixes | PATCH | Error corrections, typo fixes |
| `break` | Breaking changes | MAJOR | Removing features, incompatible changes |
| `docs` | Documentation | PATCH | README updates, new documentation |
| `perf` | Performance improvements | PATCH | Optimization, efficiency gains |
| `refactor` | Code restructuring | PATCH | Internal improvements, cleanup |
| `test` | Testing additions | PATCH | Unit tests, integration tests |
| `chore` | Maintenance | PATCH | Dependencies, build scripts |

### Status Lifecycle

1. **pending** → Task created, not started
2. **in_progress** → Actively being worked on
3. **completed** → Task finished and verified
4. **blocked** → Cannot proceed due to dependencies
5. **cancelled** → Task no longer needed

### Persistent TODO Management Rules

1. **Single Source of Truth**: TODO.md is the authoritative task list
2. **Atomic Tasks**: Each task should be independently completable
3. **Clear Ownership**: Every task has a clear assignee (agent or human)
4. **Version Scoping**: Tasks are scoped to version milestones
5. **Dependency Tracking**: Clear identification of task dependencies

## 2. CHANGELOG.md Integration Protocol

### Automatic CHANGELOG Generation

When TODOs are completed, they automatically generate CHANGELOG entries:

```markdown
## [Unreleased]

### Added (from feat tasks)
- New feature descriptions

### Changed (from refactor tasks that modify behavior)
- Modified behavior descriptions

### Fixed (from fix tasks)
- Bug fix descriptions

### Removed (from break tasks that remove features)
- Removed feature descriptions

### Security (from security-related tasks)
- Security improvement descriptions

### Deprecated (from tasks that deprecate features)
- Deprecated feature descriptions
```

### CHANGELOG Entry Format

Each completed TODO generates a CHANGELOG entry following this pattern:

```
- [Task Title]: Brief description of what was accomplished
  - Details about implementation or impact
  - Reference to TODO task ID for traceability
```

## 3. Semantic Version Detection Protocol

### Automatic Version Bump Detection

The system automatically determines version bumps based on completed TODOs:

```
MAJOR (x.0.0): Any completed `break` type tasks
MINOR (0.x.0): Any completed `feat` type tasks (if no MAJOR)
PATCH (0.0.x): Only `fix`, `docs`, `perf`, `refactor`, `test`, `chore` tasks
```

### Version Calculation Algorithm

1. Scan all completed TODOs since last release
2. Identify highest impact type:
   - If any `break` → MAJOR
   - Else if any `feat` → MINOR  
   - Else → PATCH
3. Generate new version number
4. Create CHANGELOG section with date
5. Archive completed TODOs

### Pre-release Versioning

For development versions:
- Alpha: `1.0.0-alpha.1` (early development)
- Beta: `1.0.0-beta.1` (feature complete, testing)
- RC: `1.0.0-rc.1` (release candidate)

## 4. Complete Workflow Protocol

### Phase 1: TODO Creation

When users request changes:

1. **Agent Analysis**: `researcher` + `patterns` + `completer` analyze request
2. **Task Decomposition**: Break request into atomic TODO items
3. **Type Classification**: Assign `feat`/`fix`/`break` types
4. **Priority Assignment**: High/Medium/Low based on impact
5. **TODO.md Update**: Add tasks with proper formatting

### Phase 2: Implementation

For each TODO task:

1. **Status Update**: Mark as `in_progress`
2. **Implementation**: Complete the actual work
3. **Validation**: Verify acceptance criteria met
4. **Status Update**: Mark as `completed`
5. **Documentation**: Update related docs if needed

### Phase 3: Release Preparation

When ready for release:

1. **Version Calculation**: Analyze completed TODOs for SemVer impact
2. **CHANGELOG Generation**: Convert completed TODOs to CHANGELOG entries
3. **Archive Cleanup**: Move completed TODOs to archive section
4. **Version Commit**: Create version bump commit
5. **Tag Creation**: Create annotated git tag

### Phase 4: Release Execution

Following trunk-based development:

1. **Final Commit**: Ensure all changes committed to main
2. **Version Tag**: Create `git tag -a v1.2.3 -m "Release version 1.2.3"`
3. **Push Release**: `git push origin main && git push origin v1.2.3`
4. **TODO Reset**: Clear completed tasks, prepare for next cycle

## 5. Documentation Standards

### TODO.md Format Standards

```markdown
# Required Structure
- Primary focus title
- Overview section
- Priority-based organization
- Consistent task formatting
- Status tracking
- Type classification

# Task Entry Template
### [Number]. [Title]
**Status**: [status]
**Type**: [type]
**SemVer Impact**: [impact]
**Assigned**: [assignee]
**Dependencies**: [dependencies]
**Description**: [description]
**Acceptance Criteria**:
- [ ] [criterion]
```

### CHANGELOG.md Format Standards

```markdown
# Required Structure
- Keep a Changelog format compliance
- Semantic versioning references
- Clear section organization
- Consistent entry formatting
- Traceability to TODO tasks

# Entry Template
- [Brief description]: [Detailed explanation]
  - Additional context if needed
  - TODO reference: #task-id
```

## 6. Agent Integration Protocol

### Specialized Agent Roles

- **`completer`**: Identifies missing TODOs, validates completeness
- **`docs`**: Updates documentation when TODOs affect docs
- **`patterns`**: Ensures TODO format consistency
- **`researcher`**: Gathers context for TODO creation
- **`critic`**: Validates TODO priorities and classifications

### Agent Workflow Integration

```
User Request → Agent Analysis → TODO Creation → Implementation → CHANGELOG Update → Release
      ↓              ↓              ↓              ↓              ↓            ↓
   researcher    completer      patterns       assigned      docs       versioning
   + patterns    + critic       + docs         agent(s)      agent      automation
```

## 7. Quality Assurance Protocol

### TODO Quality Checklist

- [ ] Task is atomic and independently completable
- [ ] Type correctly classified for SemVer impact
- [ ] Priority reflects actual urgency/importance
- [ ] Acceptance criteria are specific and measurable
- [ ] Dependencies are clearly identified
- [ ] Assignee is appropriate for task type

### CHANGELOG Quality Checklist

- [ ] Entries follow Keep a Changelog format
- [ ] Version numbers follow SemVer correctly
- [ ] All completed TODOs are represented
- [ ] Descriptions are user-facing and clear
- [ ] Breaking changes are clearly marked
- [ ] Traceability to original TODOs maintained

## 8. Commands and Automation

### Proposed New Commands

```bash
/todo-add [type] [priority] "Task description"
/todo-status [task-id] [new-status]  
/todo-complete [task-id]
/version-prepare [major|minor|patch]
/changelog-generate
/release-create [version]
```

### Integration with Existing Commands

- `/review` → Can identify new TODOs during code review
- `/refactor` → Creates refactor-type TODOs
- `/test` → Creates test-type TODOs
- `/security` → Creates security-related TODOs

## 9. Success Metrics

### Measurable Outcomes

1. **Consistency**: All changes properly tracked in TODO → CHANGELOG flow
2. **Accuracy**: Version bumps correctly reflect change impact
3. **Completeness**: No orphaned or undocumented changes
4. **Traceability**: Clear path from user request to release documentation
5. **Automation**: Minimal manual intervention required

### Quality Indicators

- Zero discrepancies between TODO completion and CHANGELOG entries
- Correct SemVer version bumps based on change types
- Complete task coverage for all user requests
- Consistent formatting across all documentation
- Successful integration with existing Claude Code workflows

This protocol ensures systematic, automated, and accurate tracking of all development work with proper semantic versioning and comprehensive documentation.