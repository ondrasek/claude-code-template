---
description: "Cleanup completed TODOs by removing implemented tasks with verification"
argument-hint: "[--dry-run] [--since date/tag] [--confirm-all]"
allowed-tools: ["Task", "Bash"]
model: "sonnet"
---

# TODO Cleanup - Completed

Cleanup completed TODOs by identifying and removing tasks that are already implemented, with cross-reference to CHANGELOG and codebase state.

## Instructions

1. Parse $ARGUMENTS for cleanup parameters:
   - --dry-run (show what would be cleaned up without making changes)
   - --since [date|tag] (check implementations since specific date or version)
   - --confirm-all (skip individual confirmation prompts)

2. Delegate comprehensive completion analysis to specialist-todo-manager agent with mandatory git safety protocol
1. invoke todo agent: comprehensive completion analysis with enhanced agent coordination
2. coordinate parallel completion validation:
   - **Completion Detection Cluster**: patterns + completer + researcher + context (identify implemented functionality with comprehensive validation)
   - **Documentation Cross-Reference Cluster**: docs + time + patterns + critic (cross-reference CHANGELOG entries with critical assessment)
   - **Codebase Analysis Cluster**: context + explorer + hypothesis + testing (analyze codebase for implementation evidence)
   - **Validation & Quality Cluster**: critic + principles + invariants + resolver (validate completion claims with quality assurance)
3. generate comprehensive cleanup plan validated by resolver + docs + completer agents

PARAMETERS:
--dry-run (show what would be cleaned up without making changes)
--since [date|tag] (check implementations since specific date or version)
--confirm-all (skip individual confirmation prompts)

GIT_SAFETY_PROTOCOL:
MANDATORY git verification before deletion:
1. Check `git ls-files .support/todos/` to verify TODOs are tracked
2. Ensure `git status` shows files are committed (not untracked/modified)
3. Only delete TODOs that exist in git history for full traceability
4. ABORT deletion if TODOs are not properly committed to repository

ENHANCED_AGENT_DELEGATION:
Primary: todo (comprehensive completion analysis with universal agent coordination)
Completion Detection: patterns + completer + researcher + context
Documentation Cross-Reference: docs + time + patterns + critic
Codebase Analysis: context + explorer + hypothesis + testing
Validation & Quality: critic + principles + invariants + resolver
Cleanup Coordination: resolver + docs + completer + time

ENHANCED_OUTPUT:
- Comprehensive list of TODOs identified for cleanup with validation evidence
- Git history verification before deletion (ensures TODOs are tracked in repository)
- User confirmation of findings before proceeding with deletion
- Confirmation of deleted TODOs with completion verification
- Updated CHANGELOG entries with comprehensive gap analysis and documentation
- Clean TODO directory with quality-assured active tasks and dependency validation
- Cross-reference validation ensuring no orphaned references or incomplete cleanup
- Strategic recommendations for maintaining TODO directory health

EXAMPLES:
/todo-cleanup-done --dry-run --since v1.2.0
/todo-cleanup-done --confirm-all (delete all identified completed TODOs without individual prompts)

BEHAVIOR:
- Delegates ALL cleanup analysis to todo agent
- Works autonomously to identify implemented features
- Verifies TODOs are in git history before deletion (git safety check)
- Presents findings to user for confirmation before deletion
- DELETES (not archives) confirmed TODOs - git provides history
- Provides summary of cleanup actions without individual task noise
- Ensures CHANGELOG accuracy and TODO directory hygiene