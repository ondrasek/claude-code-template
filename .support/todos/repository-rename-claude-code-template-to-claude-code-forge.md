---
status: pending
type: docs
priority: high
assignee: todo-management-agent
created: 2025-08-05
impacts: branding, documentation, references, configuration
related_files: package.json, README.md, CHANGELOG.md, .claude/config.json
---

# Repository Rename: claude-code-template to claude-code-forge

## Description
Document and implement comprehensive repository rename from `claude-code-template` to `claude-code-forge`. This rename affects branding, documentation, references, and configuration files throughout the repository.

## Context
The repository has been renamed to better reflect its evolution from a template to a comprehensive development forge for Claude-powered development workflows. This change requires systematic updates across all documentation and configuration files.

## Acceptance Criteria
- [ ] Update package.json name field to "claude-code-forge"
- [ ] Update README.md title and references
- [ ] Update CHANGELOG.md repository references
- [ ] Update .claude/config.json if it contains repository references
- [ ] Update any hardcoded references in scripts or configuration
- [ ] Update GitHub repository description and topics
- [ ] Update any documentation that references the old name
- [ ] Verify all internal links and references work correctly
- [ ] Update any CI/CD configuration files
- [ ] Update any license or copyright references if applicable

## Impact Areas

### Documentation Files
- README.md - Primary branding and introduction
- CHANGELOG.md - Historical references and repository context
- Any .md files in .support/ directories
- Agent descriptions in .claude/agents/ that may reference repository

### Configuration Files
- package.json - Name field and description
- .claude/config.json - Repository-specific settings
- Any CI/CD configuration (GitHub Actions, etc.)
- Git configuration files

### Scripts and Automation
- Any shell scripts with hardcoded repository names
- Launch scripts or installation commands
- Build or deployment scripts

### Branding Elements
- Repository description
- GitHub topics and keywords
- Social media or external references

## Implementation Priority
**High Priority** - Branding consistency is critical for user experience and professional presentation. Inconsistent naming creates confusion and reduces credibility.

## Notes
- This is a documentation-heavy task but has technical implications
- Should be coordinated with any ongoing development to avoid conflicts
- Consider creating a migration guide if external users depend on old naming
- Verify that the rename doesn't break any external integrations or references

## Dependencies
- None (can be implemented immediately)
- Should be completed before next major release

## Validation Steps
1. Search entire codebase for "claude-code-template" references
2. Test all scripts and commands after rename
3. Verify GitHub repository settings updated
4. Confirm all documentation is consistent
5. Check that no broken links exist after changes