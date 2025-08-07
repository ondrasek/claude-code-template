---
description: Sequential agent pipeline for pull request analysis using context-research-critique pattern.
allowed-tools: Task, Bash, Grep, Read, LS
---

# PR Review Analysis

Execute sequential three-agent pipeline for comprehensive pull request analysis on current branch.

## Instructions

<git_analysis priority="HIGH">
<validation>
1. Validate git state: check for detached HEAD, merge conflicts, uncommitted changes
2. Detect current branch and base branch (main/master/develop)
3. Extract diff using `git diff main...HEAD` with fallback strategies
4. Skip if >100 files changed (report size limit exceeded)
</validation>
</git_analysis>

<sequential_pipeline priority="CRITICAL">
<stage_1>
Task(context): Codebase context and architectural impact mapping
- Analyze git diff for affected systems and dependencies
- Map integration points and architectural relationships  
- Identify scope of changes within codebase structure
- Output: Contextual foundation for subsequent analysis
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

<error_handling priority="MEDIUM">
<git_errors>Handle detached HEAD, merge conflicts, missing base branch</git_errors>
<agent_failures>Continue with available agents, report failed stages</agent_failures>
<size_limits>Graceful handling when file/change limits exceeded</size_limits>
</error_handling>