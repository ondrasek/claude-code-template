# /todo-cleanup-done

TRIGGER: cleanup completed TODOs, remove implemented tasks
FOCUS: identify and remove TODOs that are already implemented
SCOPE: cross-reference TODOs with CHANGELOG and codebase state

ACTIONS:
1. invoke todo agent: scan all TODO files for completed or obsoleted tasks
2. cross-reference with CHANGELOG.md entries to find implemented features
3. analyze codebase using patterns agent to identify implemented functionality
4. archive or remove TODOs that match completed CHANGELOG entries
5. update CHANGELOG if TODOs were completed but not documented

PARAMETERS:
--dry-run (show what would be cleaned up without making changes)
--archive (move to archive instead of deleting)
--since [date|tag] (check implementations since specific date or version)
--confirm-all (skip individual confirmation prompts)

AGENT_DELEGATION:
Primary: todo
Support: patterns (scan codebase for implemented features)
Support: docs (update CHANGELOG if needed)
Support: completer (ensure no orphaned references)

OUTPUT:
- List of TODOs identified for cleanup
- Confirmation of which TODOs were archived/removed
- Updated CHANGELOG entries if documentation gaps found
- Clean TODO directory with only relevant active tasks

EXAMPLE:
/todo-cleanup-done --dry-run --since v1.2.0

BEHAVIOR:
- Delegates ALL cleanup analysis to todo agent
- Works autonomously to identify implemented features
- Provides summary of cleanup actions without individual task noise
- Ensures CHANGELOG accuracy and TODO directory hygiene