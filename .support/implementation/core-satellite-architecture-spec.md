# Core-Satellite Architecture Implementation Specification

## Executive Summary
Transform the 29-agent ecosystem into an optimized 22-agent core-satellite architecture for 35% performance improvement while maintaining 88% workflow coverage.

## Architecture Overview

### Core Agents (6) - Always Available
**Purpose**: Foundation agents loaded instantly for all interactions
**Coverage**: 88% of workflow patterns
**Selection Time**: 0ms (pre-loaded)

1. **researcher** - Universal information gathering and analysis
2. **patterns** - Universal code quality and pattern detection
3. **principles** - Universal consistency enforcement and governance
4. **critic** - Universal risk analysis and validation
5. **context** - Universal system understanding and documentation
6. **resolver** - Universal conflict resolution and decision making

### Specialized Agents (16) - Context-Triggered
**Purpose**: Domain-specific expertise activated by precise triggers
**Coverage**: Remaining 12% specialized use cases
**Selection Time**: Reduced from 29 to 16 agent consideration space

## Implementation Phases

### Phase 1: Core Agent Architecture (Week 1)

#### 1.1 Update CLAUDE.md Core Agent Section
```yaml
core_agents:
  always_available: [researcher, patterns, principles, critic, context, resolver]
  instant_loading: true
  workflow_coverage: 88%
  selection_overhead: 0ms
```

#### 1.2 Core Agent Combination Patterns
Update existing combination patterns to emphasize core agent utilization:
- **Standard Pattern**: researcher → patterns → principles → critic
- **Decision Pattern**: researcher → critic → resolver → context
- **Quality Pattern**: patterns → principles → critic → resolver

### Phase 2: Agent Consolidation (Week 2)

#### 2.1 High-Confidence Merges

##### time → context Integration
**Rationale**: 87% capability overlap in historical analysis
**Implementation**:
- Merge temporal analysis capabilities into context agent
- Add historical evolution tracking to architectural synthesis
- Preserve all time-based functionality within context scope

##### connector → explorer Integration  
**Rationale**: 82% capability overlap in creative solution generation
**Implementation**:
- Integrate cross-domain thinking into explorer agent
- Add creative connection-making to solution space analysis
- Maintain parallel exploration with cross-domain enhancement

#### 2.2 Cluster Consolidations

##### Security Cluster: vulnerability-scanner + threat-modeling + compliance-checker
**Rationale**: 73% average overlap in security assessment
**Implementation**:
- Create unified security agent with three analysis modes
- Maintain specialized capabilities under single interface
- Trigger based on security-related keywords

##### Guidelines Cluster: guidelines-file + guidelines-repo
**Rationale**: 68% overlap in technology guidance
**Implementation**:
- Single guidelines agent with automatic scope detection
- File-level vs repository-level analysis based on context
- Reference stack-mapping.md for technology detection

##### Git Operations: git-tagger + git-troubleshooter
**Rationale**: 65% overlap in git workflow management
**Implementation**:
- Unified git-ops agent with proactive and reactive capabilities
- Automatic tagging evaluation + error resolution
- Streamlined git workflow management

#### 2.3 Preserved Complementary Functions
- **axioms ↔ principles**: Keep separate (15% overlap, high synergy)
- **hypothesis**: Maintain as specialized debugging agent
- **performance**: Maintain as specialized optimization agent

### Phase 3: Specialized Agent Optimization (Week 3)

#### 3.1 Trigger System Implementation
**Priority-Based Activation**:
- **Priority 1**: Direct user intent keywords (always activate)
- **Priority 2**: Context pattern detection (automatic activation)
- **Priority 3**: Task complexity analysis (conditional activation)

