# /agent-ecosystem-review

TRIGGER: analyze agent ecosystem, optimize agents, review agent efficiency
FOCUS: fast agent ecosystem assessment and optimization
SCOPE: all agents in .claude/agents/ directory plus codebase analysis

ACTIONS:
1. **Agent Inventory Analysis**: Run patterns agent to analyze all agents in .claude/agents/ for usage patterns and capabilities
2. **Codebase Context Analysis**: Run context agent to understand technology stack and development complexity
3. **Ecosystem Optimization**: Run ecosystem-analyzer agent to synthesize findings and generate optimization recommendations

PARAMETERS:
--priority [critical|high|medium|low|all] (filter recommendations by priority)
--output [summary|detailed|roadmap|metrics] (output format, default: detailed)  
--dry-run (generate proposal without implementation suggestions)
--focus [gaps|redundancy|optimization|new-agents|performance|health] (specific analysis focus)
--metrics (include ecosystem health metrics and performance assessment)  
--baseline (establish performance baseline for future comparisons)

AGENT_EXECUTION_PLAN:
**Phase 1 - Parallel Intelligence Gathering** (2-3 minutes):
- patterns: Analyze agent inventory (.claude/agents/) and identify usage patterns, redundancies, gaps
- context: Map codebase technology stack, complexity, and common development patterns

**Phase 2 - Optimization Synthesis** (1-2 minutes):
- ecosystem-analyzer: Process findings from Phase 1 to generate optimization recommendations

ENHANCED_OUTPUT:
- **Executive Summary**: Agent count, alignment score, and top 3 priority recommendations
- **Agent Inventory**: Current agents, usage frequency, and capability gaps identified by patterns agent
- **Codebase Profile**: Technology stack and development complexity mapped by context agent  
- **Optimization Recommendations**: Prioritized improvements (HIGH/MEDIUM/LOW) with implementation guidance
- **Quick Wins**: Immediate improvements that can be implemented in <30 minutes
- **Health Metrics**: Coverage score, redundancy index, and utilization efficiency
- **Implementation Roadmap**: Phase-based approach with clear success criteria

EXAMPLES:
```bash
# Quick ecosystem review (3-5 minutes)
/agent-ecosystem-review

# Focus on high-priority gaps only
/agent-ecosystem-review --priority high --output summary

# Quick wins identification
/agent-ecosystem-review --focus gaps --output summary

# Health check with metrics
/agent-ecosystem-review --output metrics
```

EXECUTION_BEHAVIOR:
- **Fast Execution**: 3-5 minute total runtime (vs. 30+ minutes previously)
- **Minimal Agent Spawning**: Maximum 3 agents total (vs. 24+ previously)
- **Parallel Phase 1**: patterns + context agents run simultaneously
- **Sequential Phase 2**: ecosystem-analyzer processes Phase 1 findings
- **Focus on Actionability**: Clear, implementable recommendations over exhaustive analysis

## Memory Integration

**Before Ecosystem Analysis**: Use `mcp__memory__search_nodes()` to check for:
- Previous ecosystem optimization outcomes and effectiveness patterns
- Historical agent performance data and usage trends
- Successful agent combination patterns and coordination strategies
- Ecosystem evolution patterns and optimization impact metrics

**After Ecosystem Analysis**: Store findings with `mcp__memory__create_entities()` and `mcp__memory__create_relations()`:
- Ecosystem health metrics and optimization recommendation effectiveness
- Agent coordination pattern evolution and performance improvements
- Cross-agent relationship patterns and synergy identification
- Optimization outcome tracking and long-term ecosystem sustainability

INTEGRATION:
- Results inform agent creation/modification decisions with historical context
- Recommendations implemented via todo agent with memory-informed prioritization
- Updates CLAUDE.md and agent combination patterns based on proven effectiveness
- Tracks ecosystem evolution and optimization outcomes with persistent knowledge
- Leverages cross-project ecosystem patterns for optimization insights

## Related Commands

- `/agent-audit` - Individual agent analysis with ecosystem-wide impact assessment
- `/agent-create` - New agent development informed by ecosystem gap analysis
- `/agent-guide` - Documentation updates reflecting ecosystem optimization outcomes