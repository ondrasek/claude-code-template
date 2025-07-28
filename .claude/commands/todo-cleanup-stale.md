# /todo-cleanup-stale

TRIGGER: cleanup stale TODOs, remove obsolete tasks
FOCUS: identify and remove TODOs that are no longer relevant
SCOPE: evaluate TODO relevance against current project state and priorities

ENHANCED_ACTIONS:
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
--archive (move to archive instead of deleting)
--interactive (prompt for each stale TODO)
--keep-types [types] (preserve specific task types even if stale)

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
- Confirmation of archived/removed TODOs with dependency impact assessment
- Strategic recommendations for updating remaining TODOs with alignment validation
- Project evolution impact analysis and future relevance predictions
- Quality assurance ensuring no valuable tasks are incorrectly classified as stale

EXAMPLE:
/todo-cleanup-stale --older-than 3months --dry-run --interactive

BEHAVIOR:
- Delegates ALL staleness analysis to todo agent
- Evaluates project evolution against TODO relevance
- Provides cleanup summary without individual task examination
- Maintains TODO directory quality and project alignment