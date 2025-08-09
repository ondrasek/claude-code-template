---
description: Intelligently refine GitHub Issues through automated research, critical questioning, and elaboration.
argument-hint: <issue number|URL> (required)
allowed-tools: Task
---

# GitHub Issue Refinement

Provide intelligent refinement for GitHub Issues through automated research, elaboration, critical questioning, and discussion capabilities.

## Instructions

1. Use Task tool to delegate to github-issues-workflow agent:
   - Fetch and analyze the specified issue content and context
   - Research related codebase components and dependencies
   - Generate critical questions to clarify requirements and scope
   - Elaborate on technical implementation considerations
   - Identify potential edge cases, constraints, and risks
   - Suggest improvements to acceptance criteria
   - Analyze integration points and system dependencies
   - Provide refinement recommendations without making changes

2. Interactive refinement session includes:
   - **Context Analysis**: Review current issue state and related components
   - **Critical Questioning**: Generate targeted questions to expose gaps
   - **Technical Elaboration**: Expand on implementation approaches and constraints
   - **Risk Assessment**: Identify potential issues and mitigation strategies
   - **Acceptance Criteria Enhancement**: Suggest specific, measurable outcomes
   - **Dependency Mapping**: Analyze integration points and prerequisites

3. Output format:
   - **Current State Analysis**: Summary of existing issue content
   - **Critical Questions**: Targeted questions to improve clarity
   - **Technical Considerations**: Implementation approaches and constraints
   - **Suggested Refinements**: Specific improvements to issue content
   - **Action Recommendations**: Next steps for issue resolution

## Usage Examples

```bash
/issue:refine 90
/issue:refine https://github.com/ondrasek/claude-code-forge/issues/90
```

## Safety Features

- **Read-Only Analysis**: No automated modifications to issues
- **Human Review Required**: All refinements require manual approval
- **Context Preservation**: Maintains original issue intent while enhancing clarity
- **Recursive Prevention**: Does not trigger additional automated workflows