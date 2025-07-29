# /agent-ecosystem-review

TRIGGER: analyze agent ecosystem, optimize agents, review agent efficiency
FOCUS: fast agent ecosystem assessment and optimization
SCOPE: all agents in .claude/agents/ directory plus codebase analysis

ACTIONS:
1. **Codebase Assessment Phase**: Run context agent to automatically determine codebase size, complexity, and technology stack for analysis depth selection
2. **Intelligence Gathering Phase**: Execute patterns and researcher agents in single message for true parallel execution of agent inventory and ecosystem best practices research (conditional agents based on codebase assessment)
3. **Critical Analysis Phase**: Execute principles, critic, and performance agents in single message for parallel ecosystem validation (scaled based on codebase complexity) 
4. **Strategic Optimization Phase**: Execute explorer, resolver, and ecosystem-analyzer agents in single message for parallel comprehensive optimization (enterprise codebases only)

PARAMETERS:
--priority [critical|high|medium|low|all] (filter recommendations by priority)
--output [summary|detailed|roadmap|metrics] (output format, default: detailed)  
--dry-run (generate proposal without implementation suggestions)
--focus [gaps|redundancy|optimization|new-agents|performance|health] (specific analysis focus)
--metrics (include ecosystem health metrics and performance assessment)  
--baseline (establish performance baseline for future comparisons)
--force-depth [quick|standard|comprehensive] (override automatic depth detection, use sparingly)

AGENT_EXECUTION_PLAN:
**Phase 1 - Codebase Assessment**:
- context: Analyze codebase size (file count, LoC), technology stack complexity, and architectural patterns to automatically determine analysis depth

**Phase 2 - Intelligence Gathering** (parallel execution in single message):
- patterns + researcher: Execute simultaneously via single message with multiple Task() calls
  - patterns: Analyze agent inventory (.claude/agents/) and high-priority codebase patterns 
  - researcher: Research ecosystem best practices (medium/large codebases only)

**Phase 3 - Critical Analysis** (parallel execution in single message):
- principles + critic + performance: Execute simultaneously via single message with multiple Task() calls
  - principles: Evaluate agents against design principles (all codebases)
  - critic: Critical ecosystem assessment (medium/large codebases)
  - performance: Agent coordination analysis (large codebases only)

**Phase 4 - Strategic Optimization** (parallel execution in single message):
- explorer + resolver + ecosystem-analyzer: Execute simultaneously via single message with multiple Task() calls
  - explorer: Generate alternative ecosystem configurations
  - resolver: Resolve optimization conflicts
  - ecosystem-analyzer: Synthesize findings into optimization proposal

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
# Automatic analysis (depth determined by codebase size/complexity)
/agent-ecosystem-review

# Focus on specific optimization areas with auto-depth
/agent-ecosystem-review --focus gaps --priority high

# Metrics-focused review with automatic scaling
/agent-ecosystem-review --output metrics --baseline

# Override automatic detection for testing (use sparingly)
/agent-ecosystem-review --force-depth quick --output summary

# Performance-focused review with smart scaling
/agent-ecosystem-review --focus performance --metrics
```

EXECUTION_BEHAVIOR:
- **Automatic Depth Detection**: Codebase size/complexity automatically determines analysis scope (4-10 agents)
- **Intelligent File Prioritization**: Focus analysis on core source files, configs, agents vs. generated/build files
- **Conditional Agent Spawning**: 4 phases with agents selected based on automated codebase assessment
- **True Parallel Execution**: Single message multi-Task() pattern ensures genuine concurrent agent processing
- **Batch Coordination**: Each phase executes all selected agents simultaneously, then synthesizes results
- **Scalable Analysis**: Analysis depth scales automatically with codebase characteristics
- **Smart Resource Allocation**: Comprehensive analysis for complex codebases, efficient analysis for simple ones
- **Performance Optimization**: 3-4 agents max per parallel batch to optimize Claude Code resource usage

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