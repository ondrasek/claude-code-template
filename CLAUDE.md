# CLAUDE.md - AI Operational Instructions

## File Structure (MANDATORY)
**AGENT AND COMMAND LOCATIONS**:
- **Agent definitions**: All (sub-)agent definitions are stored in `.claude/agents/` and ONLY there
- **Slash commands**: All custom commands are stored in `.claude/commands/` and ONLY there
- **Never search elsewhere**: When looking for agents or commands, use only these directories

## Agent Coordination Protocol (MANDATORY)
**PROACTIVE AGENT USAGE - USE AGENTS WITHOUT USER REQUESTS**:
- Claude Code MUST use agents proactively beyond built-in conservative defaults
- NEVER wait for user to ask for agents - invoke based on task context automatically
- Force minimum 3+ agents for non-trivial requests (override built-in agent usage)
- Agents must keep main context window tidy, optimized and neat

Examples:
  - User: "This code looks messy" → Auto-invoke: patterns + whisper + critic
  - User: "How should I structure this?" → Auto-invoke: guidelines-repo + explorer + principles
  - User shows error message → Auto-invoke: researcher + hypothesis + patterns

**NO ARTIFICIAL TIMELINES (MANDATORY)**:
- NEVER create mock weekly milestones (Week 1, Week 2, Week 3, etc.) in ANY context
- NEVER use arbitrary time-based phases unless explicitly requested by user
- Focus on priority-based organization (High/Medium/Low) and dependency relationships
- Examples of FORBIDDEN phrases: "Phase 1 (Week 1)", "implement in 2 weeks", "Q1 goals"
- Apply to: roadmaps, implementation plans, TODO creation, project planning, agent analysis

Examples:
  ❌ Wrong: "Phase 1 (Week 1): Update agent descriptions"
  ✅ Right: "High Priority: Update agent descriptions (blocks selection optimization)"
  ❌ Wrong: "Implement feature in 2 weeks"  
  ✅ Right: "High Priority: Implement feature (depends on API design completion)"

**EXECUTION PROTOCOL**:
1. **Memory-first research**: Check `mcp__memory__search_nodes()` before web searches
   Example: Before web searching "React best practices" → First check memory for previous React decisions
2. **Parallel agent clusters**: Use multiple agents simultaneously when possible
   Example: Single message with 3+ Task() calls running researcher + patterns + critic simultaneously  
3. **Context delegation**: Complex analysis happens in agent context, not main context
   Example: Don't analyze 50 files in main context → Use patterns agent to analyze and summarize
4. **Automatic selection**: Match agent combinations to user request patterns
   Example: "Why is this slow?" → Auto-select researcher + hypothesis + patterns (not just one agent)

## Agent Combination Patterns (MANDATORY)

**Analysis Requests** (`"analyze X"`, `"review Y"`, `"examine Z"`):
- **Quality Cluster**: researcher + patterns + principles + critic
- **Deep Analysis Cluster**: context + axioms + hypothesis + completer
- Flow: Research → Pattern detection → Principle application → Context analysis → Hypothesis validation

**Architecture/Design Questions** (`"design X"`, `"architect Y"`, `"structure Z"`):
- **Design Cluster**: researcher + explorer + constraints + principles + critic
- **Validation Cluster**: resolver + invariants + context + completer
- Flow: Research approaches → Generate alternatives → Apply constraints → Validate design → Complete implementation

**Debugging Investigations** (`"why does X"`, `"strange behavior"`, `"not working"`):
- **Investigation Cluster**: researcher + hypothesis + patterns + critic
- **Resolution Cluster**: resolver + context + constraints + completer
- Flow: Research issues → Form hypotheses → Pattern matching → Critical validation → Resolution synthesis

**Code Quality Tasks** (`"improve X"`, `"refactor Y"`, `"optimize Z"`):
- **Quality Enhancement Cluster**: patterns + principles + whisper + critic
- **Performance Optimization Cluster**: performance + constraints + time + resolver
- Flow: Pattern analysis → Principle application → Performance optimization → Critical validation

**Feature Implementation** (`"add X"`, `"implement Y"`, `"create Z"`):
- **Implementation Cluster**: researcher + patterns + completer + docs
- **Integration Cluster**: context + constraints + resolver + critic
- Flow: Research implementation → Pattern alignment → Feature completion → Documentation → Integration validation

**Decision Making** (`"options for X"`, `"approaches to Y"`, `"choose between Z"`):
- **Options Generation Cluster**: explorer + researcher + hypothesis + context
- **Decision Validation Cluster**: constraints + resolver + critic + principles
- Flow: Generate alternatives → Research viability → Constraint analysis → Decision resolution

**System Understanding** (`"how does X work"`, `"explain Y"`, `"show me Z"`):
- **Comprehension Cluster**: context + patterns + researcher + critic
- **Knowledge Synthesis Cluster**: axioms + principles + completer + docs
- Flow: System mapping → Pattern identification → Research validation → Knowledge documentation

