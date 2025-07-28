# /todo-cleanup-done

TRIGGER: cleanup completed TODOs, remove implemented tasks
FOCUS: identify and remove TODOs that are already implemented
SCOPE: cross-reference TODOs with CHANGELOG and codebase state

ENHANCED_ACTIONS:
1. invoke todo agent: comprehensive completion analysis with enhanced agent coordination
2. coordinate parallel completion validation:
   - **Completion Detection Cluster**: patterns + completer + researcher + context (identify implemented functionality with comprehensive validation)
   - **Documentation Cross-Reference Cluster**: docs + time + patterns + critic (cross-reference CHANGELOG entries with critical assessment)
   - **Codebase Analysis Cluster**: context + explorer + hypothesis + testing (analyze codebase for implementation evidence)
   - **Validation & Quality Cluster**: critic + principles + invariants + resolver (validate completion claims with quality assurance)
3. generate comprehensive cleanup plan validated by resolver + docs + completer agents

PARAMETERS:
--dry-run (show what would be cleaned up without making changes)
--archive (move to archive instead of deleting)
--since [date|tag] (check implementations since specific date or version)
--confirm-all (skip individual confirmation prompts)

ENHANCED_AGENT_DELEGATION:
Primary: todo (comprehensive completion analysis with universal agent coordination)
Completion Detection: patterns + completer + researcher + context
Documentation Cross-Reference: docs + time + patterns + critic
Codebase Analysis: context + explorer + hypothesis + testing
Validation & Quality: critic + principles + invariants + resolver
Cleanup Coordination: resolver + docs + completer + time

ENHANCED_OUTPUT:
- Comprehensive list of TODOs identified for cleanup with validation evidence
- Confirmation of archived/removed TODOs with completion verification
- Updated CHANGELOG entries with comprehensive gap analysis and documentation
- Clean TODO directory with quality-assured active tasks and dependency validation
- Cross-reference validation ensuring no orphaned references or incomplete cleanup
- Strategic recommendations for maintaining TODO directory health

EXAMPLE:
/todo-cleanup-done --dry-run --since v1.2.0

BEHAVIOR:
- Delegates ALL cleanup analysis to todo agent
- Works autonomously to identify implemented features
- Provides summary of cleanup actions without individual task noise
- Ensures CHANGELOG accuracy and TODO directory hygiene