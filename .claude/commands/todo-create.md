# /todo-create

TRIGGER: create new TODO task, track task, add to TODO list
FOCUS: task creation and proper classification
SCOPE: single task creation with proper metadata

ACTIONS:
1. invoke todo agent: create new TODO file with proper YAML frontmatter
2. classify task type (feat/fix/docs/refactor/test/chore) for semantic versioning
3. assign priority level (high/medium/low) based on urgency and impact
4. generate kebab-case filename from task description
5. create markdown file in .support/todos/ directory

PARAMETERS:
--type [feat|fix|docs|refactor|test|chore] (force specific task type)
--priority [high|medium|low] (override priority assessment)
--assignee [agent-name] (assign to specific agent)
DESCRIPTION (task description text)

AGENT_DELEGATION:
Primary: todo
Support: completer (for gap analysis if needed)

OUTPUT:
- TODO file created in .support/todos/
- Task properly classified and prioritized
- Clean confirmation without context pollution

EXAMPLE:
/todo-create --type feat --priority high "Implement user authentication with JWT tokens"

BEHAVIOR:
- Delegates ALL task management to todo agent
- Keeps main context clean and focused
- Returns only essential creation confirmation
- No TODO tracking pollution in main conversation