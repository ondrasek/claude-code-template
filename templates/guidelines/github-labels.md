# GitHub Labels Guidelines

## Overview

These guidelines establish standardized GitHub label conventions for ai-code-forge repository management. Based on GitHub's official standards and community best practices, these conventions prioritize clarity, consistency, and workflow optimization using space-delimited naming without prefixes.

## Core Principles

### 1. Space-Delimited Naming

Use GitHub's official space-delimited format for all multi-word labels:

```xml
<naming_convention priority="CRITICAL">
<standard>GitHub official format with spaces</standard>
<examples>
  ✅ "good first issue"
  ✅ "help wanted" 
  ✅ "human feedback needed"
  ❌ "good-first-issue"
  ❌ "help_wanted"
  ❌ "human-feedback-needed"
</examples>
<enforcement>Follow GitHub's native label format exactly</enforcement>
</naming_convention>
```

### 2. No Prefix System

Avoid namespace prefixes to maintain simplicity and GitHub standard compliance:

```xml
<prefix_policy priority="HIGH">
<approach>Direct descriptive labels without prefixes</approach>
<rationale>
  - Aligns with GitHub's official labels
  - Reduces visual clutter
  - Improves readability
  - Maintains ecosystem compatibility
</rationale>
<examples>
  ✅ "feat", "bug", "critical"
  ❌ "type: feat", "priority: critical", "status: open"
</examples>
</prefix_policy>
```

### 3. Semantic Clarity

Each label serves a distinct purpose without overlap:

```xml
<semantic_distinction priority="HIGH">
<type_clarity>
  - feat: New features and capabilities
  - enhancement: Improvements to existing features  
  - bug: Issues requiring fixes
  - fix: Pull requests that address bugs
</type_clarity>
<priority_hierarchy>
  - critical: Must implement now
  - high priority: Important but not critical
  - nice to have: Future improvements when time permits
</priority_hierarchy>
</semantic_distinction>
```

## Label Categories

### Type Labels

Core classification for issue and pull request categorization:

```xml
<type_labels priority="CRITICAL">
<definitions>
  - feat: New features and capabilities
  - enhancement: Improvements to existing functionality
  - bug: Defects and broken functionality
  - fix: Bug fixes and error corrections
  - docs: Documentation improvements and updates
  - refactor: Code restructuring without functionality changes
  - test: Test improvements and testing infrastructure
  - chore: Maintenance tasks and housekeeping
  - security: Security fixes and vulnerabilities
  - experiment: Experimental features and proof-of-concepts
</definitions>
<usage_patterns>
  - Use "feat" for entirely new functionality
  - Use "enhancement" for improving existing features
  - Use "bug" to identify issues, "fix" for solutions
  - Use "experiment" for prototype and research work
</usage_patterns>
</type_labels>
```

### Priority Labels

Three-tier priority system for workflow management:

```xml
<priority_labels priority="HIGH">
<hierarchy>
  - critical: System-breaking issues requiring immediate attention
  - high priority: Important issues affecting user experience
  - nice to have: Future improvements and optimizations
</hierarchy>
<assignment_criteria>
  - critical: Security vulnerabilities, system failures, blocking issues
  - high priority: User-facing bugs, performance issues, important features
  - nice to have: Convenience features, minor improvements, technical debt
</assignment_criteria>
<validation>
  ☐ Priority aligns with business impact
  ☐ Critical issues have clear urgency justification
  ☐ Nice to have items are truly optional
</validation>
</priority_labels>
```

### Workflow Labels

Process and coordination support labels:

```xml
<workflow_labels priority="MEDIUM">
<coordination>
  - dependencies: Requires completion of other issues first
  - human feedback needed: Agent requires human review and guidance
  - breaking change: Changes that may break existing functionality
  - migrated from specs: Historical tracking for legacy migration
</coordination>
<usage_guidelines>
  - Apply "dependencies" when issues block each other
  - Use "human feedback needed" for agent-human collaboration points
  - Mark "breaking change" for API changes or major modifications
  - Keep "migrated from specs" for historical context only
</usage_guidelines>
</workflow_labels>
```

### Community Labels

GitHub standard labels for community engagement:

