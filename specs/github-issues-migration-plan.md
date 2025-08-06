# GitHub Issues Migration Plan
## Comprehensive Strategy to Transition from Custom Specs System

## Executive Summary

This plan outlines a complete migration from our current 30-specification custom system in `/specs/` to GitHub Issues, preserving all content and metadata while modernizing our project management workflow. The migration addresses workflow complexity, tooling maintenance burden, and contributor accessibility.

## Current State Analysis

### Specification Inventory
- **Total Specifications**: 30 files in `/specs/` directory
- **With YAML Frontmatter**: 11 files (37% structured)
- **Without Frontmatter**: 19 files (63% unstructured)
- **File Structure**: Individual markdown files with inconsistent metadata

### Current Metadata Structure (YAML Frontmatter)
```yaml
---
status: pending|in_progress|completed|archived
type: feat|fix|docs|refactor|test|chore
priority: high|medium|low
assignee: agent-name
created: YYYY-MM-DD
---
```

### Current Workflow Components
1. **specs-analyst agent**: Autonomous specification management
2. **Slash commands**: `/specs create`, `/specs review`, `/specs cleanup`, `/specs next`
3. **CLAUDE.md integration**: File structure definitions and enforcement
4. **Agent delegation**: Off-context specification lifecycle management

### Content Categories Analysis
**High Priority Specifications (11 files):**
- CLI implementation (cli-implementation-roadmap.md, add-cli-tool.md)
- Performance optimization (performance-optimization-*.md)
- Repository restructuring (repository-restructuring-proposal.md)
- CLAUDE.md improvements (claude-md-improvement-plan.md)

**Medium Priority Specifications (12 files):**
- Agent system improvements (clarify-agent-boundaries-overlaps.md)
- Launch script enhancements (launch-claude-*.md)
- Monitoring and metrics (monitor-*.md, measure-*.md)

**Low Priority Specifications (7 files):**
- Research initiatives (opportunistic-researcher.md)
- Cross-domain innovations (phase3-cross-domain-innovations.md)
- Testing and validation (validation-testing-*.md)

## Migration Strategy

### Phase 1: GitHub Repository Setup (High Priority)

**GitHub Issue Templates**
Create comprehensive templates in `.github/ISSUE_TEMPLATE/`:

1. **Feature Request Template** (`feature_request.yml`)
```yaml
name: Feature Request
description: Propose new functionality or enhancement
title: "[FEATURE] "
labels: ["enhancement", "triage"]
body:
  - type: markdown
    value: |
      Thanks for suggesting a new feature! Please provide detailed information.
  
  - type: input
    id: priority
    attributes:
      label: Priority
      description: Urgency and importance level
      options:
        - high
        - medium
        - low
    validations:
      required: true

  - type: dropdown
    id: assignee
    attributes:
      label: Preferred Agent/Component
      description: Which part of the system should handle this?
      options:
        - ecosystem-analyzer
        - specs-analyst
        - cli-implementation
        - performance-optimization
        - docs-management
        - general

  - type: textarea
    id: description
    attributes:
      label: Description
      description: Clear description of the feature and its purpose
    validations:
      required: true

  - type: textarea
    id: acceptance_criteria
    attributes:
      label: Acceptance Criteria
      description: Specific, measurable outcomes that define completion
      placeholder: |
        - [ ] Specific measurable outcome 1
        - [ ] Specific measurable outcome 2
    validations:
      required: true

  - type: textarea
    id: implementation_notes
    attributes:
      label: Implementation Notes
      description: Technical approach, dependencies, constraints
```

2. **Bug Report Template** (`bug_report.yml`)
3. **Documentation Template** (`documentation.yml`)
4. **Refactoring Template** (`refactoring.yml`)
5. **Testing Template** (`testing.yml`)

**GitHub Labels System**
```
Type Labels:
- enhancement (maps to type: feat)
- bug (maps to type: fix)
- documentation (maps to type: docs)
- refactoring (maps to type: refactor)
- testing (maps to type: test)
- maintenance (maps to type: chore)

Priority Labels:
- priority/high
- priority/medium
- priority/low

Status Labels:
- status/pending (replaces pending)
- status/in-progress (replaces in_progress)
- status/blocked
- status/completed (for closed issues)

Component Labels:
- component/cli
- component/agents
- component/performance
- component/docs
- component/testing
- component/infrastructure

Agent Assignment Labels:
- agent/ecosystem-analyzer
- agent/specs-analyst
- agent/performance-optimizer
- agent/docs-manager
- agent/cli-implementer
```

### Phase 2: Content Migration (High Priority)

