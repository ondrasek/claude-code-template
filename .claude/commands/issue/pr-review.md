---
description: Intelligent pull request analysis using coordinated agent workflows for comprehensive code review.
allowed-tools: Task, Bash, Grep, Read, LS
---

# Pull Request Review Command

Comprehensive pull request analysis leveraging the existing agent ecosystem to perform intelligent code review when executed from a checked-out branch containing pull request changes.

## Prerequisites

- Active Git repository with proper branch structure
- Current branch contains changes to review (not on base branch)
- Network access for agent coordination and repository operations
- Sufficient permissions for git diff and branch analysis operations

## Usage Examples

```bash
# Autonomous pull request review
/pr-review
```

## Instructions

1. **Branch and Diff Analysis with Enhanced Validation**:
   - Detect current branch and determine base branch (default: main)
   - Validate git state: check for detached HEAD, merge conflicts, uncommitted changes
   - Extract pull request diff using `git diff main...HEAD` with fallback strategies
   - Implement size limits: warn for large PRs (>100 files or >5000 lines changed)
   - Handle edge cases: orphaned branches, rebased branches, empty diffs

2. **Staged Agent Review Process with Context Scoping**:

   **Stage 1: Initial Triage (Sequential)**:
   - `Task(critic)`: Initial risk assessment and red flags identification
   - `Task(context)`: Codebase integration analysis and scope validation
   - **Decision Point**: Continue with full analysis or provide quick feedback

   **Stage 2: Core Analysis (Sequential)**:
   Execute only if Stage 1 passes basic validation:
   - `Task(performance-optimizer)`: Performance analysis on modified functions/methods only
   - `Task(test-strategist)`: Test coverage analysis for changed code paths
   - `Task(patterns)`: Architectural pattern validation for structural changes
   - `Task(principles)`: Standards compliance for modified components
   - `Task(code-cleaner)`: Code quality analysis with diff-specific context

   **Stage 3: Final Critical Review (Sequential)**:
   - `Task(critic)`: Final risk assessment with all agent findings for contrarian analysis

3. **Agent Context Scoping Strategy**:
   Each agent receives:
   - **Diff Context**: Only modified files and surrounding context (±5 lines)
   - **File List**: Specific files to analyze (not entire codebase)
   - **Change Summary**: Brief description of modification type (add/modify/delete)
   - **Size Limits**: Analysis scope limited to manageable segments
   - **Timeout Enforcement**: Hard limits to prevent hanging

4. **Autonomous Command Execution**:
   Execute autonomously with intelligent defaults:
   - Analysis depth: Comprehensive review with summary presentation
   - Base branch: Auto-detect (main/master/develop)
   - Agent selection: All available agents for complete coverage
   - Sequential execution: Each agent builds on previous findings
   - File limits: Skip review if more than 100 files changed

5. **Autonomous Review Report Generation**:
   Consolidate feedback with deduplication and prioritization:

   ```
   # Pull Request Review Report

   **Branch**: [current] → [base]
   **Files Modified**: [count] ([skipped if > limit])
   **Lines Changed**: +[additions] -[deletions]
   **Review Duration**: [time]

   ## Executive Summary
   [High-level readiness assessment: READY/NEEDS_WORK/RISKY]

   ## Critical Issues [SEVERITY: HIGH]
   [Blocking issues that must be addressed]

   ## Major Concerns [SEVERITY: MEDIUM]
   [Important issues that should be addressed]

   ## Minor Issues [SEVERITY: LOW]
   [Suggestions for improvement]

   ## Performance Analysis
   [Performance impact assessment with specific metrics]

   ## Test Coverage Assessment
   [Test completeness with coverage gaps identified]

   ## Architectural Review
   [Design pattern compliance and structural concerns]

   ## Code Quality Summary
   [Maintainability, readability, standards adherence]

   ## Recommendations (Prioritized)
   1. [Critical] File:Line - Specific action required
   2. [Major] File:Line - Important improvement
   3. [Minor] File:Line - Optional enhancement
   ```

6. **Comprehensive Error Handling**:
   - **Git State Issues**: Detached HEAD, merge conflicts, missing base branch
   - **Size Limits**: Graceful handling of oversized PRs with summary-only mode
   - **Agent Failures**: Continue with available agents, report failed agents
   - **Timeout Handling**: Cancel hung agents, report partial results
   - **Empty Changes**: Clear messaging when no changes detected
   - **Fallback Modes**: Basic git analysis when agents unavailable

## Agent Coordination Strategy (Revised)

**Stage 1: Initial Triage (Sequential - Risk-First)**
- `critic` agent first: Identify obvious red flags and stop-gaps
- `context` agent second: Validate integration scope and dependencies
- **Decision Point**: If critic identifies critical risks, proceed with caution or quick exit

**Stage 2: Sequential Core Analysis (Single-Threaded)**
- Execute each agent sequentially, building context progressively
- Each agent gets scoped context plus findings from previous agents
- `performance-optimizer` → `test-strategist` → `patterns` → `principles` → `code-cleaner`
- Each agent can reference and build upon previous agent findings
- Graceful degradation: Continue with available agents if some fail

**Stage 3: Consolidation with Intelligence (Sequential)**
- `critic` agent reviews all findings for final risk assessment
- **Synthesis**: Integrate findings across all agents with cross-references
- **Prioritization**: Rank issues by impact, confidence, and agent consensus
- **Actionability**: Ensure recommendations include specific locations and context

## Enhanced Integration Points

- **Git Workflow**: Robust `git diff` with multiple fallback strategies
- **Agent Infrastructure**: Sequential Task() delegation with progressive context building
- **Error Recovery**: Graceful degradation when components fail
- **Performance Management**: Size limits and timeout controls
- **Output Standards**: Structured severity levels and specific file references

## Risk Mitigation Implementations

1. **Agent Context Scoping**: Each Task() call includes specific file list, diff segments, and previous agent findings
2. **Sequential Execution**: Each agent builds upon previous findings for comprehensive analysis
3. **Fallback Strategies**: Multiple levels of degraded functionality
4. **Performance Limits**: Size thresholds with early termination options
5. **Enhanced Error Scenarios**: Specific handlers for all identified git edge cases
6. **Progressive Context Building**: Later agents receive enriched context from earlier analysis

## Success Criteria (Enhanced)

- Command executes reliably across various git states and branch configurations
- Provides useful analysis even when some agents fail or timeout
- Output includes severity-graded issues with specific file locations
- Performance remains acceptable for typical PR sizes (< 2 minutes for < 50 files)
- Error conditions provide actionable guidance for user resolution
- Critic agent provides meaningful risk assessment at both triage and final phases

## Implementation Notes

**Diff Analysis Scope**: Focus on `git diff main...HEAD` with validation and fallbacks
**Agent Context Delivery**: Each agent receives JSON context with files, diffs, metadata, and previous agent findings
**Sequential Execution Management**: Implement progressive context enrichment and graceful degradation
**Error Reporting**: Structured error codes for different failure modes
**Extensibility**: Plugin architecture for additional review agents
