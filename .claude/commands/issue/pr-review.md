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

2. **Two-Stage Agent Review Process**:

   **Stage 1: Comprehensive Analysis**:
   - `Task(pr-analyzer)`: Complete technical analysis including:
     - Codebase context and integration scope
     - Performance impact assessment  
     - Test coverage and testing strategy
     - Architectural patterns and design compliance
     - Code quality and maintainability review
     - Standards adherence validation

   **Stage 2: Critical Assessment**:
   - `Task(critic)`: Risk assessment and contrarian analysis based on comprehensive findings
     - Review all technical findings for potential issues
     - Identify risks, edge cases, and potential problems
     - Provide final recommendations with priority ranking

3. **Agent Context Scoping Strategy**:
   Each agent receives:
   - **Diff Context**: Only modified files and surrounding context (±5 lines)
   - **File List**: Specific files to analyze (not entire codebase)
   - **Change Summary**: Brief description of modification type (add/modify/delete)
   - **Size Limits**: Analysis scope limited to manageable segments
   - **Progressive Context**: Stage 2 receives Stage 1 findings for enhanced analysis

4. **Autonomous Command Execution**:
   Execute autonomously with intelligent defaults:
   - Analysis depth: Comprehensive review with summary presentation
   - Base branch: Auto-detect (main/master/develop)
   - Two-agent sequential execution for optimal efficiency
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

## Agent Coordination Strategy (Streamlined)

**Two-Agent Sequential Pipeline**:

**Stage 1: Comprehensive Technical Analysis**
- `pr-analyzer` agent: Multi-domain technical analysis
  - Performs integrated analysis across all technical domains
  - Synthesizes context, performance, testing, patterns, and quality concerns
  - Provides comprehensive findings with specific file/line references
  - Delivers structured analysis for Stage 2 consumption

**Stage 2: Critical Risk Assessment**
- `critic` agent: Risk evaluation and contrarian analysis
  - Reviews comprehensive findings from Stage 1
  - Identifies risks, edge cases, and potential problems
  - Challenges assumptions and provides contrarian perspective
  - Delivers final prioritized recommendations with severity rankings

**Progressive Context Building**:
- Stage 2 receives complete Stage 1 analysis for informed criticism
- Each stage builds upon previous findings for enhanced depth
- Graceful degradation: Partial results if one agent fails

## Enhanced Integration Points

- **Git Workflow**: Robust `git diff` with multiple fallback strategies
- **Agent Infrastructure**: Two-agent Task() delegation with progressive context building
- **Error Recovery**: Graceful degradation when components fail
- **Performance Management**: Size limits and efficient two-stage analysis
- **Output Standards**: Structured severity levels and specific file references

## Risk Mitigation Implementations

1. **Streamlined Agent Architecture**: Two focused agents reduce coordination complexity
2. **Comprehensive Analysis**: Single pr-analyzer synthesizes multi-domain expertise
3. **Progressive Context Building**: Critic receives full technical analysis for informed assessment  
4. **Fallback Strategies**: Graceful degradation with partial results
5. **Performance Optimization**: Reduced agent count improves execution efficiency
6. **Enhanced Error Scenarios**: Simplified error handling with two-agent model

## Success Criteria (Enhanced)

- Command executes reliably across various git states and branch configurations
- Provides comprehensive analysis through streamlined two-agent pipeline
- Output includes severity-graded issues with specific file locations
- Improved performance through reduced agent overhead
- Error conditions provide actionable guidance for user resolution  
- Maintains analysis depth through synthesis approach

## Implementation Notes

**Diff Analysis Scope**: Focus on `git diff main...HEAD` with validation and fallbacks
**Two-Agent Pipeline**: pr-analyzer → critic with progressive context building
**Agent Context Delivery**: Stage 1 receives diff context, Stage 2 receives Stage 1 findings
**Performance Optimization**: Reduced coordination overhead with streamlined architecture
**Error Reporting**: Simplified error handling with two-agent model
**Extensibility**: pr-analyzer can incorporate additional analysis domains as needed