**Automated Migration Script**
Create Python script to process all 30 specifications:

```python
#!/usr/bin/env python3
"""
GitHub Issues Migration Script
Converts /specs/ markdown files to GitHub Issues via API
"""

import os
import yaml
import requests
from datetime import datetime
from pathlib import Path

class SpecMigrator:
    def __init__(self, repo, token):
        self.repo = repo
        self.headers = {
            'Authorization': f'token {token}',
            'Accept': 'application/vnd.github.v3+json'
        }
        self.api_url = f'https://api.github.com/repos/{repo}'
    
    def parse_spec_file(self, filepath):
        """Extract YAML frontmatter and content"""
        with open(filepath, 'r') as f:
            content = f.read()
        
        if content.startswith('---'):
            # Has YAML frontmatter
            parts = content.split('---', 2)
            metadata = yaml.safe_load(parts[1])
            body = parts[2].strip()
        else:
            # No frontmatter, infer metadata
            metadata = self.infer_metadata(filepath, content)
            body = content.strip()
        
        return metadata, body
    
    def infer_metadata(self, filepath, content):
        """Infer metadata from filename and content"""
        filename = Path(filepath).stem
        
        # Infer type from content keywords
        type_mapping = {
            'implement': 'feat',
            'add': 'feat',
            'fix': 'fix',
            'bug': 'fix',
            'docs': 'docs',
            'documentation': 'docs',
            'refactor': 'refactor',
            'test': 'test',
            'cleanup': 'chore'
        }
        
        spec_type = 'feat'  # default
        for keyword, mapped_type in type_mapping.items():
            if keyword in filename.lower() or keyword in content.lower():
                spec_type = mapped_type
                break
        
        # Infer priority from keywords
        priority = 'medium'  # default
        if any(word in content.lower() for word in ['critical', 'urgent', 'high priority']):
            priority = 'high'
        elif any(word in content.lower() for word in ['low priority', 'optional', 'nice to have']):
            priority = 'low'
        
        return {
            'status': 'pending',
            'type': spec_type,
            'priority': priority,
            'assignee': 'specs-analyst',
            'created': datetime.now().strftime('%Y-%m-%d')
        }
    
    def create_github_issue(self, title, body, metadata):
        """Create GitHub Issue via API"""
        labels = self.build_labels(metadata)
        
        issue_data = {
            'title': title,
            'body': self.format_issue_body(body, metadata),
            'labels': labels
        }
        
        if metadata.get('assignee') != 'specs-analyst':
            # Map agent to GitHub username if available
            issue_data['assignees'] = [self.map_agent_to_user(metadata['assignee'])]
        
        response = requests.post(
            f'{self.api_url}/issues',
            headers=self.headers,
            json=issue_data
        )
        
        return response.json()
    
    def build_labels(self, metadata):
        """Convert metadata to GitHub labels"""
        labels = []
        
        # Type mapping
        type_label_map = {
            'feat': 'enhancement',
            'fix': 'bug',
            'docs': 'documentation',
            'refactor': 'refactoring',
            'test': 'testing',
            'chore': 'maintenance'
        }
        labels.append(type_label_map.get(metadata['type'], 'enhancement'))
        
        # Priority
        labels.append(f"priority/{metadata['priority']}")
        
        # Status
        labels.append(f"status/{metadata['status']}")
        
        # Component (inferred from agent)
        component_map = {
            'ecosystem-analyzer': 'component/agents',
            'specs-analyst': 'component/infrastructure',
            'cli-implementer': 'component/cli',
            'performance-optimizer': 'component/performance',
            'docs-manager': 'component/docs'
        }
        if metadata.get('assignee') in component_map:
            labels.append(component_map[metadata['assignee']])
        
        return labels
    
    def format_issue_body(self, body, metadata):
        """Format issue body with migration metadata"""
        migration_header = f"""<!-- Migrated from /specs/ on {datetime.now().isoformat()} -->

**Migration Metadata:**
- Original File: `/specs/{metadata.get('original_filename', 'unknown')}`
- Created: {metadata.get('created', 'unknown')}
- Type: {metadata.get('type', 'unknown')}
- Priority: {metadata.get('priority', 'unknown')}
- Original Assignee: {metadata.get('assignee', 'unknown')}

---

"""
        return migration_header + body

def migrate_all_specs():
    """Main migration function"""
    migrator = SpecMigrator(
        repo=os.environ['GITHUB_REPOSITORY'],
        token=os.environ['GITHUB_TOKEN']
    )
    
    specs_dir = Path('/workspace/claude-code-forge/specs')
    migration_log = []
    
    for spec_file in specs_dir.glob('*.md'):
        if spec_file.name == 'migrate-specs-to-github-issues.md':
            continue  # Skip this migration plan itself
        
        try:
            metadata, body = migrator.parse_spec_file(spec_file)
            metadata['original_filename'] = spec_file.name
            
            title = spec_file.stem.replace('-', ' ').title()
            
            issue = migrator.create_github_issue(title, body, metadata)
            
            migration_log.append({
                'file': spec_file.name,
                'issue_number': issue['number'],
                'issue_url': issue['html_url'],
                'status': 'success'
            })
            
        except Exception as e:
            migration_log.append({
                'file': spec_file.name,
                'error': str(e),
                'status': 'failed'
            })
    
    return migration_log

if __name__ == '__main__':
    log = migrate_all_specs()
    print(f"Migrated {len([l for l in log if l['status'] == 'success'])} specifications")
    for entry in log:
        if entry['status'] == 'success':
            print(f"✅ {entry['file']} → Issue #{entry['issue_number']}")
        else:
            print(f"❌ {entry['file']} → {entry['error']}")
```