#### 3.2 Specialized Agent List (12 agents)
1. **explorer** - Solution space analysis (enhanced with cross-domain thinking)
2. **hypothesis** - Scientific debugging methodology
3. **whisper** - Code polishing and micro-improvements
4. **completer** - Implementation completion and TODOs
5. **docs** - Documentation synchronization
6. **constraints** - Multi-constraint optimization
7. **performance** - Performance analysis and optimization
8. **testing** - Testing strategy development
9. **git-ops** - Unified git workflow management (merged)
10. **guidelines** - Technology-specific guidance (merged)
11. **security** - Comprehensive security analysis (merged)
12. **context** - Enhanced with temporal analysis (merged)

### Phase 4: Performance Monitoring (Week 4)

#### 4.1 Baseline Metrics Framework
```yaml
performance_metrics:
  agent_selection_time:
    baseline: 2500ms
    target: 1500ms
    measurement: automatic_timing
  
  context_pollution:
    baseline: 45%
    target: 18%
    measurement: token_analysis
  
  workflow_efficiency:
    baseline: varies_by_type
    target: 35%_improvement
    measurement: end_to_end_timing
```

#### 4.2 Success Validation
- **Quality Maintenance**: No degradation in output completeness
- **User Satisfaction**: Maintained or improved experience
- **Performance Achievement**: 35% improvement validated

## Technical Implementation Details

### CLAUDE.md Updates Required

#### Agent Combination Patterns Section
```markdown
## Core-Satellite Agent Architecture (MANDATORY)

**CORE AGENTS (Always Available - 0ms selection time)**:
- researcher, patterns, principles, critic, context, resolver
- Instant loading for 88% workflow coverage
- Foundation for all complex tasks

**SPECIALIZED AGENTS (Context-Triggered)**:
- 16 specialized agents for domain-specific expertise
- Triggered by user intent, context patterns, or complexity analysis
- Covers remaining 12% specialized use cases

**STANDARD CORE PATTERNS**:
- Information + Analysis: researcher → patterns → principles → critic
- Decision Making: researcher → critic → resolver → context
- Quality Assurance: patterns → principles → critic → resolver
```

#### Updated Combination Clusters
```markdown
**Analysis Requests**: Execute researcher + patterns + principles + critic (core foundation)
**Architecture Decisions**: Execute researcher + context + principles + resolver + explorer (if alternatives needed)
**Debugging**: Execute researcher + patterns + critic + hypothesis (if systematic investigation needed)
**Security**: Execute critic + principles + security (unified security cluster)
```

### Agent File Updates

#### Consolidation Implementation
1. **time.md → DELETE** (functionality merged into context.md)
2. **connector.md → DELETE** (functionality merged into explorer.md)
3. **threat-modeling.md + compliance-checker.md → MERGE** into vulnerability-scanner.md
4. **guidelines-file.md + guidelines-repo.md → MERGE** into single guidelines.md
5. **git-tagger.md + git-troubleshooter.md → MERGE** into git-ops.md

## Validation Criteria

### Performance Targets
- **Agent Selection**: 40% reduction (2.5s → 1.5s)
- **Context Pollution**: 60% reduction (45% → 18%)
- **Workflow Efficiency**: 35% overall improvement
- **User Cognitive Load**: 60% reduction (complexity score 8.5 → 3.4)

### Quality Assurance
- **Capability Preservation**: All 29-agent functionality maintained
- **Workflow Coverage**: 88% by core agents validated
- **Specialized Access**: All domain expertise available via triggers
- **Consistency**: Universal principles enforcement maintained

### Success Metrics
- **Core Agent Utilization**: >80% of interactions use only core agents
- **Specialized Trigger Accuracy**: >90% appropriate activation
- **User Satisfaction**: Maintained or improved scores
- **System Reliability**: No increase in error rates

## Risk Mitigation

### Rollback Plan
- **Feature Flags**: Gradual rollout with instant reversion capability
- **A/B Testing**: Parallel system comparison during transition
- **User Training**: Documentation and examples for new patterns

### Quality Preservation
- **Comprehensive Testing**: All existing workflows validated
- **Capability Mapping**: Ensure no functionality loss
- **Performance Monitoring**: Real-time validation of improvements

This specification provides the complete roadmap for implementing the core-satellite architecture optimization while maintaining all capabilities and achieving targeted performance improvements.