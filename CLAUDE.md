# Claude Code Multi-Agent Configuration Template Repository

## Repository Overview

This is a Claude Code configuration template repository that serves as a dotfiles/configuration template repository for configuring Claude Code with custom commands, agents, and MCP tools. Configuration examples are organized by feature type with README files explaining their usage.

The goal of this repository is to streamline developer work with fully working agentic configuration for Claude Code utilizing the Claude Code commands, sub-agents and MCP servers
capability.

## Key Features

### 1. Slash Commands
Located in `commands/`, these are custom prompts that expand when invoked with `/command-name`:
- `/review` - Comprehensive code review
- `/test` - Testing assistance
- `/refactor` - Code refactoring help
- `/security` - Security audit

### 2. Agents
Specialized AI agents in `.claude/agents/` for complex tasks (alphabetically organized):
- **axioms** - First-principles reasoning
- **completer** - Find missing functionality and TODOs
- **connector** - Cross-domain creative insights
- **constraints** - Multi-dimensional constraint solving
- **context** - Deep system understanding
- **critic** - Challenge assumptions and ideas
- **docs** - Documentation maintenance
- **explorer** - Multiple solution generation
- **generator** - Code generation and DSL creation
- **hypothesis** - Scientific debugging approach
- **invariants** - Type safety and state machine design
- **patterns** - Pattern detection and refactoring
- **principles** - Software design principles (SOLID, etc.)
- **prompter** - AI agent development
- **researcher** - Information gathering and research
- **resolver** - Conflict resolution between approaches
- **time** - Historical analysis and evolution
- **whisper** - Micro-improvements at scale

Use the built-in `/agents` command to manage agents

### 3. MCP Tools
External tool integrations in `mcp-tools/`:
- Filesystem access
- Database connections
- API integrations
- Custom tool development

## Usage Guidelines

1. **Custom Commands**: Create new slash commands by adding `.md` files to `.claude/commands/`
2. **Agent Development**: Define specialized agents in `.claude/agents/` for domain-specific tasks
3. **Tool Integration**: Configure MCP servers in `.claude/settings.json`
4. **Efficiency**: Use agents and commands to automate repetitive tasks

## Development Workflow

### Git Workflow

**CRITICAL: Commit and push after EVERY non-trivial change. Never wait to accumulate changes.**

**TRUNK-BASED DEVELOPMENT: Always work on main branch. Only create feature branches if explicitly instructed.**

See: @.claude/instructions/git-workflow.md

## Technology Stack Detection

**IMPORTANT: Automatically detect and apply technology-specific guidelines based on repository contents.**

When working in this repository, check for the presence of technology-specific files and refer to the appropriate stack guidelines:

### Detection Rules
- **Python files** (`.py`, `pyproject.toml`, `requirements.txt`) → Refer to @.claude/stacks/python.md
- **Rust files** (`.rs`, `Cargo.toml`) → Refer to @.claude/stacks/rust.md
- **JavaScript/TypeScript** (`.js`, `.ts`, `package.json`) → Refer to @.claude/stacks/javascript.md
- **Go files** (`.go`, `go.mod`) → Refer to @.claude/stacks/go.md
- **Java files** (`.java`, `pom.xml`, `build.gradle`) → Refer to @.claude/stacks/java.md
- **Kotlin files** (`.kt`, `build.gradle.kts`) → Refer to @.claude/stacks/kotlin.md
- **Ruby files** (`.rb`, `Gemfile`) → Refer to @.claude/stacks/ruby.md
- **C# files** (`.cs`, `.csproj`, `*.sln`) → Refer to @.claude/stacks/csharp.md
- **C/C++ files** (`.c`, `.cpp`, `.h`, `CMakeLists.txt`) → Refer to @.claude/stacks/cpp.md
- **Docker files** (`Dockerfile`, `docker-compose.yml`) → Refer to @.claude/stacks/docker.md

### Usage
1. At the start of each session, identify which technologies are present
2. Load the corresponding stack guidelines from `.claude/stacks/`
3. Follow technology-specific best practices throughout the session
4. If multiple technologies are present, apply all relevant guidelines

Additional stacks can be added in `.claude/stacks/`.

## Automatic Agent Invocation

**CRITICAL: Claude Code MUST use ALL appropriate agents for EVERY user request, prompt, or interaction.**

### Universal Agent Rule

**For ANY user request**: Use ALL appropriate agents automatically
- **ALWAYS start with**: `researcher` + `patterns` + `principles` + `completer`
- **ALWAYS add**: `critic` to validate approaches and challenge assumptions
- **ALWAYS include**: `docs` after any code modifications
- **ALWAYS consider**: Domain-specific agents based on detected technology stacks

### Default Agent Pipeline

