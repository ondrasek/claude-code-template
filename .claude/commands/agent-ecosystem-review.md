# /agent-ecosystem-review

TRIGGER: analyze agent ecosystem, optimize agents, review agent efficiency
FOCUS: comprehensive agent ecosystem assessment and optimization
SCOPE: all agents in .claude/agents/ directory plus codebase analysis

ACTIONS:
1. **Codebase Intelligence Cluster**: Run patterns, axioms, context, and researcher agents in parallel for codebase characterization with research validation
2. **Ecosystem Quality Cluster**: Run patterns, principles, critic, and completer agents in parallel for current agent ecosystem review with completeness analysis  
3. **Strategic Analysis Cluster**: Run hypothesis, explorer, connector, and researcher agents in parallel for gap analysis with research-backed opportunities
4. **Validation & Synthesis Cluster**: Run resolver, critic, principles, and invariants agents in parallel for conflict resolution with principle validation
5. **Performance Assessment Cluster**: Run performance, time, constraints, and critic agents in parallel for ecosystem performance analysis with critical assessment
6. **Final Analysis**: Run ecosystem-analyzer agent to synthesize all findings into structured optimization proposal
7. **Documentation**: Run docs agent to update documentation with approved recommendations

PARAMETERS:
--priority [critical|high|medium|low|all] (filter recommendations by priority)
--output [summary|detailed|roadmap] (output format, default: detailed)  
--dry-run (generate proposal without implementation suggestions)
--focus [gaps|redundancy|optimization|new-agents] (specific analysis focus)

AGENT_EXECUTION_PLAN:
**Phase 1 - Parallel Codebase Analysis**:
- patterns: Analyze codebase patterns and technology stack
- axioms: Identify fundamental development principles  
- context: Map system architecture and interconnections
- researcher: Research codebase-specific development needs

**Phase 2 - Parallel Ecosystem Assessment**:
- patterns: Analyze existing agent usage patterns
- principles: Evaluate agents against design principles
- critic: Critical assessment of current ecosystem
- completer: Identify incomplete agent capabilities

**Phase 3 - Parallel Strategic Analysis**:
- hypothesis: Form theories about optimal agent ecosystem
- explorer: Generate alternative ecosystem configurations
- connector: Find cross-domain agent solutions
- researcher: Research best practices for agent ecosystems

**Phase 4 - Parallel Validation**:
- resolver: Resolve conflicts between optimization approaches
- critic: Final critical evaluation of proposals
- principles: Validate against architecture principles
- invariants: Ensure system constraints are maintained

**Phase 5 - Performance & Documentation**:
- performance: Assess agent coordination efficiency
- time: Analyze historical usage patterns
- constraints: Identify resource limitations
- docs: Update documentation with findings

**Phase 6 - Synthesis**:
- ecosystem-analyzer: Synthesize all findings into optimization proposal

ENHANCED_OUTPUT:
- Executive summary with alignment score and priority recommendations validated by critic + principles agents
- Detailed codebase profile and development patterns researched by researcher + patterns + context agents
- Current agent ecosystem assessment with usage patterns analyzed by patterns + completer + performance agents
- Prioritized optimization recommendations (HIGH/MEDIUM/LOW) validated by resolver + constraints + critic agents
- Implementation roadmap with phases and success metrics developed by time + completer + docs agents
- Comprehensive proposal ready for multi-agent validation (critic + principles + resolver) and user approval

EXAMPLE:
/agent-ecosystem-review --priority high --output detailed

EXECUTION_BEHAVIOR:
- **Command-Level Orchestration**: All agent spawning and coordination happens at command level
- **Parallel Execution**: Run multiple agents simultaneously for efficiency
- **Sequential Phases**: Execute phases in order, with each phase's results informing the next
- **Synthesis Focus**: Final ecosystem-analyzer agent synthesizes findings rather than coordinating other agents
- **No Agent-to-Agent Spawning**: Individual agents never spawn other agents - only commands do

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