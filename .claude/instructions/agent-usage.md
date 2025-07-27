# Agent Usage Guidelines

Claude Code should PROACTIVELY use specialized agents for better results:

## When to Use Each Agent

### ALWAYS use researcher agent when:
- User mentions unfamiliar tools, libraries, or frameworks
- Encountering errors or debugging issues
- Asked about best practices or implementation patterns
- Need to find examples or documentation
- Comparing different approaches or technologies

### PROACTIVELY use pattern agents when:
- `patterns`: Analyzing codebases for improvements
- `context`: User asks "how does X work" in this codebase
- `explore`: User needs multiple solution options
- `constraints`: Dealing with complex requirements
- `time`: Reviewing git history or predicting future needs

### MUST use principle agents when:
- `principles`: Reviewing architecture or design decisions
- `axioms`: User asks "why" or needs first-principles thinking
- `invariants`: Designing type systems or state machines
- `resolve`: Patterns and principles conflict

### AUTOMATICALLY use utility agents when:
- `whisper`: Code needs micro-improvements (use with BatchTool)
- `complete`: Finding and fixing TODOs, missing handlers
- `docsync`: After any feature addition or API change
- `hypothesis`: Debugging mysterious behavior
- `meta`: Noticing code generation opportunities
- `prompt-engineer`: Implementing agents in LangChain, CrewAI, or other frameworks
- `critic`: User asks "is X a good idea?" or proposes major changes

## Agent Collaboration Patterns

1. **Research First**: Use `researcher` to gather information, then apply other agents
2. **Pattern + Principle**: Use both to get complete analysis
3. **Document Always**: Follow any change with `docsync`
4. **Batch Operations**: Use `whisper` and `complete` with BatchTool
5. **Critical Review**: Major decisions should invoke `critic` for pushback

## Inter-Agent Communication
Agents with the `task` tool can invoke other agents:
- "Use the critic agent to evaluate this approach"
- "Use the researcher agent to find alternatives"
- Multiple agents can work in parallel
- Sub-agents return reports to the invoking agent

## Self-Criticism Pattern
Agents should invoke the critic for self-review:
- patterns: "Before suggesting this refactor... let me check with critic"
- meta: "This generator is complex... let me verify it's not over-engineering"
- principles: "SOLID says split this... but is that dogmatic?"
- researcher: "Found great reviews... what aren't they telling us?"

## Example Workflows

### Learning New Tool:
1. `researcher` - Gather docs, examples, best practices in parallel
2. `patterns` - Identify common usage patterns
3. `meta` - Create generators for boilerplate

### Code Review:
1. `context` - Understand the system
2. `patterns` + `principles` - Analyze from both angles
3. `resolve` - Handle any conflicts
4. `whisper` - Apply micro-improvements