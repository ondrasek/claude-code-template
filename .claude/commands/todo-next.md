# /todo-next

TRIGGER: cleanup completed/stale TODOs and determine optimal next task
FOCUS: comprehensive TODO hygiene followed by intelligent next step analysis
SCOPE: full TODO lifecycle management with strategic task prioritization

ENHANCED_ACTIONS:
1. invoke todo agent: comprehensive cleanup and analysis with enhanced agent coordination
2. coordinate parallel cleanup operations:
   - **Completion Detection Cluster**: patterns + completer + researcher + context (identify implemented functionality)
   - **Staleness Assessment Cluster**: patterns + context + time + researcher (analyze relevance with system understanding)
   - **Documentation Cross-Reference Cluster**: docs + time + patterns + critic (cross-reference CHANGELOG entries)
   - **Validation & Quality Cluster**: critic + principles + invariants + resolver (validate cleanup claims)
3. coordinate parallel next-step analysis:
   - **Priority Intelligence Cluster**: critic + constraints + resolver + principles (validate priorities with critical assessment)
   - **Impact Analysis Cluster**: performance + completer + hypothesis + testing (assess impact with performance implications)
   - **Dependency Mapping Cluster**: explorer + connector + axioms + invariants (identify dependencies with cross-domain insights)
   - **Strategic Planning Cluster**: resolver + principles + docs + time (generate implementation strategy)
4. generate comprehensive next-step recommendations validated by resolver + principles + docs agents

PARAMETERS:
--cleanup-only (perform cleanup without next-step analysis)
--analysis-only (skip cleanup, analyze remaining TODOs only)
--dry-run (show cleanup candidates and recommendations without making changes)
--since [date|tag] (check implementations since specific date or version)
--older-than [days|weeks|months] (target stale TODOs older than timeframe)
--keep-types [types] (preserve specific task types during stale cleanup)
--priority [high|medium|low] (filter next-step analysis by priority level)
--limit N (limit number of next-step recommendations)

GIT_SAFETY_PROTOCOL:
MANDATORY git verification before deletion:
1. Check `git ls-files .support/todos/` to verify TODOs are tracked
2. Ensure `git status` shows files are committed (not untracked/modified)
3. Only delete TODOs that exist in git history for full traceability
4. ABORT deletion if TODOs are not properly committed to repository

ENHANCED_AGENT_DELEGATION:
Primary: todo (comprehensive TODO lifecycle management with universal agent coordination)
Cleanup Detection: patterns + completer + researcher + context + docs + time + critic
Next-Step Analysis: critic + constraints + resolver + principles + performance + hypothesis + testing + explorer + axioms + invariants
Strategic Coordination: resolver + principles + docs + time + completer

ENHANCED_OUTPUT:
- **Cleanup Summary**: Comprehensive list of TODOs cleaned up with validation evidence
  - Completed TODOs with implementation verification
  - Stale TODOs with obsolescence reasoning
  - Git history verification and deletion confirmation
- **Remaining TODO Analysis**: Strategic assessment of active tasks
  - Priority validation with critical evaluation
  - Dependency mapping with conflict identification
  - Impact analysis with performance considerations
- **Next Step Recommendations**: Intelligent task selection
  - Optimal next task with comprehensive justification
  - Alternative options with trade-off analysis
  - Implementation strategy with resource considerations
  - Blocking dependencies and resolution paths
- **Strategic Insights**: Long-term TODO health assessment
  - Backlog quality metrics and trend analysis
  - Resource allocation recommendations
  - Process improvement suggestions

EXAMPLES:
/todo-next --dry-run (show cleanup candidates and next-step analysis without changes)
/todo-next --since v2.38.0 --priority high (cleanup since version, analyze high-priority next steps)
/todo-next --cleanup-only --older-than 2months (only cleanup stale TODOs older than 2 months)
/todo-next --analysis-only --limit 3 (skip cleanup, show top 3 next-step recommendations)

BEHAVIOR:
- Delegates ALL cleanup and analysis to todo agent off-context
- Performs comprehensive TODO hygiene before strategic analysis
- Combines completion detection with staleness assessment
- Verifies TODOs are in git history before deletion (git safety check)
- Presents cleanup findings and next-step recommendations
- DELETES (not archives) confirmed TODOs - git provides history
- Provides strategic overview without task-by-task noise
- Maintains clean separation between cleanup and analysis phases
- Returns actionable next steps with implementation guidance