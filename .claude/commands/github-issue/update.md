---
description: Update existing GitHub Issue with new information, labels, or status.
argument-hint: Issue NUMBER and update parameters.
allowed-tools: Task
---

# GitHub Issue Update

Update existing GitHub Issue with new information, labels, status, or assignments.

## Instructions

1. Parse $ARGUMENTS for issue update parameters:
   - ISSUE_NUMBER (required GitHub issue number)
   - --title "New Title" (update issue title)
   - --body "New description" (update issue body/description)
   - --add-labels [label1,label2] (add labels to issue)
   - --remove-labels [label1,label2] (remove labels from issue)
   - --assignee [username] (assign to GitHub user)
   - --unassign (remove current assignee)
   - --milestone [milestone] (assign to milestone)
   - --priority [high|medium|low] (update priority level)
   - --status [pending|in-progress|completed] (update status)

2. Delegate issue update to github-issues-workflow agent with enhanced coordination
1. invoke github-issues-workflow agent: update GitHub Issue with enhanced agent coordination
2. coordinate parallel update validation:
   - **Existence Verification Cluster**: context + researcher (verify issue exists and current state)
   - **Change Validation Cluster**: critic + principles + resolver (validate proposed changes)
   - **Impact Assessment Cluster**: patterns + context + time (assess impact of changes)
   - **Quality Assurance Cluster**: critic + principles + completer (ensure update quality)
3. apply GitHub Issue updates with comprehensive validation

PARAMETERS:
ISSUE_NUMBER (required GitHub issue number)
--title "New Title" (update issue title)
--body "New description" (update issue body/description)
--add-labels [label1,label2] (add labels to issue)
--remove-labels [label1,label2] (remove labels from issue)
--assignee [username] (assign to GitHub user)
--unassign (remove current assignee)
--milestone [milestone] (assign to milestone)
--priority [high|medium|low] (update priority level)
--status [pending|in-progress|completed] (update status)

ENHANCED_AGENT_DELEGATION:
Primary: github-issues-workflow (comprehensive issue update with universal agent coordination)
Existence Verification: context + researcher
Change Validation: critic + principles + resolver
Impact Assessment: patterns + context + time
Quality Assurance: critic + principles + completer

ENHANCED_OUTPUT:
- GitHub Issue updated with validated changes
- Comprehensive change summary with before/after comparison
- Impact assessment of changes with dependency analysis
- Quality assurance validation ensuring update correctness

EXAMPLES:
/github-issue update 42 --priority high --add-labels "priority:high,urgent"
/github-issue update 15 --status completed --title "Implement JWT authentication (completed)"
/github-issue update 23 --assignee john-doe --milestone "v2.1.0"

BEHAVIOR:
- Delegates ALL issue updates to github-issues-workflow agent
- Keeps main context clean and focused
- Returns only essential update confirmation
- No issue tracking pollution in main conversation
- Validates changes before applying to GitHub