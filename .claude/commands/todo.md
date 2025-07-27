# Add TODO Command

Add a new TODO item to the TODO.md file with proper formatting and priority.

## Usage
```
/todo [priority] [description]
```

## Parameters
- `priority`: High, Medium, or Low (default: Medium)
- `description`: Description of the TODO item

## Examples
```
/todo High Fix the authentication bug in user login
/todo Implement pagination for the user list
/todo Low Add unit tests for the helper functions
```

## Functionality

When invoked, this command should:

1. **Read current TODO.md** - Check existing format and numbering
2. **Determine next number** - Find the next sequential TODO number
3. **Format new entry** - Create properly formatted TODO entry
4. **Add to appropriate section** - Place in correct priority section
5. **Update file** - Write updated TODO.md with new entry

## TODO Entry Format

Each TODO should include:
- **Sequential number**: Incrementing ID for tracking
- **Title**: Brief description of the task
- **Priority**: High, Medium, or Low
- **Status**: Open, In Progress, Completed
- **Details**: Optional detailed description
- **Created date**: When the TODO was added

## Example Output

```markdown
### 3. Fix authentication bug in user login
- **Priority**: High
- **Status**: Open
- **Created**: 2025-01-27
- **Details**: Users are unable to log in after password reset. Need to investigate session handling.
```

## Integration

This command integrates with:
- **completer agent**: Scans TODO.md for incomplete items
- **docs agent**: Updates documentation when TODOs are resolved
- **Project workflow**: Centralizes task tracking

## Notes
- TODOs should be actionable and specific
- Link to relevant issues or pull requests when applicable
- Use completer agent to track and resolve TODO items
- Consider breaking large TODOs into smaller, manageable tasks