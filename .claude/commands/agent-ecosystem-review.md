# /agent-ecosystem-review

TRIGGER: analyze agent ecosystem, optimize agents, review agent efficiency
FOCUS: fast agent ecosystem assessment and optimization
SCOPE: all agents in .claude/agents/ directory plus codebase analysis

ACTIONS:
1. **Intelligence Gathering Phase**: Run patterns, context, and researcher agents in parallel for codebase characterization and agent inventory analysis
2. **Critical Analysis Phase**: Run principles, critic, and performance agents in parallel for ecosystem assessment and validation
3. **Strategic Optimization Phase**: Run explorer, resolver, and ecosystem-analyzer agents for gap analysis and final recommendations (conditional based on complexity)

PARAMETERS:
--priority [critical|high|medium|low|all] (filter recommendations by priority)
--output [summary|detailed|roadmap|metrics] (output format, default: detailed)  
--dry-run (generate proposal without implementation suggestions)
--focus [gaps|redundancy|optimization|new-agents|performance|health] (specific analysis focus)
--depth [quick|standard|comprehensive] (analysis depth: 4-5, 6-8, or 8-10 agents)
--metrics (include ecosystem health metrics and performance assessment)  
--baseline (establish performance baseline for future comparisons)

AGENT_EXECUTION_PLAN:
**Phase 1 - Parallel Intelligence Gathering**:
- patterns: Analyze agent inventory (.claude/agents/) and codebase patterns for usage analysis
- context: Map system architecture, technology stack, and development complexity  
- researcher: Research current agent ecosystem best practices and emerging patterns

**Phase 2 - Parallel Critical Analysis**:
- principles: Evaluate current agents against design principles and architectural standards
- critic: Critical assessment of ecosystem strengths, weaknesses, and optimization opportunities
- performance: Analyze agent coordination efficiency and execution performance patterns

**Phase 3 - Strategic Optimization** (conditional based on depth):
- explorer: Generate alternative ecosystem configurations and optimization approaches (complex codebases)
- resolver: Resolve conflicts between optimization recommendations (enterprise codebases)
- ecosystem-analyzer: Synthesize all findings into comprehensive optimization proposal

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
# Standard comprehensive review
/agent-ecosystem-review

# Quick analysis for simple codebases (6 agents)
/agent-ecosystem-review --depth quick --output summary

# Deep analysis for complex ecosystems (9-10 agents)
/agent-ecosystem-review --depth comprehensive --metrics

# Focus on specific optimization areas
/agent-ecosystem-review --focus gaps --priority high

# Performance-focused review with baseline
/agent-ecosystem-review --focus performance --baseline --metrics
```

EXECUTION_BEHAVIOR:
- **Reduced Agent Count**: 6-10 agents total based on analysis depth (vs. 24+ agents previously)
- **Strategic Agent Selection**: Only spawn agents needed for requested analysis depth
- **Intelligent Phasing**: 3 phases with conditional agent spawning based on codebase characteristics
- **Parallel Execution**: Multiple agents per phase run simultaneously for efficiency
- **Comprehensive Analysis**: Maintains thorough ecosystem evaluation with optimized execution
- **Adaptive Depth**: Analysis complexity scales with codebase size and agent ecosystem maturity

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