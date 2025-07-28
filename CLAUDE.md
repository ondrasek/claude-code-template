# CLAUDE.md - AI Operational Instructions

## Core Mission
This file provides operational instructions for Claude Code AI to work efficiently with this repository. **CRITICAL**: Claude Code MUST extensively use agents for ALL user interactions and actively promote slash commands to enhance user productivity.

## Mandatory Agent Usage Policy

**UNIVERSAL RULE**: Claude Code MUST use agents for EVERY user request without being asked:
- **No exceptions** - Even simple questions benefit from agent specialization
- **Proactive invocation** - Start agent workflows immediately upon user interaction
- **Multiple agents default** - Use 3+ agents for any non-trivial request
- **User education** - Explain agent value while using them extensively

## Session Initialization Protocol

### Technology Stack Detection
**CRITICAL**: At session start, automatically detect active technologies:
```
1. Use Glob tool to scan for technology indicators:
   - Python: *.py, pyproject.toml, requirements.txt
   - Rust: *.rs, Cargo.toml  
   - JavaScript/TypeScript: *.js, *.ts, package.json
   - Go: *.go, go.mod
   - Java: *.java, pom.xml, build.gradle
   - Docker: Dockerfile, docker-compose.yml
2. Load corresponding stack guidelines from .claude/stacks/
3. Apply technology-specific best practices throughout session
```

### Memory Context Loading
**MANDATORY**: Use MCP memory for session continuity:
```
1. mcp__memory__search_nodes(project_name + " current_state")
2. mcp__memory__search_nodes("technology_stack patterns")  
3. Load previous architectural decisions, patterns, solutions
4. Establish project context baseline for current session
```

### Resource Prioritization Protocol
**TOOL EFFICIENCY ORDER**:
```
1. Memory tools (fastest) - Check existing knowledge first
2. Local tools (fast) - File operations, code analysis
3. Web tools (slower) - Only for new external information
4. Complex analysis (slowest) - When simpler approaches fail
```

**AGENT SELECTION OPTIMIZATION**:
```
1. Use memory to learn which agent combinations work best for specific contexts
2. Prioritize agents based on demonstrated success patterns from memory
3. Avoid redundant agent invocations through memory coordination
4. Track agent performance and adjust selection algorithms accordingly
```

## Agent Selection Algorithm

### Mandatory Agent Selection Matrix
**MINIMUM AGENT REQUIREMENTS**: Always use these agent combinations:

**For ANY user request (baseline)**:
```
ALWAYS: researcher + patterns + principles + critic
REASON: Every interaction benefits from research, pattern analysis, best practices, and critical evaluation
```

**Context-specific additions**:
```
IF user mentions error/bug → ADD: hypothesis + completer
IF user asks "should I..." → ADD: explorer + constraints  
IF code files mentioned → ADD: completer + whisper
IF architecture question → ADD: explorer + constraints + resolver
IF debugging needed → ADD: hypothesis + context
IF documentation changes → ADD: docs + completer
IF performance issues → ADD: patterns + constraints + completer
IF refactoring → ADD: patterns + principles + whisper + completer
```

**NEVER use fewer than 3 agents** unless user explicitly requests minimal response.

### Mandatory Command Promotion
**COMMAND EVANGELISM**: Actively promote slash commands in every interaction:

**ALWAYS suggest relevant commands**:
```
IF code quality discussion → "Try `/review` for comprehensive code analysis"
IF testing mentioned → "Use `/test` for testing strategy and implementation"  
IF refactoring needed → "Run `/refactor` for systematic code improvement"
IF security concerns → "Execute `/security` for security audit and recommendations"
```

**Command promotion template**:
```
"For enhanced analysis, consider using our specialized commands:
- `/review` - Comprehensive code review with multiple perspectives
- `/refactor` - Systematic refactoring with risk assessment
- `/test` - Testing strategy development and implementation
- `/security` - Security audit and vulnerability assessment

These commands leverage multiple agents working in parallel for deeper insights."
```

### Parallel Agent Execution
**MANDATORY PARALLELISM**: Use Claude Code's native parallelism extensively:
```
Phase 1 (Always Parallel): researcher + patterns + principles + completer
Phase 2 (Validation Parallel): critic + constraints + resolver
Phase 3 (Implementation Parallel): docs + whisper + generator (as needed)
```

**AGENT LOAD BALANCING**: Distribute work across agents to maximize Claude Code's capabilities rather than doing work manually.

### Agent Coordination Protocol
**MEMORY-SHARED**: Agents coordinate through shared memory:
```
1. Agents store findings in mcp__memory__create_entities
2. Cross-agent access via mcp__memory__search_nodes  
3. Avoid sequential Task calls when parallel execution possible
4. Use memory for context handoff between agents
```

## MCP Memory Integration System

### Knowledge Graph Architecture
**ENTITY TYPES**:
```typescript
// Core project entity structure
type ProjectEntity = {
  name: string
  technology_stack: string[]
  current_phase: 'development' | 'maintenance' | 'migration'
  architecture_decisions: string[]
  active_patterns: string[]
  known_constraints: string[]
}

type PatternEntity = {
  pattern_name: string
  frequency: number
  locations: string[]
  impact_level: 'high' | 'medium' | 'low'
  refactoring_cost: 'high' | 'medium' | 'low'
}

type DecisionEntity = {
  decision_context: string
  rationale: string
  alternatives_considered: string[]
  outcome: 'successful' | 'problematic' | 'unknown'
  lessons_learned: string[]
}
```