### Phase 3: Workflow Transition (High Priority)

**New Contributor Workflow**

1. **Issue Creation**
   - Use GitHub Issue templates for structured input
   - Automatic labeling based on template selection
   - Community can contribute and discuss requirements

2. **Issue Management**
   - Standard GitHub milestone and project board integration
   - Comment-based progress updates
   - Automatic status transitions via labels

3. **Implementation Workflow**
   - Link pull requests to issues automatically
   - Use issue templates for acceptance criteria tracking
   - Close issues automatically when PRs merge

4. **Agent Integration**
   - Update CLAUDE.md to reference GitHub Issues API
   - Create new `/issue` command for agent-driven issue creation
   - Maintain agent delegation for complex planning

### Phase 4: System Component Retirement (Medium Priority)

**specs-analyst Agent Evolution**
Transform from file-based to API-based operation:

```markdown
# Updated specs-analyst Agent (GitHub Issues Mode)

## Core Responsibilities

### Issue Management
- Create GitHub Issues via API calls
- Update issue status and metadata through labels
- Track progress without local file management
- Query GitHub Issues API for planning analysis

### API Integration
- Use GitHub CLI (gh) for issue operations
- Maintain same delegation principles
- Work with GitHub Projects for organization
- Support milestone and label management
```

**Command Migration**
Update slash commands to use GitHub API:

1. `/issue create` - Replace `/specs create`
2. `/issue review` - Replace `/specs review`
3. `/issue cleanup` - Replace `/specs cleanup` (close completed issues)
4. `/issue next` - Replace `/specs next`

**CLAUDE.md Updates**
```xml
<specification_management priority="CRITICAL">
<issue_protocol>
  <definition>Specifications are now managed as GitHub Issues with structured templates and comprehensive labeling</definition>
  
  <location>GitHub Issues API (repository-based)</location>
  
  <agent_delegation>
    <primary_agent>specs-analyst (PROACTIVELY use for issue management and planning)</primary_agent>
    <non_trivial_task_definition>Operations requiring complex planning, multi-component coordination, or strategic analysis</non_trivial_task_definition>
    <coordination>All issue lifecycle management MUST be delegated to specs-analyst agent for consistency</coordination>
    <commands>Use /issue commands: /issue create, /issue review, /issue cleanup, /issue next</commands>
  </agent_delegation>
  
  <issue_format>
    <structure>GitHub Issue templates with comprehensive metadata via labels</structure>
    <templates>feature_request, bug_report, documentation, refactoring, testing</templates>
    <labeling>type/priority/status/component/agent classification system</labeling>
  </issue_format>
  
  <operational_rules>
    <context_separation>Issue management happens OFF-CONTEXT via specs-analyst agent</context_separation>
    <api_integration>Uses GitHub CLI and API for all issue operations</api_integration>
    <community_collaboration>Issues visible and contributable by community</community_collaboration>
  </operational_rules>
</issue_protocol>
</specification_management>
```

### Phase 5: Migration Validation (Medium Priority)

**Pre-Migration Checklist**
- [ ] All 30 specification files cataloged and categorized
- [ ] GitHub repository labels configured
- [ ] Issue templates tested and validated
- [ ] Migration script tested on sample files
- [ ] Backup created of entire `/specs/` directory
- [ ] GitHub API permissions and rate limits confirmed

**Migration Execution**
- [ ] Run automated migration script
- [ ] Verify all issues created successfully
- [ ] Validate metadata preservation
- [ ] Test issue template functionality
- [ ] Confirm community accessibility

