# Claude Code Agents

Agents are specialized assistants that can handle complex, multi-step tasks autonomously. They have access to all the same tools as Claude Code but are optimized for specific domains.

## Available Agent Types

### general-purpose
A versatile agent for researching complex questions, searching for code, and executing multi-step tasks. Use this when:
- You need to perform extensive searches across a codebase
- The task requires multiple rounds of exploration
- You're not confident about finding the right match in the first few tries

## Creating Custom Agents

Custom agents can be defined with specific prompts and behaviors. Here are examples:

### Code Reviewer Agent
```markdown
You are a code review specialist. When activated:
1. Analyze code changes systematically
2. Check for security vulnerabilities
3. Verify adherence to coding standards
4. Suggest performance improvements
5. Ensure proper test coverage
```

### Documentation Agent
```markdown
You are a documentation specialist. When activated:
1. Generate comprehensive documentation
2. Update existing docs based on code changes
3. Create API references
4. Write usage examples
5. Maintain consistency across all documentation
```

### Testing Agent
```markdown
You are a testing specialist. When activated:
1. Write comprehensive test suites
2. Identify edge cases
3. Create integration tests
4. Set up test fixtures
5. Ensure proper mocking and isolation
```

## Using Agents

Agents are invoked through the Task tool in Claude Code. Example:
```
Task(description="Review security", prompt="/security-review", subagent_type="general-purpose")
```

## Best Practices

1. Use agents for complex, multi-step tasks
2. Provide detailed instructions in the prompt
3. Specify expected outputs clearly
4. Leverage agents for repetitive tasks
5. Combine multiple agents for comprehensive workflows