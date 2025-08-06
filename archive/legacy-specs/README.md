# Legacy Specs Archive

This directory contains the original specification files that were used to track development work before the migration to GitHub Issues.

## Migration Information

- **Migration Date:** 2025-08-06
- **Migration Destination:** GitHub Issues (#8-37)
- **Original Location:** `/specs/`
- **Total Files Migrated:** 30 specification files

## What Was Migrated

All specification files from the `/specs/` directory were successfully migrated to GitHub Issues using the `migrate-spec.py` script. Each spec became a separate GitHub Issue with:

- Proper title generation from filename
- Preserved original metadata in issue body
- Appropriate labels (`enhancement`, `bug`, `documentation`, etc.)
- Migration audit trail with `migrated-from-specs` label

## GitHub Issues Range

The migrated specifications can be found in GitHub Issues:
- **Issue Range:** #8-37
- **Repository:** [claude-code-forge](https://github.com/ondrasek/claude-code-forge/issues)

## Archive Purpose

These files are preserved for:
- Historical reference
- Audit trail of development decisions
- Backup in case GitHub Issues need cross-reference
- Understanding evolution of the project's approach to specification management

## Files in This Archive

The following specification files were migrated:

- `add-cli-tool.md` → Issue #8
- `add-launch-claude-script-tests.md` → Issue #9
- `add-negative-triggers-agents.md` → Issue #10
- `ambiguous-concepts.md` → Issue #11
- `clarify-agent-boundaries-overlaps.md` → Issue #12
- `claude-md-improvement-plan.md` → Issue #13
- `cli-implementation-roadmap.md` → Issue #14
- `github-issues-migration-plan.md` → Issue #15
- `implementation-priority-sequencing.md` → Issue #16
- `improve-launch-claude-interactive-detection.md` → Issue #17
- `indirect-agent-spawning-with-explicit-structured-contracts.md` → Issue #18
- `launch-claude-logging.md` → Issue #19
- `launch-claude-support-for-continue.md` → Issue #20
- `measure-output-quality-improvements.md` → Issue #21
- `migrate-specs-to-github-issues.md` → Issue #22
- `monitor-agent-selection-frequency.md` → Issue #23
- `monitoring-metrics-ecosystem-health.md` → Issue #24
- `opportunistic-researcher.md` → Issue #25
- `performance-optimization-agent-efficiency.md` → Issue #26
- `performance-optimization-implementation.md` → Issue #27
- `phase3-cross-domain-innovations.md` → Issue #28
- `post-tool-hook-for-git.md` → Issue #29
- `repository-rename-claude-code-template-to-claude-code-forge.md` → Issue #30
- `repository-restructuring-proposal.md` → Issue #31
- `split-claude-config.md` → Issue #32
- `take-advantage-of-hooks.md` → Issue #33
- `track-context-pollution-reduction.md` → Issue #34
- `update-researcher-web-first-priority.md` → Issue #35
- `validation-testing-ecosystem-optimization.md` → Issue #36
- `validation-testing-optimized-ecosystem.md` → Issue #37
- `writer-agent-and-file-modification-protocol.md` → Issue #38

## New Workflow

Going forward, all specifications and development work tracking should use GitHub Issues instead of local spec files. This provides:
- Better collaboration and discussion
- Integrated issue tracking with commits and PRs
- Public visibility for community contributions
- Automated project management capabilities

---

*This archive was created as part of the repository cleanup following the successful migration to GitHub Issues workflow.*