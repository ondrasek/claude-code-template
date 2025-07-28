# Add TODO Task

Add a new task to TODO.md with proper formatting and classification.

## Usage
```
/todo-add [type] [priority] "Task description"
```

## Task Types
- `feat`: New features (MINOR version bump)
- `fix`: Bug fixes (PATCH version bump)  
- `break`: Breaking changes (MAJOR version bump)
- `docs`: Documentation updates (PATCH version bump)
- `perf`: Performance improvements (PATCH version bump)
- `refactor`: Code restructuring (PATCH version bump)
- `test`: Testing additions (PATCH version bump)
- `chore`: Maintenance tasks (PATCH version bump)

## Priority Levels
- `high`: Critical tasks that should be completed first
- `medium`: Important tasks for current milestone
- `low`: Nice-to-have tasks for future consideration

## Example
```
/todo-add feat high "Add user authentication system with JWT tokens"
```

---

I'll help you add a new TODO task to TODO.md following the established protocol.

## Process

1. **Analyze the request** using `completer` + `patterns` agents to ensure proper classification
2. **Generate task entry** with all required fields (status, type, SemVer impact, etc.)  
3. **Update TODO.md** by adding the task to the appropriate priority section
4. **Validate format** to ensure consistency with protocol standards

## Required Information

To add a TODO task, I need:
- **Task type** (feat/fix/break/docs/perf/refactor/test/chore)
- **Priority level** (high/medium/low)
- **Task description** (clear, actionable description)
- **Acceptance criteria** (specific, measurable outcomes)

## SemVer Impact Mapping

The system automatically determines SemVer impact based on task type:
- `break` → MAJOR version bump
- `feat` → MINOR version bump  
- `fix`, `docs`, `perf`, `refactor`, `test`, `chore` → PATCH version bump

This command integrates with the TODO/CHANGELOG protocol to ensure proper task tracking and version management.