# /todo-cleanup-stale

TRIGGER: cleanup stale TODOs, remove obsolete tasks
FOCUS: identify and remove TODOs that are no longer relevant
SCOPE: evaluate TODO relevance against current project state and priorities

ACTIONS:
1. invoke todo agent: analyze all TODO files for relevance and staleness
2. check task age and last update dates against project evolution
3. validate dependencies still exist and are meaningful
4. identify TODOs superseded by project direction changes
5. remove or archive outdated tasks that no longer align with project goals

PARAMETERS:
--older-than [days|weeks|months] (target TODOs older than timeframe)
--dry-run (show what would be cleaned up without making changes)
--archive (move to archive instead of deleting)
--interactive (prompt for each stale TODO)
--keep-types [types] (preserve specific task types even if stale)

AGENT_DELEGATION:
Primary: todo
Support: critic (evaluate continued relevance and priority)
Support: explorer (assess if project direction still supports tasks)
Support: completer (check for dependency orphaning)

OUTPUT:
- List of stale TODOs identified for cleanup
- Reasoning for staleness classification
- Confirmation of which TODOs were archived/removed
- Recommendations for updating remaining TODOs

EXAMPLE:
/todo-cleanup-stale --older-than 3months --dry-run --interactive

BEHAVIOR:
- Delegates ALL staleness analysis to todo agent
- Evaluates project evolution against TODO relevance
- Provides cleanup summary without individual task examination
- Maintains TODO directory quality and project alignment