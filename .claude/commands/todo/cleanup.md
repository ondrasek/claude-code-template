---
description: Cleanup TODOs by removing completed tasks and stale obsolete items.
argument-hint: [--done] [--stale] [--dry-run] [--since date/tag] [--older-than timeframe] [--confirm-all] [--interactive] [--keep-types types]
allowed-tools: Task, Bash
---

# TODO Cleanup

Comprehensive TODO cleanup that removes both completed tasks (already implemented) and stale tasks (no longer relevant), with intelligent analysis and git safety protocols.

## Instructions

1. Parse $ARGUMENTS for cleanup mode and parameters:
   - **Mode Selection**: --done (cleanup completed), --stale (cleanup obsolete), or both if neither specified
   - **Completion Parameters**: --since [date|tag] (check implementations since specific date or version)
   - **Staleness Parameters**: --older-than [days|weeks|months] (target TODOs older than timeframe), --keep-types [types] (preserve specific task types)
   - **Operation Mode**: --dry-run (show what would be cleaned up without making changes)
   - **Interaction**: --confirm-all (skip individual confirmation prompts), --interactive (prompt for each item)

2. Delegate comprehensive cleanup analysis to specialist-todo-manager agent with mandatory git safety protocol

### Completion Detection (--done mode)
1. invoke todo agent: comprehensive completion analysis with enhanced agent coordination
2. coordinate parallel completion validation:
   - **Completion Detection Cluster**: patterns + completer + researcher + context (identify implemented functionality with comprehensive validation)
   - **Documentation Cross-Reference Cluster**: docs + time + patterns + critic (cross-reference CHANGELOG entries with critical assessment)
   - **Codebase Analysis Cluster**: context + explorer + hypothesis + testing (analyze codebase for implementation evidence)
   - **Validation & Quality Cluster**: critic + principles + invariants + resolver (validate completion claims with quality assurance)

### Staleness Assessment (--stale mode)
1. invoke todo agent: comprehensive staleness analysis with enhanced agent coordination
2. coordinate parallel staleness assessment:
   - **Relevance Analysis Cluster**: patterns + context + time + researcher (analyze relevance with system understanding and historical evolution)
   - **Dependency Validation Cluster**: constraints + resolver + explorer + invariants (validate dependencies with conflict resolution and design integrity)
   - **Project Alignment Cluster**: axioms + principles + critic + docs (assess alignment with fundamental principles and critical evaluation)
   - **Evolution Assessment Cluster**: time + hypothesis + completer + performance (evaluate project evolution impact with completion analysis)

3. generate comprehensive cleanup plan validated by resolver + docs + completer agents

## Parameters

**Mode Selection:**
- --done (cleanup only completed tasks)
- --stale (cleanup only stale tasks)
- [default: both done and stale]

**Completion Parameters:**
- --since [date|tag] (check implementations since specific date or version)

**Staleness Parameters:**
- --older-than [days|weeks|months] (target TODOs older than timeframe)
- --keep-types [types] (preserve specific task types even if stale)

**Operation Mode:**
- --dry-run (show what would be cleaned up without making changes)

**Interaction:**
- --confirm-all (skip individual confirmation prompts)
- --interactive (prompt for each stale TODO)

## Git Safety Protocol

MANDATORY git verification before deletion:
1. Check `git ls-files .support/todos/` to verify TODOs are tracked
2. Ensure `git status` shows files are committed (not untracked/modified)
3. Only delete TODOs that exist in git history for full traceability
4. ABORT deletion if TODOs are not properly committed to repository

## Enhanced Agent Delegation

**Primary:** todo (comprehensive cleanup analysis with universal agent coordination)

**Completion Detection:** patterns + completer + researcher + context
**Documentation Cross-Reference:** docs + time + patterns + critic
**Codebase Analysis:** context + explorer + hypothesis + testing
**Validation & Quality:** critic + principles + invariants + resolver

**Relevance Analysis:** patterns + context + time + researcher
**Dependency Validation:** constraints + resolver + explorer + invariants
**Project Alignment:** axioms + principles + critic + docs
**Evolution Assessment:** time + hypothesis + completer + performance

**Strategic Cleanup:** resolver + critic + principles + completer

## Enhanced Output

- Comprehensive list of TODOs identified for cleanup with validation evidence
- Detailed reasoning for completion/staleness with evidence-based analysis
- Git history verification before deletion (ensures TODOs are tracked in repository)
- User confirmation of findings before proceeding with deletion
- Confirmation of deleted TODOs with completion/dependency verification
- Updated CHANGELOG entries with comprehensive gap analysis and documentation
- Clean TODO directory with quality-assured active tasks and dependency validation
- Cross-reference validation ensuring no orphaned references or incomplete cleanup
- Strategic recommendations for maintaining TODO directory health

## Examples

```bash
# Cleanup both completed and stale TODOs (default mode)
/todo/cleanup --dry-run

# Cleanup only completed TODOs since version 1.2.0
/todo/cleanup --done --since v1.2.0 --confirm-all

# Cleanup only stale TODOs older than 3 months, but preserve security/testing tasks
/todo/cleanup --stale --older-than 3months --keep-types security,testing --interactive

# Combined cleanup with custom parameters
/todo/cleanup --since v1.1.0 --older-than 2months --dry-run
```

## Behavior

- Delegates ALL cleanup analysis to todo agent with appropriate mode selection
- Works autonomously to identify implemented features and obsolete tasks
- Verifies TODOs are in git history before deletion (git safety check)
- Presents findings to user for confirmation before deletion
- DELETES (not archives) confirmed TODOs - git provides history
- Provides comprehensive summary of cleanup actions without individual task noise
- Ensures CHANGELOG accuracy and TODO directory hygiene
- Maintains project alignment and TODO relevance