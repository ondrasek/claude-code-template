# TODO Management System

The Claude Code template includes a powerful TODO management system that helps track progress, organize complex tasks, and ensure nothing gets overlooked during development sessions.

## What the TODO System Does

- **Tracks multi-step tasks** with clear status indicators
- **Organizes complex work** into manageable, prioritized items
- **Shows real-time progress** to both you and Claude Code
- **Prevents missed requirements** by maintaining comprehensive checklists
- **Coordinates agent workflows** with task-based organization

## When TODOs Are Used

### Automatic TODO Creation
Claude Code automatically creates TODOs for:
- **Complex multi-step requests** (3+ distinct actions)
- **Multiple simultaneous tasks** (comma-separated lists)
- **Non-trivial implementations** requiring careful planning
- **User-provided task lists** (numbered or bulleted)

### Manual TODO Usage
You can explicitly request TODO management:
```
"Create a todo list for implementing user authentication"
"Use the todo system to track this refactoring work"
"Add todos for the features we just discussed"
```

## TODO States and Workflow

### Task States
- **`pending`** - Task not yet started (default state)
- **`in_progress`** - Currently being worked on (only ONE at a time)
- **`completed`** - Task finished successfully

### Priority Levels
- **`high`** - Critical tasks, blockers, security issues
- **`medium`** - Important features, significant improvements
- **`low`** - Nice-to-haves, documentation, cleanup

### Task Management Rules
1. **One active task** - Only one task can be `in_progress` at a time
2. **Immediate updates** - Status changes in real-time as work progresses
3. **Complete immediately** - Mark tasks `completed` right after finishing
4. **Specific descriptions** - Clear, actionable task descriptions

## Example TODO Workflows

### Feature Implementation
```
User: "Add caching to the user service with Redis integration"

TODO List Created:
1. [pending/high] Research Redis caching patterns for user data
2. [pending/high] Install and configure Redis client library
3. [pending/medium] Implement cache-aside pattern in UserService
4. [pending/medium] Add cache invalidation on user updates
5. [pending/medium] Write tests for caching functionality
6. [pending/low] Update documentation with caching strategy
```

### Bug Investigation
```
User: "Fix the authentication timeout issues"

TODO List Created:
1. [pending/high] Reproduce authentication timeout behavior
2. [pending/high] Analyze JWT token expiration logic
3. [pending/medium] Check session management implementation
4. [pending/medium] Test token refresh mechanisms
5. [pending/medium] Implement fix based on findings
6. [pending/low] Add monitoring for authentication failures
```

### Code Review Process
```
User: "Review this payment processing module"

TODO List Created:
1. [pending/high] Security audit of payment handling code
2. [pending/high] Validate input sanitization and validation
3. [pending/medium] Check error handling and logging
4. [pending/medium] Review transaction rollback mechanisms
5. [pending/low] Assess code organization and patterns
6. [pending/low] Document review findings and recommendations
```

## Integration with AI Agents

### Agent-TODO Coordination
- **Before starting work** - Claude Code marks relevant TODO as `in_progress`
- **During task execution** - Agents reference TODO context for focus
- **After completion** - TODO marked `completed` with summary of work done
- **For blockers** - New TODOs created to address discovered issues

### Multi-Agent Workflows
```
Complex Feature TODO:
1. [in_progress] researcher agent - Investigate best practices
2. [pending] patterns agent - Identify code patterns to follow  
3. [pending] principles agent - Apply SOLID design principles
4. [pending] generator agent - Create implementation code
5. [pending] completer agent - Ensure all edge cases covered
6. [pending] docs agent - Update documentation
```

## TODO Commands and Usage

### Viewing TODOs
- TODOs are automatically displayed when active
- Current status shown with each task
- Progress indicators help track completion

### Manual TODO Management
```
"Add a new todo for implementing rate limiting"
"Mark the database migration todo as completed"
"Change the API documentation todo to high priority"
"Remove the obsolete caching todo from the list"
```

### TODO Queries
```
"What todos are still pending?"
"Show me the high priority todos"
"What's currently in progress?"
"Which todos are completed?"
```

## Best Practices

### Effective TODO Creation
- **Break down complex tasks** - Each TODO should be completable in one session
- **Use specific descriptions** - "Implement user login" vs "Add authentication"
- **Set appropriate priorities** - Security and blockers are always high priority
- **Group related tasks** - Keep similar work items together

### Managing TODO Lifecycle
- **Start with research** - Often begin with `researcher` agent tasks
- **One task at a time** - Complete `in_progress` tasks before starting new ones
- **Update immediately** - Don't batch status updates
- **Clean up regularly** - Remove obsolete or no-longer-relevant tasks

### Team Collaboration
- **Share TODO context** - TODOs help team members understand current work
- **Document decisions** - Use TODO descriptions to capture rationale
- **Track dependencies** - Note when tasks depend on others
- **Maintain clarity** - Keep TODO descriptions understandable to all team members

## Advanced TODO Features

### Dynamic TODO Updates
- **Task discovery** - New TODOs added when unexpected work is discovered
- **Dependency management** - Tasks blocked by other tasks are noted
- **Scope adjustments** - TODO descriptions updated as understanding evolves
- **Completion criteria** - Clear definition of what "done" means for each task

### Integration with Memory System
- **Persistent tracking** - TODO context saved to memory system
- **Cross-session continuity** - TODOs persist across Claude Code sessions
- **Pattern learning** - System learns common TODO patterns for your projects
- **Historical context** - Previous TODO completions inform new task creation

### Error Handling and Recovery
- **Blocked tasks** - TODOs remain `in_progress` if encountering blockers
- **Partial completion** - New TODOs created for remaining work
- **Recovery workflows** - Clear paths to resume interrupted work
- **Failure documentation** - TODO descriptions updated with failure reasons

## Benefits Over Ad-Hoc Task Management

### Without TODO System
- ❌ Easy to forget requirements or steps
- ❌ No visibility into progress for complex tasks
- ❌ Unclear what's been completed vs remaining
- ❌ Difficult to resume interrupted work
- ❌ No coordination between multiple agents

### With TODO System
- ✅ Comprehensive tracking of all requirements
- ✅ Clear progress indicators and status
- ✅ Organized workflow with priorities
- ✅ Easy resumption of complex work
- ✅ Coordinated multi-agent task execution

## Troubleshooting TODO Issues

### TODOs Not Created When Expected
- Check if task complexity meets auto-creation threshold
- Request explicit TODO creation: "Create a todo list for this work"
- Break down vague requests into specific actionable items

### Status Not Updating
- TODOs update automatically as Claude Code works
- Manual updates available: "Mark X todo as completed"
- Check that work is actually finished before expecting completion

### Too Many TODOs
- Focus on high priority items first
- Remove obsolete or no-longer-relevant tasks
- Break large TODOs into smaller, manageable pieces

The TODO system transforms complex development work from ad-hoc task juggling into organized, trackable workflows that ensure nothing falls through the cracks.

---

**Next Steps:**
- 🧠 Learn about the [Memory System](memory-system.md) integration
- 🤖 Explore how [AI Agents](features.md#ai-agents-20) work with TODOs
- 📚 Return to [Getting Started](getting-started.md)