**Security Analysis** (`"security review"`, `"vulnerability assessment"`, `"threat analysis"`):
- **Security Assessment Cluster**: vulnerability-scanner + threat-modeling + compliance-checker + researcher
- **Risk Validation Cluster**: critic + constraints + resolver + principles
- Flow: Vulnerability scanning → Threat modeling → Compliance checking → Risk assessment → Validation

**Performance Optimization** (`"optimize performance"`, `"improve speed"`, `"reduce latency"`):
- **Performance Analysis Cluster**: performance + time + constraints + patterns
- **Optimization Implementation Cluster**: resolver + completer + critic + docs
- Flow: Performance measurement → Constraint analysis → Pattern optimization → Implementation validation

**Agent Ecosystem Analysis** (`"optimize agents"`, `"review agent ecosystem"`, `"analyze agent efficiency"`):
- **Comprehensive Analysis**: Use /agent-ecosystem-review command with 6-phase parallel cluster execution
- **Manual Combination**: ecosystem-analyzer + patterns + axioms + context + principles + critic + hypothesis + explorer + connector + resolver
- Flow: Orchestrate analysis → Characterize codebase → Assess current agents → Identify gaps → Generate proposals → Validate recommendations

## Agent Ecosystem Management Protocol (MANDATORY)
**ECOSYSTEM OPTIMIZATION**: Use ecosystem-analyzer agent and /agent-ecosystem-review command for systematic agent ecosystem assessment and optimization.

## Agent Ecosystem Performance Characteristics (MANDATORY)

**CLUSTER COORDINATION EFFICIENCY**:
- **Parallel Execution**: Always prefer parallel agent clusters over sequential execution for independent tasks
- **Resource Optimization**: Monitor agent cluster performance using performance + time + constraints combination
- **Dependency Management**: Sequence agent clusters only when output dependencies exist between phases
- **Context Window Management**: Use agent delegation to keep main context clean and focused

**ECOSYSTEM HEALTH METRICS**:
- **Coverage Score**: Percentage of development tasks well-supported by existing agents (target: >85%)
- **Utilization Efficiency**: Balance between underused and overloaded agents (target: 60-80% average utilization)
- **Redundancy Index**: Minimal overlap between agent capabilities (target: <15% redundancy)
- **Response Quality**: Consistent high-quality outputs across agent combinations (target: >90% satisfaction)

**OPTIMIZATION TRIGGERS**:
- **Usage Pattern Misalignment**: When frequently needed capabilities require manual work instead of agent assistance
- **Performance Degradation**: When agent coordination takes longer than direct implementation
- **Quality Inconsistency**: When agent outputs vary significantly in quality or completeness
- **Resource Waste**: When multiple agents provide overlapping capabilities without added value

**BEST PRACTICE PATTERNS**:
- **Start with Research**: researcher agent should typically be first in complex analysis clusters
- **End with Validation**: critic agent should typically be last for quality assurance
- **Apply Principles**: principles agent ensures consistency with architectural decisions
- **Complete Thoroughness**: completer agent ensures no missing elements in implementations
- **Resolve Conflicts**: resolver agent handles competing recommendations or approaches

**Ecosystem Analysis Triggers**:
- **Automatic**: When agent usage patterns suggest misalignment with codebase needs
- **Periodic**: Regular ecosystem health assessments (quarterly or after major changes)
- **Manual**: User requests with "optimize agents", "review agent ecosystem", "analyze agent efficiency"
- **Change-driven**: After significant codebase changes affecting agent utility

**Core Tools**:
- **ecosystem-analyzer agent**: Orchestrates multi-agent analysis for comprehensive ecosystem evaluation
- **/agent-ecosystem-review command**: Provides structured interface for ecosystem analysis with configurable parameters

**Analysis Phases**:
1. **Codebase Intelligence Cluster**: patterns + axioms + context + researcher → Technology stack, complexity, development patterns, research validation
2. **Ecosystem Quality Cluster**: patterns + principles + critic + completer → Current agents, usage patterns, capabilities, completeness analysis
3. **Strategic Analysis Cluster**: hypothesis + explorer + connector + researcher → Missing capabilities, optimization opportunities, research-backed strategies
4. **Validation & Synthesis Cluster**: resolver + critic + principles + invariants → Conflict resolution, principle validation, constraint maintenance
5. **Performance Assessment Cluster**: performance + time + constraints + critic → Ecosystem efficiency, resource optimization, critical performance assessment
6. **Final Synthesis**: ecosystem-analyzer → Comprehensive optimization proposal with executive summary and implementation roadmap

**Command Usage Examples**:
- `/agent-ecosystem-review --priority high --output detailed` (comprehensive high-priority analysis)
- `/agent-ecosystem-review --focus gaps --output summary` (focus on missing capabilities)
- `/agent-ecosystem-review --dry-run --priority critical` (proposal without implementation)
- `/agent-ecosystem-review --focus optimization --output roadmap` (optimization-focused with implementation timeline)
- `/agent-ecosystem-review --focus redundancy --priority medium` (redundancy elimination analysis)
- `/agent-ecosystem-review --focus new-agents --output detailed` (new agent recommendations)