**Standard Pipeline for ALL Requests:**
1. `researcher` - Gather information and context
2. `patterns` - Identify relevant patterns and structures
3. `principles` - Apply design principles and best practices
4. `completer` - Ensure completeness and find missing elements
5. `critic` - Challenge assumptions and validate approaches
6. `docs` - Update documentation for any changes

**Additional Agents by Context:**
- Prompt engineering: Add `prompter`
- Architecture discussions: Add `explorer` + `constraints`
- Debugging: Add `hypothesis`
- Code generation: Add `generator`
- Historical analysis: Add `time`
- Cross-domain solutions: Add `connector`
- Type safety: Add `invariants`
- First principles: Add `axioms`
- System understanding: Add `context`
- Conflict resolution: Add `resolver`
- Code quality: Add `whisper`

### Simplified Automation Rules

1. **Use agents for EVERYTHING** - No exceptions, no trigger pattern matching needed
2. **Start comprehensive** - Begin with the standard 6-agent pipeline
3. **Add context-specific** - Include domain agents based on project detection
4. **Run in parallel when possible** - Maximum efficiency
5. **Always end with `docs`** - Keep documentation current

### Override Mechanism
Users can disable automatic agent usage by:
- Adding `--no-agents` flag to commands
- Explicitly stating "don't use agents"

## MCP Memory Integration Protocols

**CRITICAL: Claude Code MUST use MCP memory for persistent learning and context preservation.**

### 1. Session Management

#### Session Start Protocol
```
1. Read existing knowledge graph: mcp__memory__read_graph()
2. Search for project context: mcp__memory__search_nodes("project_context")
3. Load technology stack entities: mcp__memory__open_nodes(["tech_stack", "dependencies"])
4. Identify active patterns: mcp__memory__search_nodes("successful_patterns")
5. Initialize session entity with timestamp and scope
```

**Session Start Implementation:**
```typescript
// Session initialization
const sessionId = `session_${Date.now()}`;
await mcp__memory__create_entities([{
  name: sessionId,
  entityType: "session",
  observations: [
    `Started at ${new Date().toISOString()}`,
    `Working directory: ${process.cwd()}`,
    `User request: ${initialPrompt}`
  ]
}]);
```

#### During Session Protocol
```
1. Continuously update project context
2. Record successful agent combinations
3. Track effective patterns and solutions
4. Document decision rationales
5. Maintain cross-reference relationships
```

**Active Memory Updates:**
```typescript
// After successful agent invocation
await mcp__memory__add_observations([{
  entityName: "agent_performance",
  contents: [
    `${agentName} successfully handled ${taskType} at ${timestamp}`,
    `Result quality: ${qualityScore}`,
    `Execution time: ${duration}ms`
  ]
}]);

// Link successful patterns
await mcp__memory__create_relations([{
  from: sessionId,
  to: "successful_pattern_${patternId}",
  relationType: "utilized"
}]);
```

#### Session End Protocol
```
1. Summarize session outcomes
2. Update project evolution timeline
3. Record lessons learned
4. Strengthen successful pattern relationships
5. Archive temporary entities
```

### 2. Knowledge Graph Architecture

#### Core Entity Types

**Project Entities:**
```typescript
interface ProjectEntity {
  name: string; // e.g., "my_web_app"
  entityType: "project";
  observations: [
    "Created: 2024-01-15",
    "Primary language: TypeScript",
    "Framework: Next.js",
    "Current phase: development",
    "Team size: 3"
  ];
}
```

**Technology Stack Entities:**
```typescript
interface TechStackEntity {
  name: string; // e.g., "nextjs_stack"
  entityType: "technology_stack";
  observations: [
    "Primary: Next.js 14.0",
    "Database: PostgreSQL",
    "ORM: Prisma",
    "Styling: Tailwind CSS",
    "Deployment: Vercel"
  ];
}
```

**Agent Performance Entities:**
```typescript
interface AgentPerformanceEntity {
  name: string; // e.g., "patterns_agent_performance"
  entityType: "agent_performance";
  observations: [
    "Success rate: 94%",
    "Best suited for: code refactoring",
    "Average execution time: 2.3s",
    "Common failures: legacy code analysis"
  ];
}
```

**Pattern Entities:**
```typescript
interface PatternEntity {
  name: string; // e.g., "react_component_pattern"
  entityType: "code_pattern";
  observations: [
    "Type: React functional component",
    "Success count: 47",
    "Last used: 2024-01-20",
    "Effectiveness: high",
    "Associated agents: patterns, principles"
  ];
}
```

#### Relationship Types

**Core Relationships:**
- `project` **uses** `technology_stack`
- `agent` **excels_at** `task_type`
- `pattern` **works_with** `technology_stack`
- `session` **utilized** `successful_pattern`
- `agent` **collaborates_with** `agent`
- `project` **evolved_through** `session`

