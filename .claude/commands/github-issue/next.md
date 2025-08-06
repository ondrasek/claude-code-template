---
description: Cleanup completed/stale GitHub Issues and determine optimal next task with strategic prioritization.
argument-hint: No arguments needed - automatically determines optimal next task.
allowed-tools: Task, Bash
---

# GitHub Issue Cleanup and Next Task

Comprehensive GitHub Issue hygiene followed by intelligent next step analysis for full issue lifecycle management with strategic task prioritization.

## Instructions

1. Parse $ARGUMENTS for next task parameters:
   - --limit N (limit number of next-step recommendations)

2. Delegate comprehensive cleanup and analysis to github-issues-workflow agent with enhanced coordination
1. invoke github-issues-workflow agent: comprehensive cleanup and analysis with enhanced agent coordination
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
--limit N (limit number of next-step recommendations)

GITHUB_ISSUES_PROTOCOL:
GitHub Issue verification and management:
1. Use `gh issue list` to verify issues exist and check status
2. Ensure issues are properly labeled before closure
3. Only close issues that have been verified as completed
4. Update issue status using GitHub labels for traceability

ENHANCED_AGENT_DELEGATION:
Primary: github-issues-workflow (comprehensive GitHub Issue lifecycle management with universal agent coordination)
Cleanup Detection: patterns + completer + researcher + context + docs + time + critic
Next-Step Analysis: critic + constraints + resolver + principles + performance + hypothesis + testing + explorer + axioms + invariants
Strategic Coordination: resolver + principles + docs + time + completer

ENHANCED_OUTPUT:
- **Cleanup Summary**: Comprehensive list of issues cleaned up with validation evidence
  - Completed issues with implementation verification
  - Stale issues with obsolescence reasoning
  - GitHub issue status verification and closure confirmation
- **Remaining Issue Analysis**: Strategic assessment of active tasks
  - Priority validation with critical evaluation
  - Dependency mapping with conflict identification
  - Impact analysis with performance considerations
- **Next Step Recommendations**: Intelligent task selection
  - Optimal next task with comprehensive justification
  - Alternative options with trade-off analysis
  - Implementation strategy with resource considerations
  - Blocking dependencies and resolution paths
- **Strategic Insights**: Long-term issue health assessment
  - Backlog quality metrics and trend analysis
  - Resource allocation recommendations
  - Process improvement suggestions

EXAMPLES:
/github-issue next --limit 3 (show top 3 next-step recommendations)

BEHAVIOR:
- Delegates ALL cleanup and analysis to github-issues-workflow agent off-context
- Performs comprehensive GitHub Issue hygiene before strategic analysis
- Combines completion detection with staleness assessment
- Verifies issues are properly managed in GitHub before closure
- Presents cleanup findings and next-step recommendations
- CLOSES (not archives) confirmed issues - GitHub provides history
- Provides strategic overview without issue-by-issue noise
- Maintains clean separation between cleanup and analysis phases
- Returns actionable next steps with implementation guidance
- RECOMMENDATION ONLY: Does not automatically start implementing suggested tasks
- USER DECIDES: User chooses whether to proceed with recommended next steps