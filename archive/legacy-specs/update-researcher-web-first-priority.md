---
status: pending
type: enhancement
priority: high
assignee: researcher
created: 2025-07-28
impact: minor
---

# Update Researcher Agent to Prioritize Web Search/Fetch

## Problem Statement
The researcher agent currently relies heavily on LLM knowledge and MCP memory, but should prioritize fresh, current information from web sources to provide the most up-to-date and accurate research results.

## Required Changes

Update the researcher agent workflow to follow this priority order:

### 1. **HIGHEST PRIORITY: Web Search/Fetch**
- Always start with WebSearch for current information
- Use WebFetch for specific documentation, APIs, repositories
- Prefer fresh web content over cached/stored knowledge
- Essential for: technology updates, current best practices, recent documentation

### 2. **MEDIUM PRIORITY: Local Codebase Documents**  
- Search local repository files for project-specific context
- Use Grep and Read tools for existing implementations
- Check configuration files, documentation, existing patterns
- Essential for: understanding current project state, existing approaches

### 3. **LOWEST PRIORITY: LLM Built-in Knowledge**
- Use only as fallback when web/local sources unavailable
- Supplement web findings with general knowledge
- Provide context and explanations for web-sourced information
- Essential for: foundational concepts, general programming principles

## Implementation Requirements

### Update researcher.md with:
```markdown
## Research Priority Protocol (MANDATORY ORDER)

### Phase 1: Web-First Research (ALWAYS START HERE)
1. **WebSearch** - Current information, recent updates, best practices
2. **WebFetch** - Official documentation, API references, authoritative sources
3. Document findings in MCP memory for future reference

### Phase 2: Local Context Discovery  
1. **Grep/Glob** - Existing implementations, patterns, configurations
2. **Read** - Relevant project files, documentation, examples
3. Cross-reference with web findings for consistency

### Phase 3: Knowledge Synthesis (FINAL STEP)
1. Combine web findings with local context
2. Use LLM knowledge only to fill gaps or provide explanations
3. Present findings with clear source attribution
```

### Add Web-First Examples:
- Technology research: "Search for 'React 18 best practices 2024' before using built-in knowledge"
- Framework updates: "WebFetch official documentation before referencing cached information"
- Current trends: "Always web search for latest approaches, tools, recommendations"

## Benefits
- **Currency**: Always provides most recent information
- **Accuracy**: Reduces outdated or incorrect built-in knowledge
- **Authority**: Prioritizes official sources over general knowledge
- **Context**: Combines fresh research with project-specific needs

## Success Criteria
- [ ] Updated researcher.md with web-first priority protocol
- [ ] Clear workflow showing WebSearch → WebFetch → Local → LLM order
- [ ] Examples demonstrating web-first approach
- [ ] Documentation of when to use each research phase
- [ ] Integration with existing MCP memory storage

## Notes
This change ensures researcher agent provides the most current and accurate information by prioritizing fresh web sources over potentially outdated built-in knowledge.