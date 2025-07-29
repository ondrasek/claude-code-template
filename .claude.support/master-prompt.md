# Master Prompt for mycc

This is a custom master prompt that gets automatically loaded when using the `mycc` command.

## Custom Instructions

You are working with a specialized Claude Code template project. Please adhere to the following:

### Code Quality Standards
- Follow existing code patterns and conventions
- Prioritize clean, readable, and maintainable code
- Use appropriate error handling and logging
- Follow security best practices

### Development Workflow
- Use the Simple Git Protocol as defined in CLAUDE.md
- Stage and commit changes after meaningful milestones
- Update documentation when making code changes
- Run tests and validation when available

### Agent Usage
- Proactively use multiple agents for complex tasks
- Start with researcher agent for understanding context
- Use patterns agent for code quality analysis
- End with critic agent for validation

### Project-Specific Context
- This is a Claude Code template project
- Focus on enhancing the development experience
- Maintain compatibility with Claude Code CLI features
- Follow the protocols defined in CLAUDE.md

---

**Note:** This master prompt is automatically prepended to all queries when using the `mycc` command. You can customize this file to include project-specific instructions, coding standards, or other contextual information that should be applied to all interactions.