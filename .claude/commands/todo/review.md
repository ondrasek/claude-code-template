---
description: Review existing TODOs, prioritize tasks, and analyze TODO backlog for strategic planning.
argument-hint: No arguments needed - automatically reviews and prioritizes all TODOs.
allowed-tools: Task
---

# TODO Review

Review existing TODOs, prioritize tasks, and analyze TODO backlog for task evaluation and relevance assessment across all pending TODOs in .support/todos/ directory.

## Instructions

1. Parse $ARGUMENTS for review parameters:
   - --filter [pending|in_progress|all] (status filter, default: pending)
   - --priority [high|medium|low] (filter by priority level)
   - --type [feat|fix|docs|refactor|test|chore] (filter by task type)
   - --limit N (limit number of TODOs to review)
   - --actionable-only (show only immediately actionable tasks)

2. Delegate comprehensive TODO analysis to specialist-todo-manager agent with enhanced coordination
1. invoke todo agent: comprehensive TODO analysis with enhanced agent coordination
2. coordinate parallel review analysis:
   - **Relevance Assessment Cluster**: patterns + context + time + researcher (analyze relevance with system understanding and historical context)
   - **Priority Validation Cluster**: critic + constraints + resolver (validate priorities with critical assessment and conflict resolution)
   - **Impact Analysis Cluster**: performance + completer + hypothesis (assess impact with performance implications and completion analysis)
   - **Dependency Mapping Cluster**: explorer + connector + axioms (identify dependencies with cross-domain insights)
3. generate comprehensive implementation strategy validated by resolver + principles + docs agents

PARAMETERS:
--filter [pending|in_progress|all] (status filter, default: pending)
--priority [high|medium|low] (filter by priority level)
--type [feat|fix|docs|refactor|test|chore] (filter by task type)
--limit N (limit number of TODOs to review)
--actionable-only (show only immediately actionable tasks)

ENHANCED_AGENT_DELEGATION:
Primary: todo (comprehensive TODO analysis with universal agent coordination)
Relevance Assessment: patterns + context + time + researcher
Priority Validation: critic + constraints + resolver + principles
Impact Analysis: performance + completer + hypothesis + testing
Dependency Mapping: explorer + connector + axioms + invariants
Strategic Planning: resolver + principles + docs + time

ENHANCED_OUTPUT:
- Prioritized list of recommended TODOs validated by multi-agent analysis
- Task groupings for efficient batch processing with dependency optimization
- Comprehensive dependency analysis and implementation order with conflict resolution
- Summary of backlog health and actionability with strategic recommendations
- Performance impact assessment and resource allocation guidance
- Quality assurance validation ensuring implementation feasibility

EXAMPLE:
/todo-review --filter pending --priority high --actionable-only

BEHAVIOR:
- Delegates ALL analysis to todo agent off-context
- Provides strategic overview without task-by-task noise
- Returns only essential recommendations and insights
- Maintains clean separation between review and implementation