**Post-Migration Validation**
- [ ] All 30 issues created with proper labels
- [ ] Original content preserved and accessible
- [ ] Metadata correctly mapped to GitHub labels
- [ ] Issue templates functioning correctly
- [ ] Agent commands updated and tested
- [ ] CLAUDE.md updated with new protocols

**Migration Rollback Plan**
If critical issues arise:
1. Retain original `/specs/` directory as backup
2. Close all migrated GitHub Issues with migration label
3. Restore original specs-analyst agent
4. Re-enable original `/specs` commands
5. Document lessons learned for future migration attempt

## Benefits Analysis

### Immediate Benefits
1. **Community Accessibility**: Contributors can easily view and contribute to planning
2. **Standard Tooling**: Leverage mature GitHub Issues ecosystem
3. **Integration**: Native GitHub project management features
4. **Visibility**: Public roadmap and progress tracking
5. **Reduced Maintenance**: Eliminate custom tooling overhead

### Long-term Benefits
1. **Scalability**: GitHub handles growing issue volume efficiently
2. **Collaboration**: Multiple contributors can participate in planning
3. **Integration**: Seamless PR-to-issue linking and automation
4. **Analytics**: GitHub provides built-in metrics and reporting
5. **Standardization**: Align with open-source project norms

### Risk Mitigation
1. **Content Loss Prevention**: Complete backup and validation process
2. **Workflow Continuity**: Gradual transition with parallel systems
3. **Agent Adaptation**: Evolution rather than replacement
4. **Community Training**: Documentation and examples provided
5. **Rollback Capability**: Full restoration plan documented

## Resource Requirements

### Development Time
- **Template Creation**: 4-6 hours
- **Migration Script Development**: 8-12 hours
- **Agent Updates**: 6-8 hours
- **Testing and Validation**: 4-6 hours
- **Documentation Updates**: 2-4 hours
- **Total**: 24-36 hours

### Coordination Effort
- **Stakeholder Communication**: Notify all contributors
- **Timing Coordination**: Schedule during low-activity period
- **Backup Management**: Ensure data safety throughout process
- **Testing Coordination**: Validate with multiple use cases

## Success Metrics

### Quantitative Measures
- **Migration Completeness**: 100% of 30 specs successfully migrated
- **Metadata Preservation**: 100% of structured metadata retained
- **Template Adoption**: 90%+ of new issues use templates
- **Community Engagement**: Increase in issue creation and comments
- **System Reliability**: 0 data loss incidents

### Qualitative Measures
- **User Experience**: Improved ease of contributing to planning
- **Workflow Efficiency**: Reduced friction in issue management
- **Maintainability**: Simplified system with fewer custom components
- **Standardization**: Alignment with GitHub best practices
- **Community Growth**: Increased participation in project planning

## Implementation Timeline

### Immediate Actions (Critical Priority)
- Create GitHub Issue templates and labels
- Develop and test migration script
- Backup current specifications system
- Update agent definitions for GitHub API integration

### Short-term Actions (High Priority)
- Execute migration script and validate results
- Update CLAUDE.md and documentation
- Test new workflow with sample issues
- Train team on new GitHub Issues workflow

### Medium-term Actions (Medium Priority)
- Monitor community adoption and engagement
- Iterate on templates based on usage patterns
- Optimize agent performance with GitHub API
- Archive legacy specs system after validation period

### Long-term Actions (Low Priority)
- Analyze metrics and optimize workflow
- Expand templates based on project evolution
- Integrate with additional GitHub features
- Document best practices and lessons learned

## Dependencies and Constraints

### Technical Dependencies
- GitHub repository with Issues enabled
- GitHub CLI and API access
- Python environment for migration script
- Agent system capable of GitHub API integration

### Operational Constraints
- Migration must preserve all existing content
- Zero downtime requirement for planning activities
- Community notification and training needed
- Backward compatibility during transition period

### External Dependencies
- GitHub service availability and reliability
- GitHub API rate limits and permissions
- Community adoption and engagement
- Integration with existing development workflow

## Conclusion

This migration plan provides a comprehensive, risk-mitigated approach to transitioning from our custom specs system to GitHub Issues. The strategy preserves all existing content and metadata while modernizing our project management workflow and enabling greater community participation.

The phased approach ensures careful validation at each step, with complete rollback capabilities if issues arise. The enhanced GitHub Issues workflow will provide better visibility, collaboration, and integration with standard open-source development practices.

Success depends on careful execution of the automated migration, thorough testing of new workflows, and effective communication with the community throughout the transition process.