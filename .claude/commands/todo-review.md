# /todo-review

TRIGGER: review existing TODOs, prioritize tasks, analyze TODO backlog
FOCUS: task evaluation and relevance assessment
SCOPE: all pending TODOs in .support/todos/ directory

ACTIONS:
1. invoke todo agent: scan all TODO files using Glob tool
2. analyze task relevance and current priority
3. identify most actionable and high-impact tasks
4. group related tasks for batch processing
5. recommend implementation order based on dependencies

PARAMETERS:
--filter [pending|in_progress|all] (status filter, default: pending)
--priority [high|medium|low] (filter by priority level)
--type [feat|fix|docs|refactor|test|chore] (filter by task type)
--limit N (limit number of TODOs to review)
--actionable-only (show only immediately actionable tasks)

AGENT_DELEGATION:
Primary: todo
Support: completer (identify missing dependencies)
Support: critic (validate priorities and feasibility)

OUTPUT:
- Prioritized list of recommended TODOs to implement
- Task groupings for efficient batch processing
- Dependency analysis and implementation order
- Summary of backlog health and actionability

EXAMPLE:
/todo-review --filter pending --priority high --actionable-only

BEHAVIOR:
- Delegates ALL analysis to todo agent off-context
- Provides strategic overview without task-by-task noise
- Returns only essential recommendations and insights
- Maintains clean separation between review and implementation