```xml
<community_labels priority="MEDIUM">
<engagement>
  - good first issue: Beginner-friendly contribution opportunities
  - help wanted: Community contributions welcome
  - question: Requests for information or clarification
</engagement>
<resolution>
  - duplicate: Already exists or covered elsewhere
  - invalid: Invalid request or incorrect information
  - wontfix: Will not be implemented or fixed
</resolution>
<enforcement>Use GitHub's exact standard labels for maximum compatibility</enforcement>
</community_labels>
```

## Implementation Protocol

### Label Creation Standards

```xml
<creation_protocol priority="HIGH">
<naming_validation>
  ☐ Uses space-delimited format
  ☐ No prefix namespacing
  ☐ Clear, descriptive purpose
  ☐ Aligns with defined categories
  ☐ No semantic overlap with existing labels
</naming_validation>
<color_scheme>
  - Type labels: Distinct colors by functional area
  - Priority labels: Red spectrum (critical → orange → blue)
  - Workflow labels: Yellow/green spectrum for process
  - Community labels: GitHub default colors
</color_scheme>
</creation_protocol>
```

### Migration Strategy

```xml
<migration_approach priority="MEDIUM">
<phase_implementation>
  1. Audit current labels against new standards
  2. Create missing standardized labels
  3. Bulk relabel existing issues following new conventions
  4. Remove deprecated and redundant labels
  5. Update automation and workflows
</phase_implementation>
<change_tracking>
  - Document all label changes
  - Preserve historical context where needed
  - Maintain issue history integrity
</change_tracking>
</migration_approach>
```

### Quality Assurance

```xml
<quality_validation priority="MEDIUM">
<consistency_checking>
  ☐ All labels follow space-delimited naming
  ☐ No prefix namespacing applied
  ☐ Semantic clarity maintained across categories
  ☐ Priority hierarchy properly structured
  ☐ Community labels match GitHub standards
</consistency_checking>
<maintenance_procedures>
  - Regular label usage audit
  - Consistency verification
  - Community feedback integration
  - Evolution based on workflow needs
</maintenance_procedures>
</quality_validation>
```

## Usage Examples

### Correct Label Application

```xml
<usage_examples priority="MEDIUM">
<scenario_patterns>
  - New feature request: "feat" + "high priority" + "good first issue"
  - Existing feature improvement: "enhancement" + "nice to have"
  - Security vulnerability: "security" + "critical" + "breaking change"
  - Documentation update: "docs" + "help wanted"
  - Bug report: "bug" + "high priority" + "dependencies"
  - Bug fix PR: "fix" + critical/high priority/nice to have (matching bug priority)
</scenario_patterns>
<combination_guidelines>
  - Always include one type label
  - Add priority label when appropriate
  - Include workflow labels as needed
  - Apply community labels for engagement
</combination_guidelines>
</usage_examples>
```

### Integration Patterns

```xml
<integration_support priority="LOW">
<automation_compatibility>
  - GitHub Actions workflows
  - Issue template integration
  - Project board filtering
  - Search and discovery features
</automation_compatibility>
<tooling_integration>
  - Compatible with gh CLI commands
  - Supports automated labeling rules
  - Works with third-party GitHub tools
  - Maintains API compatibility
</tooling_integration>
</integration_support>
```

## Validation Framework

### Pre-Implementation Checklist

```xml
<implementation_checklist>
☐ Label naming follows space-delimited format
☐ No namespace prefixes applied
☐ Semantic purpose clearly defined
☐ Category assignment appropriate
☐ No overlap with existing labels
☐ Color scheme consistent with category
☐ Description accurately reflects purpose
☐ Compatible with GitHub standards
</implementation_checklist>
```

### Post-Implementation Verification

```xml
<verification_checklist>
☐ Labels applied consistently across issues
☐ Workflow integration functioning properly
☐ Automation rules updated appropriately
☐ Community engagement labels effective
☐ Priority system supporting workflow needs
☐ Documentation reflects actual usage
☐ Migration completed successfully
☐ Historical context preserved appropriately
</verification_checklist>
```

---

*These guidelines optimize GitHub label management for ai-code-forge repository workflows while maintaining GitHub ecosystem compatibility and community standards compliance.*