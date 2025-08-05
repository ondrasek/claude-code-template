<claude_operational_rules>
<display_requirements>
RULE 0: Display ALL rules (0-4) at the start of EVERY response
RULE 1: Execute parallel agents for ANY complex request
RULE 2: Task(specialist-git-workflow) to commit, tag, and push after EVERY meaningful change
RULE 3: NEVER create artificial timelines or weekly milestones
RULE 4: Follow file structure locations EXACTLY
</display_requirements>

<parallel_agent_protocol priority="CRITICAL">
<enforcement>Use Task() in a single message for concurrent agent processing when beneficial</enforcement>
<minimum_agents>1-2 agents for simple/common tasks, 2-3 for complex</minimum_agents>
<invocation_pattern>Always single message with multiple Task() calls</invocation_pattern>
</parallel_agent_protocol>

<git_protocol priority="MANDATORY">
<enforcement>Task(git-workflow) after EVERY meaningful change</enforcement>
</git_protocol>

<output_sanitization priority="MANDATORY">
<forbidden_patterns>
  - "Week 1", "Week 2", "Phase 1 (Week 1)", "Milestone 1", "Milestone 2"
  - "implement in X weeks", "Q1 goals", "monthly milestones"
  - ANY time-based phases unless user explicitly requests
</forbidden_patterns>
<required_format>Priority-based (High/Medium/Low) with dependencies</required_format>
<examples>
  ✅ "High Priority: Update agent descriptions (blocks selection optimization)"
  ❌ "Phase 1 (Week 1): Update agent descriptions"
  ❌ "Next Sprint (Sprint 1): Implement feature 23"
  ❌ "Sprint 2: Update documentation"
</examples>
</output_sanitization>

<file_structure priority="ABSOLUTE">
<locations>
  <agents>.claude/agents/ (ONLY location for agent definitions)</agents>
  <commands>.claude/commands/ (ONLY location for slash commands)</commands>
  <prompts>.support/prompts/ (ONLY location for prompts)</prompts>
  <instructions>.support/instructions/ (additional instructions)</instructions>
  <todos>.support/todos/ (ONLY location for TODOs)</todos>
  <mcp_servers>.support/mcp-servers/ (MCP server source code)</mcp_servers>
  <logs>.support/logs/ (diagnostics and troubleshooting)</logs>
</locations>
<enforcement>NEVER search elsewhere for these file types</enforcement>
</file_structure>

<validation_check>
Before EVERY response, verify:
☐ All 5 display rules shown at start
☐ Parallel agents invoked for non-trivial tasks
☐ No artificial timelines in output
☐ File locations correctly referenced
☐ Git operations planned for changes
</validation_check>
</claude_operational_rules>