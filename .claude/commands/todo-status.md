# Update TODO Task Status

Update the status of an existing TODO task with proper tracking.

## Usage
```
/todo-status [task-number] [new-status]
```

## Available Statuses
- `pending`: Task created, not started
- `in_progress`: Actively being worked on
- `completed`: Task finished and verified
- `blocked`: Cannot proceed due to dependencies
- `cancelled`: Task no longer needed

## Examples
```
/todo-status 2 in_progress
/todo-status 5 blocked
/todo-status 1 completed
```

---

I'll help you update the status of a TODO task with proper tracking and validation.

## Process

1. **Locate the task** by number in TODO.md
2. **Validate status transition** using `completer` agent
3. **Update task entry** with new status and timestamp
4. **Check dependencies** if moving to completed status
5. **Update related tasks** if status change affects dependencies

## Status Lifecycle Validation

### Valid Transitions
- `pending` → `in_progress`, `blocked`, `cancelled`
- `in_progress` → `completed`, `blocked`, `pending`
- `blocked` → `pending`, `in_progress`, `cancelled`
- `completed` → (no transitions - use archive process)
- `cancelled` → (no transitions - task closed)

### Automatic Checks
When updating status, the system validates:
- [ ] Status transition is valid
- [ ] Dependencies are satisfied (for completed status)
- [ ] Acceptance criteria are met (for completed status)
- [ ] No conflicts with other task statuses

## Status-Specific Actions

### `in_progress`
- Add timestamp when work began
- Check for resource conflicts with other in_progress tasks
- Validate assignee availability

### `completed`
- Verify all acceptance criteria met
- Check dependencies are satisfied
- Move to archive section automatically
- Prepare for CHANGELOG inclusion

### `blocked`
- Document blocking reason
- Identify resolution requirements
- Update dependent tasks if necessary

### `cancelled`
- Document cancellation reason
- Update dependent tasks
- Remove from version planning

## Dependency Management

When updating task status, the system:
1. **Checks dependent tasks** for impact
2. **Updates blocking relationships** automatically
3. **Notifies about cascade effects** on other tasks
4. **Maintains task graph integrity**

## Integration with Workflow

Status updates integrate with:
- **Agent assignments**: Notify assigned agents of status changes
- **Version planning**: Update release timeline based on task progress
- **CHANGELOG preparation**: Track completion for release documentation
- **Dependency resolution**: Unblock dependent tasks when appropriate

This command ensures accurate task tracking throughout the development lifecycle with proper validation and dependency management.