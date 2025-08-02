---
description: "Cleanup stale TODOs by removing obsolete tasks no longer relevant to project"
argument-hint: "[--older-than timeframe] [--dry-run] [--interactive] [--keep-types types]"
allowed-tools: ["Task", "Bash"]
model: "sonnet"
---

# TODO Cleanup - Stale

Cleanup stale TODOs by identifying and removing tasks that are no longer relevant, evaluated against current project state and priorities.

## Instructions

1. Parse $ARGUMENTS for staleness cleanup parameters:
   - --older-than [days|weeks|months] (target TODOs older than timeframe)
   - --dry-run (show what would be cleaned up without making changes)
   - --interactive (prompt for each stale TODO)
   - --keep-types [types] (preserve specific task types even if stale)

2. Delegate comprehensive staleness analysis to specialist-todo-manager agent with mandatory git safety protocol
1. invoke todo agent: comprehensive staleness analysis with enhanced agent coordination
2. coordinate parallel staleness assessment:
   - **Relevance Analysis Cluster**: patterns + context + time + researcher (analyze relevance with system understanding and historical evolution)
   - **Dependency Validation Cluster**: constraints + resolver + explorer + invariants (validate dependencies with conflict resolution and design integrity)
   - **Project Alignment Cluster**: axioms + principles + critic + docs (assess alignment with fundamental principles and critical evaluation)
   - **Evolution Assessment Cluster**: time + hypothesis + completer + performance (evaluate project evolution impact with completion analysis)
3. generate comprehensive cleanup strategy validated by resolver + critic + principles agents

PARAMETERS:
--older-than [days|weeks|months] (target TODOs older than timeframe)
--dry-run (show what would be cleaned up without making changes)
--interactive (prompt for each stale TODO)
--keep-types [types] (preserve specific task types even if stale)

GIT_SAFETY_PROTOCOL:
MANDATORY git verification before deletion:
1. Check `git ls-files .support/todos/` to verify TODOs are tracked
2. Ensure `git status` shows files are committed (not untracked/modified)
3. Only delete TODOs that exist in git history for full traceability
4. ABORT deletion if TODOs are not properly committed to repository

ENHANCED_AGENT_DELEGATION:
Primary: todo (comprehensive staleness analysis with universal agent coordination)
Relevance Analysis: patterns + context + time + researcher
Dependency Validation: constraints + resolver + explorer + invariants
Project Alignment: axioms + principles + critic + docs
Evolution Assessment: time + hypothesis + completer + performance
Strategic Cleanup: resolver + critic + principles + completer

ENHANCED_OUTPUT:
- Comprehensive list of stale TODOs with multi-agent validated classification
- Detailed reasoning for staleness with evidence-based analysis and historical context
- Git history verification before deletion (ensures TODOs are tracked in repository)
- User confirmation of findings before proceeding with deletion
- Confirmation of deleted TODOs with dependency impact assessment
- Strategic recommendations for updating remaining TODOs with alignment validation
- Project evolution impact analysis and future relevance predictions
- Quality assurance ensuring no valuable tasks are incorrectly classified as stale

EXAMPLES:
/todo-cleanup-stale --older-than 3months --dry-run --interactive
/todo-cleanup-stale --keep-types security,testing (delete stale TODOs but preserve security and testing tasks)

BEHAVIOR:
- Delegates ALL staleness analysis to todo agent
- Evaluates project evolution against TODO relevance
- Verifies TODOs are in git history before deletion (git safety check)
- Presents findings to user for confirmation before deletion
- DELETES (not archives) confirmed TODOs - git provides history
- Provides cleanup summary without individual task examination
- Maintains TODO directory quality and project alignment