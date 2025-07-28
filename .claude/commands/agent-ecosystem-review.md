# /agent-ecosystem-review

TRIGGER: analyze agent ecosystem, optimize agents, review agent efficiency
FOCUS: comprehensive agent ecosystem assessment and optimization
SCOPE: all agents in .claude/agents/ directory plus codebase analysis

ACTIONS:
1. invoke ecosystem-analyzer agent: orchestrate multi-agent ecosystem analysis
2. coordinate parallel agent clusters for comprehensive assessment:
   - patterns + axioms + context: codebase characterization
   - patterns + principles + critic: current agent ecosystem review
   - hypothesis + explorer + connector: gap analysis and optimization opportunities
   - resolver + critic: synthesis and validation of recommendations
3. generate structured optimization proposal with prioritized recommendations
4. provide implementation roadmap for approved changes

PARAMETERS:
--scope [agents|codebase|both] (analysis scope, default: both)
--priority [critical|high|medium|low|all] (filter recommendations by priority)
--output [summary|detailed|roadmap] (output format, default: detailed)  
--dry-run (generate proposal without implementation suggestions)
--focus [gaps|redundancy|optimization|new-agents] (specific analysis focus)

AGENT_DELEGATION:
Primary: ecosystem-analyzer (coordination and synthesis)
Codebase Analysis: patterns, axioms, context
Ecosystem Review: patterns, principles, critic  
Strategic Analysis: hypothesis, explorer, connector
Validation: resolver, critic

OUTPUT:
- Executive summary with alignment score and priority recommendations
- Detailed codebase profile and development patterns
- Current agent ecosystem assessment with usage patterns
- Prioritized optimization recommendations (HIGH/MEDIUM/LOW)
- Implementation roadmap with phases and success metrics
- Proposal ready for critic agent review and user approval

EXAMPLE:
/agent-ecosystem-review --scope both --priority high --output detailed

BEHAVIOR:
- Delegates ALL analysis to specialized agents off-context
- Coordinates parallel agent execution for maximum efficiency
- Synthesizes findings into actionable optimization proposal
- Provides strategic overview without overwhelming detail
- Creates proposal suitable for critic review and user decision-making

INTEGRATION:
- Results inform agent creation/modification decisions
- Recommendations can be implemented via todo agent
- Updates CLAUDE.md and agent combination patterns
- Tracks ecosystem evolution and optimization outcomes