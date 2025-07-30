# Agent Ecosystem Inventory - Complete Analysis

## Executive Summary
**Total Agents: 29**
- **Core Agent Candidates (6)**: researcher, patterns, principles, critic, context, resolver
- **Specialized Agents (12)**: explorer, hypothesis, whisper, completer, docs, constraints, performance, testing, git-troubleshooter, guidelines-file, guidelines-repo, vulnerability-scanner
- **Potential Deprecation Candidates (11)**: Based on overlap and usage analysis needed

## Complete Agent Inventory

### Proposed Core Agents (Always Available - Foundation)

#### 1. **researcher** - Information Gathering
- **Purpose**: Gather information through web search, documentation analysis, codebase examination
- **Triggers**: Unknown tools, error messages, "how to" questions, best practices
- **Capabilities**: Web search, documentation analysis, local code analysis, memory-first approach
- **Usage Pattern**: High frequency - needed for most complex tasks

#### 2. **patterns** - Code Quality Analysis  
- **Purpose**: Detect code patterns, anti-patterns, refactoring opportunities
- **Triggers**: Code smells, refactoring opportunities, technical debt, code quality
- **Capabilities**: Memory-based pattern analysis, evolution tracking, systematic refactoring
- **Usage Pattern**: High frequency - proactive after code changes

#### 3. **principles** - First-Principles Thinking & Universal Principle Enforcement
- **Purpose**: Identify and document core principles that apply universally; enforce adherence across all agents and work
- **Triggers**: Complex problems requiring fundamental analysis, principle violations detected, "from first principles"
- **Capabilities**: First-principles thinking methodology, universal principle identification, cross-system enforcement, principle documentation
- **Usage Pattern**: High frequency - foundational thinking and universal governance for all agents

#### 4. **critic** - Risk Analysis & Validation
- **Purpose**: Critical analysis, risk identification, constructive disagreement
- **Triggers**: "Is this a good idea", "what could go wrong", major decisions
- **Capabilities**: Assumption challenging, risk analysis, alternative proposals
- **Usage Pattern**: High frequency - validation and decision support

#### 5. **context** - System Understanding
- **Purpose**: Persistent memory-backed architectural context synthesis
- **Triggers**: "How does X work", "explain the flow", system understanding
- **Capabilities**: Persistent memory, decision archaeology, living architecture model
- **Usage Pattern**: High frequency - system comprehension and documentation

#### 6. **resolver** - Conflict Resolution
- **Purpose**: Mediate between conflicting approaches, patterns, principles
- **Triggers**: Trade-offs, "which approach is better", conflicting advice
- **Capabilities**: Conflict detection, trade-off analysis, synthesis creation
- **Usage Pattern**: Medium-high frequency - decision support and optimization

### Proposed Specialized Agents (Context-Triggered)

#### 7. **explorer** - Solution Space Analysis
- **Purpose**: Parallel exploration of multiple solutions and trade-offs
- **Triggers**: "What are my options", alternatives, architectural decisions
- **Capabilities**: Solution space exploration, parallel implementation, quantification
- **Specialization**: Architecture and design decisions requiring multiple options

#### 8. **hypothesis** - Scientific Debugging
- **Purpose**: Systematic hypothesis formation for debugging and investigation
- **Triggers**: Strange behavior, performance issues, debugging scenarios
- **Capabilities**: Theory formation, experiment design, behavioral modeling
- **Specialization**: Complex debugging and system behavior analysis

#### 9. **whisper** - Code Polishing
- **Purpose**: Micro-improvements in code quality through thousands of tiny fixes
- **Triggers**: Code cleanup, formatting, polish requests, style issues
- **Capabilities**: Typo fixes, whitespace cleanup, naming standardization
- **Specialization**: Code quality and style consistency

#### 10. **completer** - Implementation Finishing
- **Purpose**: Complete TODOs, partial implementations, missing functionality
- **Triggers**: "Finish this", TODO/FIXME comments, incomplete implementations
- **Capabilities**: Systematic completion, edge case handling, progress tracking
- **Specialization**: Finishing incomplete work and ensuring thoroughness

#### 11. **docs** - Documentation Sync
- **Purpose**: Automatically sync documentation with code changes
- **Triggers**: Code changes requiring doc updates, documentation maintenance
- **Capabilities**: Multi-file documentation consistency, change detection
- **Specialization**: Documentation maintenance and synchronization

#### 12. **constraints** - Multi-Constraint Optimization
- **Purpose**: Find solutions within complex, conflicting constraints
- **Triggers**: Resource limitations, conflicting requirements, optimization problems
- **Capabilities**: Multi-constraint optimization, trade-off navigation, impossibility detection
- **Specialization**: Complex constraint satisfaction problems

#### 13. **performance** - Performance Optimization
- **Purpose**: Systematic performance analysis and optimization
- **Triggers**: Performance issues, optimization needs, bottleneck analysis
- **Capabilities**: Algorithmic complexity, profiling, optimization strategies
- **Specialization**: Performance analysis and improvement

