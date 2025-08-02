---
description: "Create new slash command following guidelines with redundancy analysis and agent coordination"
argument-hint: "COMMAND_NAME [--description desc] [--category category] [--tools tools] [--dry-run]"
allowed-tools: ["Task", "Read", "Write", "Glob", "Grep"]
model: "sonnet"
---

# Command Creation

Create new slash command following guidelines from @.support/instructions/claude-commands-guidelines.md with comprehensive redundancy analysis and validation.

## Instructions

1. Parse $ARGUMENTS for command creation parameters:
   - COMMAND_NAME (required): Name for the new command (will be validated for naming conventions)
   - --description "text" (optional): Command description override
   - --category [workflow|development|project-management] (optional): Command category
   - --tools ["tool1","tool2"] (optional): Override default tool selection
   - --dry-run (optional): Preview command without creating file

2. Execute comprehensive parallel analysis clusters before creation:

**Phase 1: Ecosystem Analysis (MANDATORY before creation)**
- **Redundancy Detection Cluster**: foundation-patterns + foundation-context + specialist-options-analyzer (identify overlapping functionality, system understanding, alternative approaches)
- **Security Analysis Cluster**: foundation-criticism + specialist-constraint-solver (security validation, tool restrictions, permission boundaries)
- **Guidelines Compliance Cluster**: foundation-principles + specialist-code-cleaner (validate guidelines adherence, structure requirements)

**Phase 2: Command Design and Validation**
- **Design Strategy Cluster**: specialist-options-analyzer + foundation-research + foundation-principles (design alternatives, best practices research, principle compliance)
- **Implementation Planning Cluster**: specialist-stack-advisor + specialist-constraint-solver + foundation-context (technology guidance, implementation constraints, system integration)
- **Quality Assurance Cluster**: foundation-criticism + foundation-principles + specialist-test-strategist (quality validation, principle adherence, testing considerations)

3. Redundancy Analysis Requirements:
   - Compare proposed command against ALL existing commands in .claude/commands/
   - Identify functional overlaps, similar purposes, or duplicate capabilities
   - If redundancies found: STOP creation and notify user with specific overlap details
   - Suggest enhancing existing commands instead of creating new ones
   - Only proceed if command provides unique, non-overlapping functionality

4. Command Generation Process:
   - Validate command name follows kebab-case naming conventions
   - Generate compliant YAML frontmatter with appropriate tool restrictions
   - Create AI-optimized instruction content (NOT human documentation)
   - Include proper $ARGUMENTS usage and parameter handling
   - Add appropriate agent coordination patterns based on command complexity
   - Ensure security compliance with minimal necessary tool permissions

5. Validation and Confirmation:
   - Present generated command to user for review
   - Validate all guidelines compliance requirements
   - Create file in .claude/commands/ directory with proper naming
   - Confirm successful creation with usage guidance

## Error Handling

- **Naming Conflicts**: Check for existing command files and prevent overwrites
- **Guidelines Violations**: Validate against all guidelines requirements before creation
- **Security Issues**: Ensure appropriate tool restrictions and permission boundaries
- **Redundancy Detection**: Mandatory check for overlapping functionality with existing commands

## Output Format

Provide structured output including:
- **Redundancy Analysis Results**: Detailed analysis of overlap with existing commands
- **Command Design Summary**: Purpose, category, and tool requirements
- **Guidelines Compliance Check**: Verification of all guideline requirements
- **Generated Command Preview**: Complete command file content for review
- **Creation Confirmation**: Success status and usage instructions

If redundancies are detected, provide:
- **Overlap Details**: Specific commands with similar functionality
- **Enhancement Recommendations**: Suggestions for improving existing commands
- **Alternative Approaches**: Ways to achieve desired functionality without new command