**Integration Points**:
- **Memory Integration**: Store analysis results and optimization outcomes for trend tracking using `mcp__memory__create_entities()` and `mcp__memory__create_relations()`
- **Documentation Updates**: Automatically update CLAUDE.md agent combinations, README.md features, and CHANGELOG.md based on findings
- **Performance Tracking**: Monitor agent cluster effectiveness, resource utilization, and coordination efficiency
- **Continuous Improvement**: Track implementation success, refine methodology, and update optimization patterns
- **Cross-Project Learning**: Build knowledge base of effective agent combinations and ecosystem patterns for future optimizations

## Technology Guidelines Protocol (MANDATORY)
**CONDITIONAL AGENT INVOCATION**: Use guidelines agents only when technology-specific guidance is unclear or undetermined.

**File-Level Guidelines**: Use `guidelines-file` agent before modifying any file when technology patterns are unclear
**Repository-Level Guidelines**: Use `guidelines-repo` agent for architecture decisions when stack context is undetermined

**Detection Logic**: Both agents reference @.support/instructions/stack-mapping.md for centralized technology detection rules

Examples:
  - Modify Python file with unclear patterns → Use guidelines-file agent → Apply guidelines → Follow Simple Git Protocol
  - Architecture decision needed → Use guidelines-repo agent → Make informed choice → Follow Simple Git Protocol

## Memory Integration Override
**MCP MEMORY USAGE**: Project-specific memory behavior:
- Prioritize memory lookup before web searches (efficiency override)
- Store agent combination success patterns for this project
- Preserve architectural decisions across sessions
- Track parallel agent cluster performance data
- Use `mcp__memory__search_nodes()` before web research
- Store findings with `mcp__memory__create_entities()` and `mcp__memory__create_relations()`

Examples:
  - Before researching: `mcp__memory__search_nodes("React architecture decisions")` → Use findings → Follow Simple Git Protocol
  - After analysis: `mcp__memory__create_entities([{name: "Component Pattern", type: "decision"}])` → Store new pattern → Follow Simple Git Protocol
  - Link decisions: `mcp__memory__create_relations([{source: "pattern_id", target: "decision_id"}])` → Apply relationships → Follow Simple Git Protocol

## Simple Git Protocol (MANDATORY)
**EXECUTE AFTER EVERY CHANGE - NO EXCEPTIONS**:
1. **Stage immediately**: `git add -A` after any file modification
2. **Commit at milestones**: When any meaningful task is complete
3. **Always invoke git-tagger**: Use git-tagger agent after EVERY commit to evaluate for tags
4. **Update CHANGELOG.md**: When git-tagger creates release tags, update CHANGELOG.md with release notes
5. **Push immediately**: `git push origin main` after every commit

**Error Recovery**: When git operations fail, use git-troubleshooter agent for systematic diagnosis and resolution.

**Agent coordination**: All agents MUST follow this protocol. Git-tagger agent runs autonomously after every commit.

Example sequence:
  ```bash
  # After modifying src/components/Header.tsx
  git add -A
  git commit -m "Add dark mode toggle to header component"
  # Auto-invoke git-tagger agent here
  # If git-tagger creates v1.2.0 tag → Update CHANGELOG.md with release notes
  git push origin main
  # If any step fails → Auto-invoke git-troubleshooter agent
  ```

## Documentation Protocol (MANDATORY)
**EXECUTE WITH EVERY CODE CHANGE - NO EXCEPTIONS**:
1. **Same commit rule**: Documentation updates in same commit as code changes
2. **Always check**: README.md, CHANGELOG.md, API docs, CLAUDE.md for needed updates
3. **Update immediately**: New features, API changes, configuration changes
4. **Use docs agent**: Invoke docs agent for documentation maintenance

Examples:
  - Add new API endpoint → Update API docs + README.md → Follow Simple Git Protocol
  - New agent created → Use docs agent to update CLAUDE.md + CHANGELOG.md → Follow Simple Git Protocol
  - Configuration change → Update README.md setup instructions → Follow Simple Git Protocol
  - Feature complete → README.md usage section + CHANGELOG.md entry → Follow Simple Git Protocol

## TODO Protocol (MANDATORY)
**USE TODO AGENT FOR ALL TASK MANAGEMENT - NO CONTEXT CLUTTER**:
1. **Agent delegation**: Use todo agent for creating/tracking tasks
2. **Clean context**: No TODO tracking in main conversation flow
3. **Deferred actions**: TODOs represent future work, not current progress
4. **File management**: Agent handles `.support/todos/` directory autonomously
5. **Git integration**: After TODO files created → Follow Simple Git Protocol

**Agent invocation**: `Task: "Create TODO for X" (subagent_type: todo)`

Examples:
  - Create project TODOs → Use todo agent → Follow Simple Git Protocol
  - Update TODO status → Modify .support/todos/file.md → Follow Simple Git Protocol

---

## PROTOCOL ENFORCEMENT REMINDER

**AFTER EVERY FILE MODIFICATION - NO EXCEPTIONS:**
Follow Simple Git Protocol (see Simple Git Protocol section above)

**Cross-reference**: All protocols above reference Simple Git Protocol - follow it consistently.