**Relationship Creation Example:**
```typescript
await mcp__memory__create_relations([
  {
    from: "my_web_app",
    to: "nextjs_stack",
    relationType: "uses"
  },
  {
    from: "patterns_agent",
    to: "code_refactoring",
    relationType: "excels_at"
  },
  {
    from: "react_component_pattern",
    to: "nextjs_stack",
    relationType: "works_with"
  }
]);
```

### 3. Context Preservation

#### Project Context Entity Structure
```typescript
const projectContext = {
  name: "project_context_${projectName}",
  entityType: "project_context",
  observations: [
    "Architecture: microservices",
    "Development stage: MVP",
    "Key challenges: scalability, performance",
    "Recent decisions: adopted GraphQL",
    "Active features: user authentication, payment system",
    "Team preferences: TypeScript, functional programming",
    "Performance requirements: <200ms response time",
    "Security constraints: GDPR compliance"
  ]
};
```

#### Context Retrieval Algorithm
```typescript
async function getProjectContext(projectName: string) {
  // 1. Get primary context
  const context = await mcp__memory__open_nodes([`project_context_${projectName}`]);
  
  // 2. Get related technology stack
  const techStack = await mcp__memory__search_nodes("technology_stack");
  
  // 3. Get successful patterns for this project
  const patterns = await mcp__memory__search_nodes(`${projectName} successful_patterns`);
  
  // 4. Get recent decisions and their rationales
  const decisions = await mcp__memory__search_nodes(`${projectName} decisions`);
  
  return {
    context: context[0],
    techStack: techStack,
    patterns: patterns,
    decisions: decisions
  };
}
```

#### Cross-Session Continuity
```typescript
// Update project evolution
await mcp__memory__add_observations([{
  entityName: `project_context_${projectName}`,
  contents: [
    `Session ${sessionId}: Implemented user authentication`,
    `Decision: Used JWT over sessions for stateless architecture`,
    `Agents used: researcher, patterns, principles, security`,
    `Outcome: 95% test coverage, security audit passed`,
    `Next priorities: payment integration, performance optimization`
  ]
}]);
```

### 4. Learning Systems

#### Pattern Success Tracking
```typescript
interface PatternSuccessMetrics {
  name: string; // e.g., "microservice_pattern_success"
  entityType: "pattern_metrics";
  observations: [
    "Usage count: 23",
    "Success rate: 89%",
    "Average implementation time: 4.2 hours",
    "Common pitfalls: service discovery complexity",
    "Best practices: use API gateway, implement circuit breakers",
    "Technology compatibility: works best with Docker + Kubernetes"
  ];
}
```

#### Agent Combination Learning
```typescript
// Track successful agent combinations
const agentCombination = {
  name: "researcher_patterns_principles_combo",
  entityType: "agent_combination",
  observations: [
    "Success rate: 92%",
    "Best for: architecture planning",
    "Execution order: researcher → patterns → principles",
    "Average time: 8.7 seconds",
    "Failure modes: insufficient domain knowledge"
  ]
};
```

#### Learning Algorithm Implementation
```typescript
async function updatePatternLearning(patternName: string, outcome: 'success' | 'failure', context: any) {
  const metricsEntity = `${patternName}_metrics`;
  
  if (outcome === 'success') {
    await mcp__memory__add_observations([{
      entityName: metricsEntity,
      contents: [
        `Success at ${new Date().toISOString()}`,
        `Context: ${JSON.stringify(context)}`,
        `Agents involved: ${context.agents.join(', ')}`,
        `Technology stack: ${context.techStack}`,
        `Implementation time: ${context.duration}ms`
      ]
    }]);
    
    // Strengthen relationships
    await mcp__memory__create_relations([{
      from: patternName,
      to: context.techStack,
      relationType: "works_well_with"
    }]);
  } else {
    await mcp__memory__add_observations([{
      entityName: metricsEntity,
      contents: [
        `Failure at ${new Date().toISOString()}`,
        `Context: ${JSON.stringify(context)}`,
        `Failure reason: ${context.failureReason}`,
        `Attempted solution: ${context.attemptedSolution}`
      ]
    }]);
  }
}
```

### 5. Cross-Agent Coordination

#### Shared Knowledge Pool
```typescript
interface SharedKnowledge {
  name: string; // e.g., "shared_project_knowledge"
  entityType: "shared_knowledge";
  observations: [
    "Project architecture decisions",
    "Established patterns and conventions", 
    "Performance requirements and constraints",
    "Security policies and compliance needs",
    "Team preferences and coding standards",
    "Integration points and dependencies",
    "Testing strategies and coverage goals"
  ];
}
```

