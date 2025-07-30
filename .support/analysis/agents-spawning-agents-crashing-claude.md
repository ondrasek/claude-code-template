## Core-Satellite Agent Architecture (MANDATORY)

**CORE AGENTS (Always Available - 0ms selection time)**:
- **foundation-researcher, foundation-patterns, foundation-principles, foundation-critic, foundation-context, foundation-resolver**
- Instant loading for 88% workflow coverage
- Foundation for all complex tasks requiring information, quality, consistency, risk analysis, understanding, or decisions

**SPECIALIZED AGENTS (Context-Triggered)**:
- 16 specialized agents for domain-specific expertise
- Triggered by user intent, context patterns, or complexity analysis
- Covers remaining 12% specialized use cases

**CORE AGENT UTILIZATION**:
- Specialized agents only when specific expertise needed
- Core agents work together in established patterns
- No selection overhead for core agent combinations

**STANDARD CORE PATTERNS**:
- **Information + Analysis**: foundation-researcher → foundation-patterns → foundation-principles → foundation-critic
- **Decision Making**: foundation-researcher → foundation-critic → foundation-resolver → foundation-context
- **Quality Assurance**: foundation-patterns → foundation-principles → foundation-critic → foundation-resolver
- **System Understanding**: foundation-context → foundation-patterns → foundation-principles → foundation-critic

## Agent Combination Patterns (MANDATORY)

**Analysis Requests** (`"analyze X"`, `"review Y"`, `"examine Z"`):
- **Core Foundation**: Execute foundation-researcher + foundation-patterns + foundation-principles + foundation-critic simultaneously via single message with multiple Task() calls
- **Extended Analysis** (if specialized needs): Add foundation-context + specialist-hypothesis/specialist-axioms + specialist-completer as needed
- Flow: Research → Pattern detection → Consistency enforcement → Critical validation

**Architecture/Design Questions** (`"design X"`, `"architect Y"`, `"structure Z"`):
- **Core Design**: Execute foundation-researcher + foundation-principles + foundation-critic + foundation-resolver simultaneously via single message with multiple Task() calls
- **Extended Design** (if alternatives needed): Add specialist-explorer + specialist-constraints + foundation-context as needed
- Flow: Research approaches → Consistency validation → Critical analysis → Decision resolution

**Debugging Investigations** (`"why does X"`, `"strange behavior"`, `"not working"`):
- **Core Investigation**: Execute foundation-researcher + foundation-patterns + foundation-critic + foundation-resolver simultaneously via single message with multiple Task() calls
- **Extended Debugging** (if systematic needed): Add specialist-hypothesis + foundation-context + specialist-constraints as needed
- Flow: Research issues → Pattern analysis → Critical assessment → Resolution decisions

**Code Quality Tasks** (`"improve X"`, `"refactor Y"`, `"optimize Z"`):
- **Core Quality**: Execute foundation-patterns + foundation-principles + foundation-critic + foundation-resolver simultaneously via single message with multiple Task() calls
- **Extended Quality** (if specialized needed): Add specialist-whisper + specialist-performance + specialist-constraints as needed
- Flow: Pattern analysis → Consistency enforcement → Critical validation → Resolution decisions

**Feature Implementation** (`"add X"`, `"implement Y"`, `"create Z"`):
- **Core Implementation**: Execute foundation-researcher + foundation-patterns + foundation-principles + foundation-critic simultaneously via single message with multiple Task() calls
- **Extended Implementation** (if specialized needed): Add specialist-completer + specialist-docs + foundation-context + foundation-resolver as needed
- Flow: Research approaches → Pattern alignment → Consistency validation → Critical review

**Decision Making** (`"options for X"`, `"approaches to Y"`, `"choose between Z"`):
- **Core Decision**: Execute foundation-researcher + foundation-critic + foundation-resolver + foundation-principles simultaneously via single message with multiple Task() calls
- **Extended Decision** (if alternatives needed): Add specialist-explorer + specialist-constraints + foundation-context as needed
- Flow: Research options → Critical analysis → Consistency validation → Resolution decisions

**System Understanding** (`"how does X work"`, `"explain Y"`, `"show me Z"`):
- **Core Understanding**: Execute foundation-context + foundation-patterns + foundation-researcher + foundation-critic simultaneously via single message with multiple Task() calls
- **Extended Understanding** (if deep analysis needed): Add foundation-principles + specialist-axioms + specialist-docs as needed
- Flow: System mapping → Pattern identification → Research validation → Critical synthesis

**Security Analysis** (`"security review"`, `"vulnerability assessment"`, `"threat analysis"`):
- **Core Security**: Execute foundation-researcher + foundation-critic + foundation-principles + foundation-resolver simultaneously via single message with multiple Task() calls
- **Extended Security** (if specialized needed): Add specialist-security + specialist-constraints as needed
- Flow: Research vulnerabilities → Critical assessment → Consistency validation → Resolution guidance

**Performance Optimization** (`"optimize performance"`, `"improve speed"`, `"reduce latency"`):
- **Core Performance**: Execute foundation-researcher + foundation-patterns + foundation-critic + foundation-resolver simultaneously via single message with multiple Task() calls
- **Extended Performance** (if specialized needed): Add specialist-performance + specialist-constraints as needed
- Flow: Research bottlenecks → Pattern analysis → Critical assessment → Resolution decisions