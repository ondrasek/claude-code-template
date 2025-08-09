---
description: Sequential agent pipeline for pull request analysis using context-research-critique pattern.
argument-hint: <issue-number> (optional)
allowed-tools: Task, Bash, Grep, Read, LS
---

# PR Review Analysis

Execute sequential three-agent pipeline for pull request analysis. Use $ARGUMENTS or auto-detect from current branch.

## Instructions

<scope_determination priority="CRITICAL">
<argument_processing>
if $ARGUMENTS provided:
  - Parse $ARGUMENTS
  - Fetch PR details using GitHub CLI: `gh pr view $ARGUMENTS`
  - Extract branch information and diff scope from PR data
else:
  - Auto-detect from current branch (feature/issue-N pattern)
  - Extract git log since branch diverged: `git log main...HEAD --oneline`
  - Use current branch vs base for analysis scope including commit history
</argument_processing>
<validation>
1. Validate git state: check for detached HEAD, merge conflicts, uncommitted changes
2. Determine analysis scope: specific PR or current branch changes
3. Extract appropriate diff using determined scope
4. Skip if >100 files changed (report size limit exceeded)
</validation>
</scope_determination>

<sequential_pipeline priority="CRITICAL">
<stage_1>
Task(context): Codebase context and architectural impact mapping
- Analyze determined diff scope and commit history for affected systems and dependencies
- Map integration points and architectural relationships  
- Identify scope of changes within codebase structure
- Consider commit progression and development patterns
- Output: Contextual foundation including change evolution for subsequent analysis
</stage_1>

<stage_2>
Task(researcher): Technical research using Stage 1 context findings
- Research implications using contextual mapping
- Investigate patterns, best practices, potential issues
- Analyze implementation approaches and alternatives
- Output: Technical analysis with domain knowledge
</stage_2>

<stage_3>
Task(critic): Risk assessment using all previous findings
- Review context + research findings for risks/issues
- Apply contrarian analysis to identify edge cases
- Challenge assumptions and highlight concerns
- Output: Final prioritized recommendations
</stage_3>
</sequential_pipeline>

<output_template priority="HIGH">
<format>
# Pull Request Review Report

**Branch**: [current] → [base]  
**Files**: [count] ([+additions/-deletions])
**Analysis**: [timestamp]

## Executive Summary
[READY/NEEDS_WORK/RISKY] - [brief assessment]

## Critical Issues [HIGH]
[Blocking issues requiring immediate attention]

## Major Concerns [MEDIUM]  
[Important issues that should be addressed]

## Minor Issues [LOW]
[Improvement suggestions]

## Recommendations
1. [Priority] File:Line - Specific action
2. [Priority] File:Line - Specific action
3. [Priority] File:Line - Specific action
</format>
</output_template>

## Examples

<usage_scenarios priority="HIGH">
<automatic_detection>
# Analyze current branch changes automatically
/issue pr-review

# Works when on feature branch (e.g., feature/issue-123)
# Auto-extracts commit history and diff since divergence from main
# Ideal for: Current development workflow, branch-based analysis
</automatic_detection>

<specific_pr_number>
# Analyze specific pull request by number
/issue pr-review 456

# Fetches PR #456 details using GitHub CLI
# Analyzes specific PR scope and changes
# Ideal for: Code review of others' PRs, historical analysis
</specific_pr_number>

<github_url_usage>
# Analyze PR from GitHub URL (extracted automatically)
/issue pr-review https://github.com/owner/repo/pull/789

# Parses GitHub URL and extracts PR number
# Works with any repository URL format
# Ideal for: Cross-repository reviews, external PR analysis
</github_url_usage>

<advanced_scenarios>
# Large PR handling (>100 files)
/issue pr-review 123
# → Reports size limit exceeded with file count summary

# Merge conflict detection
/issue pr-review
# → Detects and reports git state issues before analysis

# Missing base branch scenario
/issue pr-review feature-branch
# → Handles missing base branch with graceful error reporting
</advanced_scenarios>
</usage_scenarios>

<error_handling priority="MEDIUM">
<git_errors>Handle detached HEAD, merge conflicts, missing base branch</git_errors>
<agent_failures>Continue with available agents, report failed stages</agent_failures>
<size_limits>Graceful handling when file/change limits exceeded</size_limits>
</error_handling>