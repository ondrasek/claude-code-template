# Complete TODO Task

Mark a TODO task as completed and prepare it for CHANGELOG integration.

## Usage
```
/todo-complete [task-number]
```

## Example
```
/todo-complete 3
```

---

I'll help you mark a TODO task as completed and prepare it for CHANGELOG integration.

## Process

1. **Locate the task** by number in TODO.md
2. **Update status** to "completed" with completion date
3. **Move to archive section** in TODO.md for tracking until release
4. **Validate acceptance criteria** were met using `completer` agent
5. **Prepare CHANGELOG entry** based on task type and description

## Task Completion Workflow

### Status Update
- Change status from `pending` or `in_progress` to `completed`
- Add completion date
- Mark for CHANGELOG inclusion

### Archive Process
- Move completed task to "Completed Tasks (Archive)" section
- Maintain all metadata for CHANGELOG generation
- Preserve traceability to original task

### CHANGELOG Preparation
The completed task will be formatted for CHANGELOG.md based on its type:
- `feat` → "Added" section
- `fix` → "Fixed" section  
- `break` → "Removed" or "Changed" section
- `docs` → "Changed" section
- `perf`, `refactor` → "Changed" section
- `test`, `chore` → Often excluded from user-facing changelog

## Validation

Before marking complete, the system checks:
- [ ] All acceptance criteria are met
- [ ] Any required documentation updates are complete
- [ ] Task deliverables are properly implemented
- [ ] No blocking dependencies remain

## Integration with Release Process

Completed tasks remain in the archive until the next version release, when they are:
1. Converted to CHANGELOG entries
2. Used for SemVer version calculation
3. Cleared from TODO.md archive section

This ensures proper tracking from task creation to release documentation.