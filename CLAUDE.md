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

## Agent Coordination Best Practices (MANDATORY)

**EFFECTIVE CLUSTER PATTERNS**:
- **Start with Research**: researcher agent should typically be first in complex analysis clusters
- **End with Validation**: critic agent should typically be last for quality assurance
- **Apply Principles**: principles agent ensures consistency with architectural decisions
- **Complete Thoroughness**: completer agent ensures no missing elements in implementations
- **Resolve Conflicts**: resolver agent handles competing recommendations or approaches
- **Context Window Management**: Use agent delegation to keep main context clean and focused

## Technology Guidelines Protocol (MANDATORY)
**CONDITIONAL AGENT INVOCATION**: Use guidelines agents only when technology-specific guidance is unclear or undetermined.

**File-Level Guidelines**: Use `guidelines-file` agent before modifying any file when technology patterns are unclear
**Repository-Level Guidelines**: Use `guidelines-repo` agent for architecture decisions when stack context is undetermined

**Detection Logic**: Both agents reference @.support/instructions/stack-mapping.md for centralized technology detection rules

Examples:
  - Modify Python file with unclear patterns → Use guidelines-file agent → Apply guidelines → Follow Simple Git Protocol
  - Architecture decision needed → Use guidelines-repo agent → Make informed choice → Follow Simple Git Protocol

## MCP Server Integration Protocol (MANDATORY)
**ENHANCED RESEARCH & MEMORY**: Follow @.support/instructions/mcp-protocol.md for comprehensive MCP server integration.

**PERPLEXITY MCP INTEGRATION**:
- **High Priority Agents**: researcher, vulnerability-scanner, compliance-checker, threat-modeling, connector
- **Research Pattern**: Memory-first → Perplexity → WebSearch fallback → Store results
- **Use for**: Current trends, security intelligence, regulatory updates, cross-domain solutions

**MEMORY MCP INTEGRATION**:
- **Universal Usage**: ALL agents must use memory-first research patterns
- **Before Research**: `mcp__memory__search_nodes()` to check existing knowledge
- **After Research**: `mcp__memory__create_entities()` + `mcp__memory__create_relations()` to store findings
- **Graceful Degradation**: Continue operation if MCP servers unavailable

**MCP-ENHANCED EXECUTION PROTOCOL**:
1. **Memory-first research**: `mcp__memory__search_nodes()` before external research
2. **Intelligence-enhanced research**: `mcp__perplexity__search()` for current information  
3. **Parallel agent clusters**: Memory-informed agent combinations based on proven patterns
4. **Context delegation**: MCP-enhanced context synthesis with persistent knowledge
5. **Knowledge persistence**: Store all significant findings for cross-session intelligence

Examples:
  - Before researching: `mcp__memory__search_nodes("React architecture decisions")` → Use findings → Follow Simple Git Protocol
  - Security research: `mcp__perplexity__search("latest CVE for React SSR")` → Validate → Store → Follow Simple Git Protocol
  - After analysis: `mcp__memory__create_entities([{name: "Security Pattern", type: "vulnerability_finding"}])` → Follow Simple Git Protocol
  - Link knowledge: `mcp__memory__create_relations([{from: "vulnerability_id", to: "mitigation_id", relationType: "mitigated_by"}])` → Follow Simple Git Protocol

## Simple Git Protocol (MANDATORY)
**EXECUTE AFTER EVERY CHANGE - NO EXCEPTIONS**:
1. **Stage immediately**: `git add -A` after any file modification
2. **Commit at milestones**: When any meaningful task is complete (with MCP-researched commit message validation)
3. **Always invoke git-tagger**: Use git-tagger agent after EVERY commit to evaluate for tags (with memory-informed release intelligence)
4. **Update CHANGELOG.md**: When git-tagger creates release tags, update CHANGELOG.md with release notes (using memory-tracked feature evolution)
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

