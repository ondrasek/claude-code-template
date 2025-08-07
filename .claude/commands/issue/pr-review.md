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

2. **Three-Stage Sequential Agent Review Process**:

   **Stage 1: Contextual Analysis**:
   - `Task(context)`: Codebase context and architectural impact mapping
     - Map affected systems, modules, and dependencies
     - Identify architectural relationships and integration points
     - Analyze scope of changes within broader codebase structure
     - Provide contextual foundation for subsequent analysis

   **Stage 2: Technical Research**:
   - `Task(researcher)`: Domain-specific research and technical analysis
     - Research implications of changes using context findings
     - Investigate patterns, best practices, and potential issues
     - Gather technical knowledge about affected domains
     - Analyze implementation approaches and alternatives

   **Stage 3: Critical Assessment**:
   - `Task(critic)`: Risk assessment and contrarian analysis using all findings
     - Review context mapping and research findings for potential issues
     - Apply contrarian perspective to identify risks and edge cases
     - Provide final recommendations with priority ranking
     - Challenge assumptions and highlight overlooked concerns

3. **Sequential Context Building Strategy**:
   **Stage 1 (context)**: Receives diff and change summary for architectural mapping
   **Stage 2 (researcher)**: Receives Stage 1 context findings + diff for research analysis  
   **Stage 3 (critic)**: Receives Stage 1 + Stage 2 findings for comprehensive critique
   
   Each agent builds upon previous findings:
   - **Progressive Enhancement**: Later agents have richer information context
   - **Cumulative Analysis**: Each stage adds depth to understanding
   - **Size Limits**: Analysis scope remains manageable through focused delegation

4. **Autonomous Sequential Execution**:
   Execute autonomously with intelligent defaults:
   - Analysis depth: Three-stage progressive analysis with summary presentation
   - Base branch: Auto-detect (main/master/develop)
   - Sequential execution: context → researcher → critic
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

## Agent Coordination Strategy (Sequential Pipeline)

**Three-Agent Sequential Pipeline**:

**Stage 1: Contextual Foundation**
- `context` agent: Architectural impact mapping
  - Maps affected systems, modules, and dependencies
  - Identifies integration points and architectural relationships
  - Provides structural context for understanding change scope
  - Delivers contextual foundation for subsequent analysis

**Stage 2: Research and Analysis**
- `researcher` agent: Domain-specific investigation
  - Uses contextual findings to research technical implications
  - Investigates patterns, best practices, and potential issues
  - Gathers domain knowledge about affected areas
  - Analyzes implementation approaches and alternatives

**Stage 3: Critical Assessment**
- `critic` agent: Risk evaluation and contrarian analysis
  - Reviews context mapping and research findings
  - Applies contrarian perspective to identify overlooked risks
  - Challenges assumptions and highlights edge cases
  - Delivers final prioritized recommendations with severity rankings

**Sequential Context Building**:
- Each stage receives all previous findings for enhanced analysis
- Progressive information enhancement improves decision quality
- Graceful degradation: Partial results if agents fail sequentially

## Enhanced Integration Points

- **Git Workflow**: Robust `git diff` with multiple fallback strategies
- **Agent Infrastructure**: Three-agent Task() delegation with sequential context building
- **Error Recovery**: Graceful degradation when components fail
- **Performance Management**: Size limits and efficient sequential analysis
- **Output Standards**: Structured severity levels and specific file references

## Risk Mitigation Implementations

1. **Sequential Agent Architecture**: Three focused agents in logical sequence reduce complexity
2. **Progressive Context Building**: Each agent builds upon previous findings for enhanced depth
3. **Domain Specialization**: Context mapping → research → criticism leverages agent strengths
4. **Fallback Strategies**: Graceful degradation with partial results from completed stages
5. **Quality over Speed**: Sequential execution prioritizes thorough analysis over parallel efficiency
6. **Enhanced Information Flow**: Later agents have richer context for better decision making

## Success Criteria (Enhanced)

- Command executes reliably across various git states and branch configurations
- Provides comprehensive analysis through sequential three-agent pipeline
- Output includes severity-graded issues with specific file locations
- Enhanced analysis quality through progressive context building
- Error conditions provide actionable guidance for user resolution
- Maintains optimal balance of thoroughness and efficiency

## Implementation Notes

**Diff Analysis Scope**: Focus on `git diff main...HEAD` with validation and fallbacks
**Three-Agent Pipeline**: context → researcher → critic with sequential context building
**Agent Context Delivery**: Each stage receives all previous findings plus diff context
**Sequential Optimization**: Prioritizes analysis depth over execution speed
**Error Reporting**: Graceful degradation with partial results from completed stages
**Extensibility**: Each agent can evolve independently while maintaining pipeline integrity
