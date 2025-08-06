---
description: Cleanup GitHub Issues by closing completed tasks and stale obsolete items.
argument-hint: No arguments needed - automatically cleans completed and stale issues.
allowed-tools: Task, Bash
---

# GitHub Issue Cleanup

Comprehensive GitHub Issue cleanup that closes both completed tasks (already implemented) and stale tasks (no longer relevant), with intelligent analysis and GitHub safety protocols.

## Instructions

1. Parse $ARGUMENTS for cleanup mode and parameters:
   - **Mode Selection**: --done (cleanup completed), --stale (cleanup obsolete), or both if neither specified
   - **Completion Parameters**: --since [date|tag] (check implementations since specific date or version)
   - **Staleness Parameters**: --older-than [days|weeks|months] (target issues older than timeframe), --keep-types [types] (preserve specific task types)
   - **Operation Mode**: --dry-run (show what would be cleaned up without making changes)
   - **Interaction**: --confirm-all (skip individual confirmation prompts), --interactive (prompt for each item)

2. Delegate comprehensive cleanup analysis to specs-analyst agent with mandatory GitHub safety protocol

### Completion Detection (--done mode)
1. invoke specs-analyst agent: comprehensive completion analysis with enhanced agent coordination
2. coordinate parallel completion validation:
   - **Completion Detection Cluster**: patterns + completer + researcher + context (identify implemented functionality with comprehensive validation)
   - **Documentation Cross-Reference Cluster**: docs + time + patterns + critic (cross-reference CHANGELOG entries with critical assessment)
   - **Codebase Analysis Cluster**: context + explorer + hypothesis + testing (analyze codebase for implementation evidence)
   - **Validation & Quality Cluster**: critic + principles + invariants + resolver (validate completion claims with quality assurance)

### Staleness Assessment (--stale mode)
1. invoke specs-analyst agent: comprehensive staleness analysis with enhanced agent coordination
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
- --older-than [days|weeks|months] (target issues older than timeframe)
- --keep-types [types] (preserve specific task types even if stale)

**Operation Mode:**
- --dry-run (show what would be cleaned up without making changes)

**Interaction:**
- --confirm-all (skip individual confirmation prompts)
- --interactive (prompt for each stale issue)

## GitHub Safety Protocol

MANDATORY GitHub verification before closure:
1. Check `gh issue list` to verify issues exist and status
2. Ensure issues are properly labeled before closure
3. Only close issues that have been verified as completed or obsolete
4. Use GitHub labels for tracking closure reasons (completed vs stale)

## Enhanced Agent Delegation

**Primary:** specs-analyst (comprehensive cleanup analysis with universal agent coordination)

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

- Comprehensive list of issues identified for cleanup with validation evidence
- Detailed reasoning for completion/staleness with evidence-based analysis
- GitHub issue verification before closure (ensures issues exist and are properly managed)
- User confirmation of findings before proceeding with closure
- Confirmation of closed issues with completion/dependency verification
- Updated CHANGELOG entries with comprehensive gap analysis and documentation
- Clean GitHub issue tracker with quality-assured active tasks and dependency validation
- Cross-reference validation ensuring no orphaned references or incomplete cleanup
- Strategic recommendations for maintaining issue tracker health

## Examples

```bash
# Cleanup both completed and stale issues (default mode)
/issue cleanup --dry-run

# Cleanup only completed issues since version 1.2.0
/issue cleanup --done --since v1.2.0 --confirm-all

# Cleanup only stale issues older than 3 months, but preserve security/testing tasks
/issue cleanup --stale --older-than 3months --keep-types security,testing --interactive

# Combined cleanup with custom parameters
/issue cleanup --since v1.1.0 --older-than 2months --dry-run
```

## Behavior

- Delegates ALL cleanup analysis to specs-analyst agent with appropriate mode selection
- Works autonomously to identify implemented features and obsolete tasks
- Verifies issues exist in GitHub before closure (GitHub safety check)
- Presents findings to user for confirmation before closure
- CLOSES (not archives) confirmed issues - GitHub provides history
- Provides comprehensive summary of cleanup actions without individual task noise
- Ensures CHANGELOG accuracy and GitHub issue tracker hygiene
- Maintains project alignment and issue relevance