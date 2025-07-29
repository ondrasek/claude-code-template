# MCP Server Integration Protocol

Protocols for Memory Contextual Protocol (MCP) server integration to optimize research, memory, and specialized capabilities.

## Perplexity MCP Integration Protocol

### Agents Requiring Perplexity Integration

**HIGH PRIORITY - Advanced Research Intelligence**:
- **researcher**: Current trends, latest documentation, real-time technology updates
- **vulnerability-scanner**: Latest CVE discoveries, security advisories, threat intelligence  
- **compliance-checker**: Regulatory updates, enforcement actions, compliance interpretations
- **threat-modeling**: Current attack trends, threat actor intelligence, security case studies
- **connector**: Cross-domain solution discovery, innovative approaches from other fields

**MEDIUM PRIORITY - Enhanced Intelligence**:
- **hypothesis**: Research validation for debugging theories and experimental approaches
- **performance**: Latest optimization techniques, benchmark comparisons, performance research
- **time**: Historical analysis validation, technology evolution research, trend verification

### Agents Using Built-in WebSearch/WebFetch ONLY

**DOCUMENTATION & STANDARDS**:
- **docs**: Static documentation references, established standards, official documentation
- **guidelines-repo**: Technology stack documentation, established best practices, framework docs
- **guidelines-file**: File-specific technology guidelines, static reference materials
- **principles**: Established design principles, well-documented patterns, architectural standards

**ANALYSIS & SYNTHESIS**:
- **patterns**: Code analysis (no external research needed)
- **critic**: Internal validation and assessment (no external research needed)
- **completer**: Implementation completion (no external research needed)
- **whisper**: Code cleanup and formatting (no external research needed)

### Perplexity Usage Protocol

#### BEFORE Using Perplexity MCP:
1. **Memory First**: Check `mcp__memory__search_nodes()` for existing research
2. **Scope Validation**: Ensure query requires current/real-time information
3. **Fallback Ready**: Have WebSearch/WebFetch as backup for availability issues

#### Perplexity Query Optimization:
```javascript
// Structured query format for Perplexity
{
  query: "specific technical question with context",
  context: "technology_stack, timeframe, specific_focus",
  research_type: "latest_updates|security_intelligence|trend_analysis|technical_validation"
}
```

#### Research Integration Pattern:
```
1. agent: Initiate research need identification
2. → mcp__memory__search_nodes(): Check existing research
3. → mcp__perplexity__search(): Gather current intelligence if gaps exist
4. → WebSearch (fallback): Backup research if Perplexity unavailable
5. agent: Synthesize findings with validation
6. → mcp__memory__create_entities(): Store research outcomes
```

### Commands with Perplexity Enhancement

**SECURITY-FOCUSED COMMANDS**:
- `/security`: Enhanced threat intelligence and CVE research
- `/review`: Current security pattern validation and best practice research

**RESEARCH-INTENSIVE COMMANDS**:
- `/agent-ecosystem-review`: Latest agent architecture patterns and optimization research
- `/stacks`: Current technology trend analysis and framework comparison research

## Memory MCP Integration Protocol

### Universal Memory Integration

**ALL AGENTS** must integrate Memory MCP for persistent knowledge building:

#### Memory-First Research Protocol:
```
BEFORE any external research:
1. mcp__memory__search_nodes(query_context)
2. IF sufficient_knowledge: Use existing research
3. IF knowledge_gaps: Proceed with external research
4. AFTER research: mcp__memory__create_entities() + mcp__memory__create_relations()
```

#### Memory Storage Patterns:

**Entity Creation Pattern**:
```javascript
mcp__memory__create_entities([{
  name: "research_finding",
  entityType: "domain_specific_type", // security_finding, performance_pattern, etc.
  observations: ["finding_details", "validation_status", "implementation_context"]
}])
```

**Relationship Mapping Pattern**:
```javascript
mcp__memory__create_relations([{
  from: "finding_id",
  to: "implementation_id", 
  relationType: "informs|validates|conflicts_with|depends_on"
}])
```

### Agent-Specific Memory Patterns

**SECURITY INTELLIGENCE MEMORY** (vulnerability-scanner, threat-modeling, compliance-checker):
```javascript
// Store security findings with relationships
entities: ["vulnerability_pattern", "threat_scenario", "compliance_requirement"]
relations: ["mitigated_by", "exploits", "complies_with", "conflicts_with"]
```

**RESEARCH INTELLIGENCE MEMORY** (researcher, connector, hypothesis):
```javascript
// Store research outcomes with validation
entities: ["research_finding", "cross_domain_solution", "hypothesis_validation"]
relations: ["validates", "contradicts", "builds_on", "applies_to"]
```

**ARCHITECTURE INTELLIGENCE MEMORY** (context, patterns, principles):
```javascript
// Store architectural decisions with impact tracking
entities: ["architecture_decision", "pattern_application", "principle_violation"]  
relations: ["impacts", "implements", "violates", "optimizes"]
```

### Memory Query Optimization

