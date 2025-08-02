# Claude Code Slash Command Guidelines

This document provides comprehensive guidelines, rules, and best practices for defining and implementing slash commands in Claude Code,
based on official Anthropic documentation and established community practices.

You must remember and follow the main principle:
command definitions are meant for Claude Code. They are instructions, NOT human readable documentation.

## Official Requirements

### File Structure and Organization
- **Location**: All slash commands MUST be stored in `.claude/commands/` directory
- **Format**: Commands are Markdown (.md) files
- **Naming**: File name determines command name (without .md extension)
- **Discovery**: Commands are automatically discovered by Claude Code

### Command File Structure
```markdown
---
description: Brief command description.
argument-hint: Expected argument format.
allowed-tools: Tool1, Tool2(tool arguments), Tool3
model: sonnet
---

# Command Title

Brief description of what the command does.

## Instructions

Detailed step-by-step instructions for Claude to follow.
Use $ARGUMENTS to reference passed parameters.

1. First step with $ARGUMENTS
2. Second step
3. Final step
```

## Frontmatter Configuration

### Supported Fields
- **`description`**: Brief command explanation for help text
- **`argument-hint`**: Describe expected arguments for user guidance
- **`allowed-tools`**: Array of permitted tools for command execution
- **`model`**: Select specific Claude model variant

### Example Frontmatter
```yaml
---
description: Execute git workflow with intelligent commit messages.
argument-hint: Optional custom commit message.
allowed-tools: Bash, Read, Write, Edit
model: sonnet
---
```

## Naming Conventions

### File Naming Rules
- Use lowercase with hyphens for multi-word commands
- Be descriptive and action-oriented
- Avoid spaces (converted to underscores in normalization)
- Examples:
  - `git-workflow.md`
  - `test-runner.md`
  - `deploy-production.md`

### Namespace Implementation
- Use subdirectories for logical grouping
- Format: `namespace/command-name.md`
- Examples:
  - `git/commit.md`
  - `testing/unit-tests.md`
  - `deployment/staging.md`

## Parameter Handling

### $ARGUMENTS Keyword
- Use `$ARGUMENTS` to reference passed parameters
- Placement affects substitution behavior
- Enable dynamic command behavior
- Example: `Create commit with message: $ARGUMENTS`

### Argument Processing
- Commands receive arguments as passed by user
- No automatic parsing - handle in command logic
- Consider validation and error handling
- Provide clear argument hints in frontmatter

## Best Practices

### Command Design
1. **Single Responsibility**: Each command should have one clear purpose
2. **Clear Documentation**: Include comprehensive descriptions and examples
3. **Error Handling**: Anticipate and handle common failure scenarios
4. **User Feedback**: Provide clear status and progress information
5. **Idempotency**: Commands should be safe to run multiple times

### Content Structure
1. **Title**: Clear, descriptive command title
2. **Description**: Brief explanation of command purpose
3. **Instructions**: Step-by-step implementation details
4. **Examples**: Usage examples and expected outcomes
5. **Error Handling**: Instructions for common error scenarios

### Tool Integration
1. **Selective Tools**: Only include necessary tools in `allowed-tools`
2. **Tool Coordination**: Consider tool interaction patterns
3. **Agent Delegation**: Use Task tool for complex operations
4. **Parallel Execution**: Leverage multi-tool capabilities when appropriate

## Security Considerations

### Permission Model
- Commands inherit Claude Code session permissions
- `allowed-tools` restricts available functionality
- Project commands accessible to all team members
- Personal commands isolated to user scope

### Safety Guidelines
1. **Tool Restrictions**: Use `allowed-tools` to limit command capabilities
2. **Input Validation**: Validate arguments before processing
3. **Destructive Operations**: Require explicit confirmation
4. **Sensitive Data**: Avoid including secrets or credentials

## Integration Patterns

### Git Workflow Integration
- Follow repository Git Protocol requirements
- Use specialist agents for complex operations
- Maintain clean commit history
- Automate release management

### Agent Coordination
- Delegate complex tasks to appropriate specialist agents
- Use parallel agent execution for efficiency
- Maintain context window optimization
- Follow agent coordination protocols

### Project Integration
- Align with project structure and conventions
- Respect existing workflows and processes
- Integrate with CI/CD pipelines
- Support team collaboration patterns

## Command Categories

### Workflow Commands
- Git operations and release management
- Build and deployment automation
- Testing and quality assurance
- Documentation generation

### Development Commands
- Code generation and scaffolding
- Refactoring and optimization
- Debugging and troubleshooting
- Environment setup and configuration

### Project Management Commands
- Task tracking and management
- Progress reporting and analysis
- Team coordination and communication
- Project planning and estimation

## Examples and Templates

### Basic Command Template
```markdown
---
description: "Brief description of command functionality"
argument-hint: "Expected argument format"
---

# Command Name

Brief description of what this command accomplishes.

## Instructions

1. Step-by-step instructions for Claude
2. Use $ARGUMENTS where parameters are needed
3. Include error handling and validation
4. Provide clear user feedback
```

### Advanced Command Template
```markdown
---
description: "Advanced command with tool restrictions"
argument-hint: "Complex argument structure"
allowed-tools: ["Bash", "Read", "Write", "Task"]
model: "sonnet"
---

# Advanced Command

Comprehensive description with examples and use cases.

## Prerequisites

- Required environment setup
- Dependencies and tools
- Permission requirements

## Instructions

1. Validation and error checking
2. Main command logic with $ARGUMENTS
3. Agent coordination if needed
4. Status reporting and cleanup

## Error Handling

- Common failure scenarios
- Recovery procedures
- User guidance for resolution
```

## Maintenance and Evolution

### Version Control
- Include commands in repository version control
- Document changes in commit messages
- Use semantic versioning for major command updates
- Maintain backward compatibility when possible

### Documentation Updates
- Keep command descriptions current
- Update examples and use cases
- Maintain consistency across command suite
- Regular review and optimization

### Community Contribution
- Follow established patterns and conventions
- Contribute improvements back to community
- Share successful command patterns
- Participate in best practice discussions

## References

- Official Anthropic Claude Code Documentation
- Community Best Practices and Patterns
- Professional Command Suite Implementations
- Claude Code CLI Reference Guide