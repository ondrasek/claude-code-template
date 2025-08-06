---
description: List and filter GitHub Issues with various criteria and output formats.
argument-hint: Optional filter parameters to refine issue list.
allowed-tools: Task
---

# GitHub Issue List

List and filter GitHub Issues with comprehensive filtering and formatting options for quick issue overview.

## Instructions

1. Parse $ARGUMENTS for listing parameters:
   - --state [open|closed|all] (issue state filter, default: open)
   - --labels [label1,label2] (filter by labels)
   - --assignee [username] (filter by assignee)
   - --milestone [milestone] (filter by milestone)
   - --priority [high|medium|low] (filter by priority)
   - --type [feat|fix|docs|refactor|test|chore] (filter by type)
   - --limit N (limit number of results)
   - --sort [created|updated|comments] (sort criteria)
   - --order [asc|desc] (sort order)
   - --format [table|json|minimal] (output format)

2. Delegate issue listing to github-issues-workflow agent with enhanced coordination
1. invoke github-issues-workflow agent: list GitHub Issues with enhanced agent coordination
2. coordinate parallel listing analysis:
   - **Query Optimization Cluster**: patterns + performance (optimize GitHub API queries)
   - **Filter Validation Cluster**: critic + constraints (validate filter combinations)
   - **Format Selection Cluster**: context + principles (select optimal output format)
   - **Priority Assessment Cluster**: time + critic + resolver (assess issue priorities for display)
3. generate formatted issue list with comprehensive metadata

PARAMETERS:
--state [open|closed|all] (issue state filter, default: open)
--labels [label1,label2] (filter by labels)
--assignee [username] (filter by assignee)  
--milestone [milestone] (filter by milestone)
--priority [high|medium|low] (filter by priority)
--type [feat|fix|docs|refactor|test|chore] (filter by type)
--limit N (limit number of results)
--sort [created|updated|comments] (sort criteria)
--order [asc|desc] (sort order)
--format [table|json|minimal] (output format)

ENHANCED_AGENT_DELEGATION:
Primary: github-issues-workflow (comprehensive issue listing with universal agent coordination)
Query Optimization: patterns + performance
Filter Validation: critic + constraints
Format Selection: context + principles
Priority Assessment: time + critic + resolver

ENHANCED_OUTPUT:
- Formatted list of GitHub Issues matching criteria
- Issue metadata including labels, assignees, milestones
- Priority indicators and status information
- Quick action suggestions for high-priority items
- Summary statistics of filtered results

EXAMPLES:
/issue list --priority high --state open --limit 10
/issue list --labels "feat,priority:high" --assignee john-doe
/issue list --milestone "v2.1.0" --format table --sort updated

BEHAVIOR:
- Delegates ALL issue listing to github-issues-workflow agent
- Provides clean, formatted output without noise
- Supports multiple output formats for different use cases
- Returns actionable issue overview with strategic insights
- Maintains separation between listing and management operations