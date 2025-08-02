---
description: Comprehensive research with multiple agents and external sources for thorough topic analysis.
argument-hint: Topic to research.
allowed-tools: Task, WebSearch, mcp__perplexity-research__perplexity_search, mcp__perplexity-research__perplexity_deep_research
---

# Comprehensive Research

Orchestrate multiple research agents and external sources to provide thorough analysis of any topic.

## Instructions

1. Parse $ARGUMENTS for research parameters:
   - topic (required): The main research topic to investigate
   - --focus (optional): Comma-separated list of specific focus areas
   - --time (optional): Time filter for search results (month, week, day)
   - --domains (optional): Comma-separated list of specific domains to include

2. Execute parallel research clusters with agent coordination
- `topic` (required): The main research topic to investigate
- `--focus` (optional): Comma-separated list of specific focus areas (e.g., "technical,market,risks")
- `--time` (optional): Time filter for search results (month, week, day)
- `--domains` (optional): Comma-separated list of specific domains to include

## Examples
```
/research "GraphQL performance optimization"
/research "Rust async patterns" --focus "performance,memory,best-practices"
/research "Docker security" --time "month" --domains "docker.com,security.org"
```

## Agent Orchestration
This command automatically spawns multiple research agents in parallel:
1. **foundation-research** (3+ instances): Multi-perspective research analysis
2. **foundation-criticism**: Critical analysis of findings
3. **foundation-conflicts**: Conflict resolution when contradictory information emerges
4. **specialist-options-analyzer**: Alternative approaches and solution exploration
5. **Perplexity Deep Research**: Real-time web search and comprehensive analysis

## Output Format
The command produces a structured research report containing:
- Executive summary with key findings
- Multiple perspectives on the topic
- Technical analysis and implementation details
- Risk assessment and considerations
- Alternative approaches and trade-offs
- Conflict resolution (if contradictory information found)
- Recent developments and current state
- Actionable recommendations

## Conflict Resolution Protocol
When research agents provide conflicting information:
1. **foundation-criticism** evaluates the quality and reliability of each perspective
2. **foundation-conflicts** mediates between competing viewpoints
3. Final report includes synthesized conclusions with documented reasoning