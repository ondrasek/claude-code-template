---
status: pending
type: feature
priority: high
assignee: patterns
created: 2025-07-28
impact: minor
---

# Create Dedicated Cleanup Agent for Repository Analysis

## Problem Statement
Repositories accumulate redundant content, obsolete files, and duplicate functionality over time. Need an automated way to detect and clean up redundancy while maintaining git history and providing user oversight.

## Required Agent: cleanup

### Core Mission
**AUTONOMOUS CLEANUP**: Analyze repository using other agents to identify redundant content, safely consolidate/remove it, and maintain clean codebase architecture.

### Cleanup Workflow (MANDATORY ORDER)

#### Phase 1: Repository Analysis (Use Other Agents)
1. **Invoke `patterns` agent** - Detect duplicate code, redundant files, similar functionality
2. **Invoke `principles` agent** - Identify violations of DRY, SOLID, clean architecture
3. **Invoke `completer` agent** - Find obsolete TODOs, unused files, dead code
4. **Invoke `context` agent** - Understand file relationships and dependencies

#### Phase 2: Safety Protocol (BEFORE ANY REMOVAL)
1. **MANDATORY**: Verify working directory is clean (`git status`)
2. **MANDATORY**: Commit all current changes with descriptive message
3. **MANDATORY**: Push to origin/main to preserve current state
4. **MANDATORY**: Create cleanup summary before making changes

#### Phase 3: Cleanup Execution
1. **Remove redundant files** (after confirming they're truly obsolete)
2. **Consolidate duplicate functionality** (merge similar code)
3. **Update references** (fix imports, links, documentation)
4. **Clean up empty directories** and orphaned files

#### Phase 4: Validation & Summary
1. **Test functionality** - Ensure nothing is broken
2. **Update documentation** - Reflect changes in README, docs
3. **Commit cleanup changes** with detailed message
4. **Provide summary** - Show what was removed/consolidated and why

### Cleanup Categories

#### 1. **File Redundancy**
- Duplicate scripts with same functionality
- Multiple README files with overlapping content  
- Obsolete configuration files
- Unused assets, templates, examples

#### 2. **Code Redundancy**
- Duplicate functions across files
- Similar agent implementations
- Redundant commands with same purpose
- Copy-pasted code patterns

#### 3. **Documentation Redundancy**
- Information repeated across multiple files
- Outdated documentation that conflicts with current implementation
- Verbose explanations that could be consolidated
- Duplicate installation/setup instructions

#### 4. **Configuration Redundancy**
- Multiple config files for same purpose
- Unused settings or environment variables
- Deprecated configuration formats
- Redundant MCP server definitions

### Safety Requirements

#### Before ANY Removal:
```bash
# MANDATORY safety protocol
git add -A
git commit -m "Pre-cleanup commit - preserve current state

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>"
git push origin main
```

#### After Cleanup:
```bash
# Cleanup commit with detailed summary
git add -A  
git commit -m "Repository cleanup - remove redundant content

- Removed: [list of removed files]
- Consolidated: [list of merged functionality]
- Updated: [list of updated references]

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>"
git push origin main
```

### Cleanup Summary Format

```
🧹 REPOSITORY CLEANUP SUMMARY

## Redundancy Analysis
- Files analyzed: X
- Redundant patterns found: Y
- Safety commits created: Z

## Actions Taken
### Removed Files:
- file1.md - Reason: Duplicate of file2.md
- script.sh - Reason: Functionality merged into scripts/main.sh

### Consolidated Content:
- Merged 3 similar agent definitions into unified approach
- Combined duplicate installation instructions in README

### Updated References:
- Fixed N broken links/imports
- Updated documentation to reflect consolidation

## Repository Impact
- Files reduced: X → Y (-Z files)
- Lines of code reduced: A → B (-C lines)
- Maintenance burden: Reduced complexity in [areas]

## Manual Review Needed
- [ ] Verify functionality still works as expected
- [ ] Review consolidated content for accuracy
- [ ] Check that no important context was lost
```

### Agent Invocation Examples

#### Detect File Redundancy:
```bash
Task(patterns): "Analyze repository for duplicate files, similar scripts, and redundant content. Focus on identifying files that serve the same purpose but exist in multiple locations."
```

#### Find Code Duplication:
```bash  
Task(principles): "Review codebase for DRY violations, duplicate implementations, and opportunities to consolidate similar functionality while maintaining clean architecture."
```

#### Identify Obsolete Content:
```bash
Task(completer): "Find unused files, completed TODOs that can be removed, dead code, and assets that are no longer referenced or needed."
```

## Success Criteria
- [ ] Create cleanup agent with multi-phase analysis workflow
- [ ] Implement mandatory safety protocol (commit before cleanup)
- [ ] Agent uses other specialized agents for comprehensive analysis
- [ ] Automated cleanup with human-readable summary
- [ ] Git history preservation with detailed commit messages
- [ ] Integration with existing agent ecosystem
- [ ] Clear documentation of cleanup categories and safety measures

## Benefits
- **Automated Maintenance**: Regular cleanup prevents repository bloat
- **Safety-First**: Always preserves current state before making changes
- **Comprehensive Analysis**: Uses multiple specialized agents for thorough review
- **User Oversight**: Provides detailed summary for manual verification
- **History Preservation**: Maintains git history with descriptive commits
- **Reduced Complexity**: Eliminates redundant files and duplicate functionality

## Notes
This agent should be invoked periodically or when repository feels cluttered. It serves as an automated janitor that keeps the codebase clean while ensuring nothing important is accidentally removed.