#### Search Query Patterns:
```javascript
// Technology-specific research
mcp__memory__search_nodes("React performance optimization patterns")

// Cross-agent knowledge synthesis  
mcp__memory__search_nodes("security vulnerability + performance impact")

// Historical decision tracking
mcp__memory__search_nodes("authentication architecture decisions")

// Implementation outcome tracking
mcp__memory__search_nodes("refactoring effectiveness + technical debt")
```

#### Memory-Informed Agent Coordination:
```
1. Lead agent: Check memory for coordination patterns
2. → mcp__memory__search_nodes("successful agent combinations for [task_type]")
3. → Apply proven coordination patterns
4. → Execute agent cluster based on memory insights
5. → Store coordination outcomes for future optimization
```

## MCP Server Availability Handling

### Graceful Degradation Protocol

#### Perplexity Unavailable:
```
1. Detect Perplexity MCP unavailability
2. LOG: "Perplexity MCP unavailable, falling back to WebSearch"
3. Use WebSearch/WebFetch with enhanced query strategies
4. Continue normal agent operation
5. Store availability metrics for reliability assessment
```

#### Memory Unavailable:
```
1. Detect Memory MCP unavailability
2. LOG: "Memory MCP unavailable, operating without persistent memory"
3. Use session-only memory patterns
4. Execute agents normally without memory storage
5. Notify user of reduced context persistence
```

### MCP Health Monitoring

#### Availability Checks:
```javascript
// Check MCP server availability before critical operations
function checkMCPAvailability() {
  return {
    perplexity: testPerplexityConnection(),
    memory: testMemoryConnection()
  }
}
```

#### Performance Monitoring:
```javascript
// Track MCP server response times and reliability
{
  perplexity_response_time: "average_ms",
  memory_response_time: "average_ms", 
  availability_percentage: "uptime_percentage",
  fallback_frequency: "fallback_usage_rate"
}
```

## Integration with CLAUDE.md Protocols

### Agent Coordination Protocol Enhancement

**MCP-ENHANCED AGENT COORDINATION**:
```
1. **Memory-first research**: mcp__memory__search_nodes() before external research
2. **Intelligence-enhanced research**: mcp__perplexity__search() for current information
3. **Parallel agent clusters**: Memory-informed agent combinations
4. **Context delegation**: MCP-enhanced context synthesis
5. **Knowledge persistence**: mcp__memory__create_entities() + mcp__memory__create_relations()
```

### Simple Git Protocol Enhancement

**MCP-ENHANCED GIT PROTOCOL**:
```
1. Stage immediately: git add -A
2. Commit at milestones: With MCP-researched commit message validation
3. Always invoke git-tagger: With memory-informed release tag intelligence
4. Update CHANGELOG.md: Using memory-tracked feature evolution
5. Push immediately: git push origin main
```

### Memory Integration Override Enhancement

**ENHANCED MCP MEMORY USAGE**:
```
- Check mcp__memory__search_nodes() before all research activities
- Store mcp__memory__create_entities() for all significant findings
- Track mcp__memory__create_relations() for cross-domain insights
- Use memory for agent combination optimization patterns
- Leverage memory for persistent architectural decision tracking
```

## Error Handling and Fallback Strategies

### MCP Connection Failures

#### Perplexity Connection Failure:
```
1. Attempt mcp__perplexity__search()
2. ON_ERROR: Log failure and fallback to WebSearch
3. Use enhanced WebSearch queries to compensate
4. Continue agent operation without degradation
5. Report availability issue for monitoring
```

#### Memory Connection Failure:
```
1. Attempt mcp__memory__search_nodes()
2. ON_ERROR: Log failure and continue without persistent memory
3. Use session-only memory patterns
4. Store critical findings temporarily
5. Alert about reduced context persistence capabilities
```

### Quality Assurance Protocols

#### Research Quality Validation:
```
1. Compare MCP research results with WebSearch for validation
2. Cross-reference Perplexity findings with established sources
3. Validate memory retrieval accuracy against known facts
4. Flag inconsistent or conflicting research outcomes
5. Maintain research quality metrics for continuous improvement
```

## Implementation Guidelines

### Agent Modification Requirements

**REQUIRED for High-Priority Agents**:
1. Add MCP integration code with fallback handling
2. Implement memory-first research patterns
3. Add Perplexity query optimization for current intelligence
4. Update error handling for MCP unavailability
5. Add memory storage for research outcomes

**OPTIONAL for Medium-Priority Agents**:
1. Consider MCP integration for enhanced capabilities
2. Maintain compatibility with existing WebSearch/WebFetch patterns
3. Add memory integration for valuable findings
4. Implement gradual MCP adoption without breaking changes

### Testing and Validation

#### MCP Integration Testing:
```
1. Test agent functionality with MCP servers available
2. Test graceful degradation when MCP servers unavailable
3. Validate memory persistence and retrieval accuracy
4. Test Perplexity query optimization and result quality
5. Measure performance impact of MCP integration
```

#### Performance Benchmarking:
```
- Research query response times (Perplexity vs WebSearch)
- Memory storage and retrieval performance metrics
- Agent coordination efficiency with MCP integration
- Overall system performance impact assessment
- User experience improvement measurement
```

This protocol ensures optimal MCP server utilization while maintaining system reliability and performance through intelligent fallback strategies and memory-enhanced agent coordination.