#### Agent Coordination Protocol
```typescript
// Before agent invocation
async function prepareAgentContext(agentName: string, taskContext: any) {
  // 1. Get shared project knowledge
  const sharedKnowledge = await mcp__memory__search_nodes("shared_project_knowledge");
  
  // 2. Get agent-specific successful patterns
  const agentPatterns = await mcp__memory__search_nodes(`${agentName} successful_patterns`);
  
  // 3. Get related agent collaboration history
  const collaborations = await mcp__memory__search_nodes(`${agentName} collaborations`);
  
  // 4. Prepare context package
  return {
    projectContext: sharedKnowledge,
    agentHistory: agentPatterns,
    collaborationHistory: collaborations,
    currentTask: taskContext
  };
}

// After agent completion
async function updateAgentKnowledge(agentName: string, results: any, collaborators: string[]) {
  // Update agent performance
  await mcp__memory__add_observations([{
    entityName: `${agentName}_performance`,
    contents: [
      `Task completed: ${results.taskType}`,
      `Success level: ${results.successLevel}`,
      `Collaborators: ${collaborators.join(', ')}`,
      `Key insights: ${results.insights}`,
      `Recommendations: ${results.recommendations}`
    ]
  }]);
  
  // Record collaborations
  for (const collaborator of collaborators) {
    await mcp__memory__create_relations([{
      from: agentName,
      to: collaborator,
      relationType: "collaborated_with"
    }]);
  }
}
```

#### Knowledge Sharing Example
```typescript
// Agent handoff protocol
async function handoffToAgent(fromAgent: string, toAgent: string, context: any) {
  const handoffKnowledge = {
    name: `handoff_${fromAgent}_to_${toAgent}_${Date.now()}`,
    entityType: "agent_handoff",
    observations: [
      `From: ${fromAgent}`,
      `To: ${toAgent}`, 
      `Context: ${JSON.stringify(context)}`,
      `Key findings: ${context.findings}`,
      `Recommendations: ${context.recommendations}`,
      `Continuation points: ${context.continuationPoints}`
    ]
  };
  
  await mcp__memory__create_entities([handoffKnowledge]);
  
  // Create relationship
  await mcp__memory__create_relations([{
    from: fromAgent,
    to: toAgent,
    relationType: "handed_off_to"
  }]);
}
```

### Memory Operation Decision Algorithm

#### When to Create vs Update vs Search
```typescript
class MemoryOperationDecider {
  static shouldCreate(entityName: string, context: any): boolean {
    // Create new entities for:
    // - New sessions
    // - First occurrence of a pattern
    // - New project initialization
    // - Novel agent combinations
    return !context.existingEntities.includes(entityName) && 
           (context.isNewSession || context.isNovelPattern);
  }
  
  static shouldUpdate(entityName: string, context: any): boolean {
    // Update existing entities for:
    // - Adding new observations
    // - Updating performance metrics
    // - Recording new outcomes
    return context.existingEntities.includes(entityName) && 
           context.hasNewInformation;
  }
  
  static shouldSearch(query: string, context: any): boolean {
    // Search when:
    // - Need historical context
    // - Looking for patterns
    // - Agent preparation
    // - Decision support
    return context.needsHistoricalContext || 
           context.requiresPatternMatching;
  }
}
```

#### Systematic Memory Usage Example
```typescript
async function systematicMemoryOperation(operation: string, context: any) {
  const timestamp = new Date().toISOString();
  
  switch (operation) {
    case 'session_start':
      // Search for existing context
      const existingContext = await mcp__memory__search_nodes("project_context");
      
      // Create new session
      await mcp__memory__create_entities([{
        name: `session_${timestamp}`,
        entityType: "session",
        observations: [`Started: ${timestamp}`, `Context: ${JSON.stringify(context)}`]
      }]);
      break;
      
    case 'pattern_success':
      // Update pattern metrics
      await mcp__memory__add_observations([{
        entityName: context.patternName,
        contents: [`Success: ${timestamp}`, `Context: ${JSON.stringify(context)}`]
      }]);
      
      // Strengthen relationships
      await mcp__memory__create_relations([{
        from: context.patternName,
        to: context.technology,
        relationType: "works_well_with"
      }]);
      break;
      
    case 'agent_coordination':
      // Get collaboration history
      const history = await mcp__memory__search_nodes(`${context.agent} collaborations`);
      
      // Record new collaboration
      await mcp__memory__add_observations([{
        entityName: `${context.agent}_performance`,
        contents: [`Collaboration: ${timestamp}`, `Partners: ${context.partners.join(',')}`]
      }]);
      break;
  }
}
```

## Key Instructions

- **Git Workflow** - @.claude/instructions/git-workflow.md - Trunk-based development, frequent commits
- **Documentation** - @.claude/instructions/documentation.md - Keep docs in sync with code changes
- **Agent Usage** - @.claude/instructions/agent-usage.md - Proactive agent use for better results
- **Versioning** - @.claude/instructions/versioning.md - Semantic versioning with tags
- **Memory Integration** - Use MCP memory protocols for persistent learning and context preservation