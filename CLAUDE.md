<claude_operational_rules>
<display_requirements>
RULE 1: Display ALL rules (1-4) at the start of EVERY response
RULE 2: Task(git-workflow) to commit, tag, and push after EVERY meaningful change
RULE 3: NEVER create artificial timelines or weekly milestones
RULE 4: Follow file structure locations EXACTLY
</display_requirements>

<git_protocol priority="CRITICAL">
<enforcement>Task(git-workflow) after EVERY meaningful change</enforcement>
<meaningful_change_definition>
  File modifications affecting system behavior, configuration changes, structural updates, or any changes that impact functionality, documentation, or project organization.
</meaningful_change_definition>
</git_protocol>

<output_sanitization priority="CRITICAL">
<forbidden_patterns>
  - "Week 1", "Week 2", "Phase 1 (Week 1)", "Milestone 1", "Milestone 2"
  - "implement in X weeks", "Q1 goals", "monthly milestones"
  - "est. durration 3-4 hours", "est. 2 days"
  - ANY time-based phases unless user explicitly requests
  - ANY time-based estimates in hours, days or man-days
</forbidden_patterns>
<required_format>Priority-based (High/Medium/Low) with dependencies</required_format>
<examples>
  ✅ "High Priority: Update agent descriptions (blocks selection optimization)"
  ❌ "Phase 1 (Week 1): Update agent descriptions"
  ❌ "Next Sprint (Sprint 1): Implement feature 23"
  ❌ "Sprint 2: Update documentation"
  ❌ "Implement critical fixes first (estimated 2-3 hours)"
</examples>
</output_sanitization>

<file_structure priority="CRITICAL">
<locations>
  <agents>.claude/agents/ (ONLY location for agent definitions)</agents>
  <commands>.claude/commands/ (ONLY location for slash commands)</commands>
  <prompts>.support/prompts/ (ONLY location for prompts)</prompts>
  <instructions>.support/instructions/ (additional instructions)</instructions>
  <specs>.support/specs/ (ONLY location for specifications)</specs>
  <mcp_servers>.support/mcp-servers/ (MCP server source code)</mcp_servers>
  <logs>.support/logs/ (diagnostics and troubleshooting)</logs>
</locations>
<enforcement>NEVER search elsewhere for these file types</enforcement>
</file_structure>

<specification_management priority="CRITICAL">
<specs_protocol>
  <definition>Specifications are detailed planning documents that define requirements, implementation approaches, and project deliverables managed separately from active development work</definition>
  
  <location>.support/specs/ (ABSOLUTE - never search elsewhere)</location>
  
  <agent_delegation>
    <primary_agent>specs-analyst (PROACTIVELY use when user mentions tasks, specs, requirements, or asks 'create spec', 'track progress', 'remember to do')</primary_agent>
    <non_trivial_task_definition>Operations requiring more than 2 tool invocations, affecting multiple files, or involving agent coordination</non_trivial_task_definition>
    <coordination>All specification lifecycle management MUST be delegated to specs-analyst agent to prevent context pollution</coordination>
    <commands>Use /specs commands: /specs create, /specs review, /specs cleanup, /specs next</commands>
  </agent_delegation>
  
  <file_format>
    <structure>Individual markdown files with YAML frontmatter</structure>
    <naming>kebab-case filenames derived from specification descriptions</naming>
    <template>
      ---
      status: pending|in_progress|completed|archived
      type: feat|fix|docs|refactor|test|chore
      priority: high|medium|low
      assignee: agent-name
      created: YYYY-MM-DD
      ---
      
      # Specification Title
      
      ## Description
      Clear description of requirements and scope.
      
      ## Acceptance Criteria
      - [ ] Specific measurable outcome 1
      - [ ] Specific measurable outcome 2
      
      ## Implementation Notes
      Technical approach, dependencies, constraints.
    </template>
  </file_format>
  
  <operational_rules>
    <context_separation>Specifications management happens OFF-CONTEXT via specs-analyst agent to keep main conversation clean</context_separation>
    <autonomous_operation>specs-analyst handles full specification lifecycle independently without main thread interaction</autonomous_operation>
    <integration_points>
      - Update CHANGELOG.md when specifications are completed
      - Coordinate with relevant agents for implementation
      - Support version management workflow through specification types
    </integration_points>
    <discovery_commands>
      - Find all specifications: Glob(pattern=".support/specs/*.md")
      - Read specific specification: Read(file_path=".support/specs/spec-name.md")
      - Create new specification: Write to .support/specs/new-spec.md
    </discovery_commands>
  </operational_rules>
  
  <namespace_separation>
    <purpose>Specifications (.support/specs/) are distinct from Claude Code's built-in TodoWrite functionality</purpose>
    <differentiation>
      - Specifications: Detailed planning documents with metadata, managed by specs-analyst
      - TodoWrite: Session task tracking for immediate conversation context
    </differentiation>
    <command_usage>Use /specs commands for specification management, TodoWrite tool for session task tracking</command_usage>
  </namespace_separation>
</specs_protocol>
</specification_management>

<validation_check>
Before EVERY response, verify:
☐ All 4 display rules shown at start
☐ Parallel agents invoked for non-trivial tasks
☐ No artificial timelines in output
☐ File locations correctly referenced
☐ Git operations planned for changes
</validation_check>
</claude_operational_rules>