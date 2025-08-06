---
description: Review existing GitHub Issues, prioritize tasks, and analyze issue backlog for strategic planning.
argument-hint: No arguments needed - automatically reviews and prioritizes all issues.
allowed-tools: Task
---

# GitHub Issue Review

Review existing GitHub Issues, prioritize tasks, and analyze issue backlog for task evaluation and relevance assessment across all pending issues in ondrasek/claude-code-forge repository.

## Instructions

1. Parse $ARGUMENTS for review parameters:
   - --filter [open|closed|all] (status filter, default: open)
   - --priority [high|medium|low] (filter by priority level)
   - --type [feat|fix|docs|refactor|test|chore] (filter by issue type)
   - --limit N (limit number of issues to review)
   - --actionable-only (show only immediately actionable tasks)
   - --labels [label1,label2] (filter by specific labels)

2. Delegate comprehensive issue analysis to github-issues-workflow agent with enhanced coordination
1. invoke github-issues-workflow agent: comprehensive GitHub Issue analysis with enhanced agent coordination
2. coordinate parallel review analysis:
   - **Relevance Assessment Cluster**: patterns + context + time + researcher (analyze relevance with system understanding and historical context)
   - **Priority Validation Cluster**: critic + constraints + resolver (validate priorities with critical assessment and conflict resolution)
   - **Impact Analysis Cluster**: performance + completer + hypothesis (assess impact with performance implications and completion analysis)
   - **Dependency Mapping Cluster**: explorer + connector + axioms (identify dependencies with cross-domain insights)
3. generate comprehensive implementation strategy validated by resolver + principles + docs agents

PARAMETERS:
--filter [open|closed|all] (status filter, default: open)
--priority [high|medium|low] (filter by priority level)
--type [feat|fix|docs|refactor|test|chore] (filter by issue type)
--limit N (limit number of issues to review)
--actionable-only (show only immediately actionable tasks)
--labels [label1,label2] (filter by specific labels)

ENHANCED_AGENT_DELEGATION:
Primary: github-issues-workflow (comprehensive GitHub Issue analysis with universal agent coordination)
Relevance Assessment: patterns + context + time + researcher
Priority Validation: critic + constraints + resolver + principles
Impact Analysis: performance + completer + hypothesis + testing
Dependency Mapping: explorer + connector + axioms + invariants
Strategic Planning: resolver + principles + docs + time

ENHANCED_OUTPUT:
- Prioritized list of recommended issues validated by multi-agent analysis
- Task groupings for efficient batch processing with dependency optimization
- Comprehensive dependency analysis and implementation order with conflict resolution
- Summary of backlog health and actionability with strategic recommendations
- Performance impact assessment and resource allocation guidance
- Quality assurance validation ensuring implementation feasibility

EXAMPLE:
/github-issue review --filter open --priority high --actionable-only

BEHAVIOR:
- Delegates ALL analysis to github-issues-workflow agent off-context
- Provides strategic overview without issue-by-issue noise
- Returns only essential recommendations and insights
- Maintains clean separation between review and implementation