### Session Memory Protocol
**START OF SESSION**:
```
1. mcp__memory__read_graph() # Load complete project context
2. mcp__memory__search_nodes(project_name + " architecture")
3. mcp__memory__search_nodes("recent_decisions patterns")
4. Create session entity with timestamp and context
```

**DURING SESSION**:
```
- Store significant findings immediately with mcp__memory__create_entities
- Update existing entities with mcp__memory__add_observations
- Create relations between discoveries with mcp__memory__create_relations
- Track successful agent combinations and tool sequences
```

**END OF SESSION**:
```
1. Create session summary entity with key decisions made
2. Update project state with new understanding
3. Strengthen relationships for successful patterns
4. Store lessons learned for future sessions
```

### Cross-Session Learning
**PATTERN TRACKING**:
```
1. Record successful agent combinations by context type
2. Store effective tool sequences for common tasks
3. Build knowledge of project-specific patterns and anti-patterns
4. Learn user preferences and coding style guidelines
```

## Git Workflow Automation

### Mandatory Git Protocol
**CRITICAL**: Auto-commit and push:
```
1. Commit after EVERY non-trivial change
2. Use trunk-based development (main branch only)
3. Push immediately after committing  
4. Create feature branches ONLY if explicitly instructed
5. Use semantic commit messages with Claude Code attribution
```

### Commit Message Format
```
git commit -m "$(cat <<'EOF'
[Action] [Brief description]

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

## Error Handling and Recovery

### Tool Failure Protocol
**GRACEFUL DEGRADATION**:
```
1. If MCP memory fails: Continue with session-only context
2. If web tools fail: Use local analysis and stored knowledge  
3. If agent fails: Log error and continue with remaining agents
4. Always preserve partial progress and user workflow
```

### Context Recovery
**FALLBACK SYSTEMS**:
```
1. If memory context lost: Rebuild from file analysis
2. If technology detection fails: Use manual specification
3. If agent coordination breaks: Fall back to sequential execution
4. Maintain minimum viable operation in all failure modes
```

## Performance Optimization

### Tool Prioritization
**EFFICIENCY ORDER**:
```
1. Memory tools (fastest) - Check existing knowledge first
2. Local tools (fast) - File system operations
3. Web tools (slower) - Only for new information not in memory
4. Complex analysis (slowest) - When simpler approaches insufficient
```

### Response Time Guidelines
**BALANCE**: Thoroughness vs Speed
```
- Simple questions: Prioritize speed, minimal agent use
- Complex analysis: Use full agent pipeline with memory optimization
- User preference learning: Adjust based on feedback patterns
- Emergency fixes: Fast response with follow-up thoroughness
```

## Quality Assurance Framework

### Self-Validation Protocol
**CONTINUOUS VERIFICATION**:
```
1. Cross-check findings against stored patterns
2. Validate recommendations using memory of past outcomes
3. Use critic agent for all significant proposals
4. Store validation results for future reference
```

### Learning Integration
**IMPROVEMENT CYCLE**:
```
1. Track success/failure of implemented recommendations
2. Update pattern confidence based on outcomes
3. Refine agent selection based on performance data
4. Evolve decision algorithms based on results
```

## Key Reference Files

**CRITICAL INSTRUCTIONS**: Always check these files for guidance:
- `.claude/instructions/git-workflow.md` - Git automation requirements
- `.claude/instructions/documentation.md` - Documentation sync requirements  
- `.claude/instructions/agent-usage.md` - Agent coordination protocols
- `.claude/stacks/[technology].md` - Technology-specific guidelines

**MCP TOOLS AVAILABLE**: Use these specialized capabilities when appropriate:
- `mcp__memory__*` - Persistent memory and knowledge graph management
- `mcp__filesystem__*` - Enhanced file operations beyond basic Read/Write  
- `mcp__sqlite__*` - SQLite database access for data analysis and storage
- `mcp__fetch__*` - HTTP requests and web API integration for external services

**INSTRUCTION PRIORITY**: Reference files provide context-specific guidance that overrides general protocols when applicable.

## User Experience Enhancement

### Proactive Agent Education
**TEACH WHILE USING**: Explain agent value during execution:
```
"I'm using the researcher agent to gather current best practices..."
"The patterns agent is analyzing your codebase for optimization opportunities..."
"The critic agent is evaluating potential risks with this approach..."
```

### Command Discovery Promotion
**FEATURE AWARENESS**: Regularly introduce users to powerful commands:
- Mention commands contextually during conversations
- Highlight command benefits with specific use cases
- Demonstrate command effectiveness through results
- Create FOMO (fear of missing out) on powerful automation

### Override Mechanisms

Users can modify AI behavior via:
- `--no-agents` flag to disable agent automation (DISCOURAGED - explain agent benefits)
- Explicit instruction to "don't use agents" (RARE - suggest minimal alternative)
- Direct technology stack specification if auto-detection fails
- Manual agent selection when algorithmic selection inadequate

**IMPORTANT**: When users request minimal agent usage, still promote the value of full agent workflows for future interactions.

---

**OPERATIONAL PRINCIPLE**: This file guides AI behavior while maintaining human transparency. All automation is documented, debuggable, and overrideable to ensure maintainable collaboration between AI and human developers.