#### 14. **testing** - Test Strategy Development
- **Purpose**: Comprehensive testing strategy and test case generation
- **Triggers**: Test strategy questions, coverage analysis, test case needs
- **Capabilities**: Test case generation, coverage analysis, strategy development
- **Specialization**: Testing methodology and quality assurance

#### 15. **git-troubleshooter** - Git Problem Resolution
- **Purpose**: Systematic git diagnosis and resolution
- **Triggers**: Git errors, merge conflicts, repository issues
- **Capabilities**: Git diagnosis, conflict resolution, repository repair
- **Specialization**: Version control system issues

#### 16. **guidelines-file** - Technology-Specific Guidelines
- **Purpose**: Load appropriate stack guidelines for file modifications
- **Triggers**: File modifications with unclear technology patterns
- **Capabilities**: Technology detection, guideline loading, best practice application
- **Specialization**: Technology-specific best practices

#### 17. **guidelines-repo** - Repository Architecture Guidelines
- **Purpose**: Repository-level architectural guidance
- **Triggers**: Architecture decisions, stack context determination
- **Capabilities**: Multi-technology detection, architectural guidance
- **Specialization**: Repository-wide architectural decisions

#### 18. **vulnerability-scanner** - Security Analysis
- **Purpose**: Code-level security flaw detection using OWASP frameworks
- **Triggers**: Security reviews, vulnerability checks, security flaws
- **Capabilities**: Systematic vulnerability detection, CVE analysis, OWASP review
- **Specialization**: Application security analysis

### Agents Requiring Usage Analysis (Potential Overlap/Deprecation)

#### Category A: Specialized Security/Compliance
- **threat-modeling** - Architectural security risk assessment
- **compliance-checker** - Regulatory compliance evaluation (SOC2, GDPR, etc.)
- **invariants** - Type safety and state machine design

#### Category B: Development Support
- **axioms** - Building solutions from first principles
- **generator** - Code generation and meta-programming
- **time** - Historical analysis and evolution tracking
- **git-tagger** - Autonomous git tagging
- **todo** - Task lifecycle management

#### Category C: Cross-Domain/Creative
- **connector** - Cross-domain connection making
- **prompter** - AI agent prompt optimization
- **ecosystem-analyzer** - Multi-agent system analysis

## Core-Satellite Architecture Validation

### Coverage Analysis of Core Agents (80%+ Use Case Test)
1. **Information Needs** → researcher ✓
2. **Quality Assessment** → patterns ✓  
3. **Architecture Validation** → principles ✓
4. **Critical Analysis** → critic ✓
5. **System Understanding** → context ✓
6. **Decision Making** → resolver ✓

**Common Workflow Patterns Covered:**
- Research + Analysis: researcher → patterns → principles → critic
- Architecture Design: researcher → context → principles → resolver  
- Quality Review: patterns → principles → critic → resolver
- Problem Solving: researcher → hypothesis → critic → resolver
- System Understanding: context → patterns → principles

### Specialized Agent Trigger Mapping
- **Design Decisions** → explorer (alternatives) + constraints (limitations)
- **Debugging** → hypothesis (systematic investigation) + performance (optimization)
- **Code Quality** → whisper (micro-improvements) + completer (completeness)
- **Documentation** → docs (sync) + guidelines-* (best practices)
- **Security** → vulnerability-scanner + threat-modeling + compliance-checker
- **Development** → testing + git-troubleshooter + git-tagger

## Overlap Analysis (Detailed)

### High Overlap - Deprecation Candidates
1. **axioms vs principles** - Both enforce fundamental concepts
2. **time vs context** - Both track historical evolution
3. **prompter vs researcher** - Both gather and synthesize information
4. **ecosystem-analyzer** - Meta-functionality, may be integrated into core

### Medium Overlap - Integration Candidates  
1. **git-tagger + git-troubleshooter** - Git operations could be merged
2. **guidelines-file + guidelines-repo** - Technology guidance overlap
3. **vulnerability-scanner + threat-modeling + compliance-checker** - Security cluster

### Low Overlap - Specialized Value
1. **generator** - Unique meta-programming capability
2. **invariants** - Unique type safety focus
3. **connector** - Unique cross-domain thinking
4. **todo** - Specific task management function

## Next Phase Recommendations

### Immediate Actions (Week 1)
1. **Usage Pattern Analysis** - Analyze recent workflows to validate frequency assumptions
2. **Agent Combination Success Rates** - Identify which combinations work best
3. **Performance Baseline** - Measure current selection time and context usage

### Implementation Priority (Week 2)
1. **Core Agent Always-Available** - Implement instant loading for 6 core agents
2. **Specialized Trigger Logic** - Create context-based activation for 12 specialized
3. **Deprecation Planning** - Merge/archive low-usage agents based on data

### Validation Testing (Week 3)
1. **Workflow Coverage** - Ensure new architecture handles all existing workflows
2. **Performance Measurement** - Validate 35-45% improvement claims
3. **Quality Maintenance** - Confirm no degradation in output quality

This inventory provides the foundation for implementing the core-satellite architecture transition.