# /review

TRIGGER: code review request
FOCUS: quality, security, best practices
SCOPE: uncommitted changes by default, or specified files/commits

ENHANCED_ACTIONS:
1. **Initial Context Loading**: foundation-context + foundation-researcher parallel analysis for comprehensive change understanding
2. **Aggressive Parallel Review Clusters** (4-6 agents minimum per phase):
   - **Core Quality Cluster**: foundation-patterns + foundation-principles + foundation-critic + foundation-researcher (code quality assessment with memory-enhanced pattern analysis)
   - **Deep Analysis Cluster**: foundation-context + foundation-patterns + foundation-researcher + foundation-critic + specialist-security (comprehensive system analysis with security validation)
   - **Architecture & Performance Cluster**: foundation-context + foundation-principles + foundation-critic + specialist-performance + specialist-constraints (architectural validation with performance analysis)
   - **Completeness & Testing Cluster**: foundation-patterns + foundation-principles + specialist-completer + specialist-testing + foundation-critic (comprehensive gap identification with quality validation)
   - **Documentation & Standards Cluster**: specialist-docs + specialist-guidelines-repo + foundation-principles + foundation-researcher + specialist-completer (documentation verification with standards compliance)
3. **Synthesis & Resolution Phase**: foundation-resolver + foundation-critic + foundation-principles + foundation-researcher (conflict resolution with validated recommendations)
4. **Memory Integration Workflow**: All foundation agents store findings for institutional knowledge building

PARAMETERS:
--focus [security|performance|testing|docs|architecture]
--commits N (review last N commits)
--severity [critical|high|medium|low]
--fix (auto-fix simple issues)
--memory (include historical review patterns)
FILES... (specific files to review)

AGGRESSIVE_PARALLEL_CLUSTERS:
Core Quality (4 agents): foundation-patterns + foundation-principles + foundation-critic + foundation-researcher
Deep Analysis (5 agents): foundation-context + foundation-patterns + foundation-researcher + foundation-critic + specialist-security  
Architecture & Performance (5 agents): foundation-context + foundation-principles + foundation-critic + specialist-performance + specialist-constraints
Completeness & Testing (5 agents): foundation-patterns + foundation-principles + specialist-completer + specialist-testing + foundation-critic
Documentation & Standards (5 agents): specialist-docs + specialist-guidelines-repo + foundation-principles + foundation-researcher + specialist-completer
Synthesis & Resolution (4 agents): foundation-resolver + foundation-critic + foundation-principles + foundation-researcher

COORDINATION_PROTOCOL: All clusters execute simultaneously via single message with multiple Task() calls for genuine parallel processing

ENHANCED_OUTPUT:
- **Memory-Enhanced Analysis**: Findings built on historical review patterns and institutional knowledge
- **Multi-Dimensional Assessment**: Results from 4-6 agent clusters with comprehensive cross-validation
- **Structured Issue Categorization**: Severity and domain classification with confidence scores
- **Conflict Resolution**: foundation-resolver mediates competing recommendations from multiple perspectives
- **Prioritized Remediation**: Action items ranked by impact, effort, and historical success patterns
- **Institutional Knowledge**: All findings stored in memory graph for future reference and team learning
- **Comprehensive Coverage**: No analytical gaps through aggressive parallel cluster coordination

## Memory Integration Workflow

**BEFORE Review** (Automatic via foundation agents):
- **foundation-patterns**: Load historical code pattern discoveries and evolution trends
- **foundation-critic**: Check stored risk assessments and failure patterns from similar changes
- **foundation-researcher**: Access external best practices and community solutions for identified issues  
- **foundation-context**: Load architectural evolution context and historical decision rationale
- **foundation-principles**: Review previous principle violation patterns and resolution effectiveness

**DURING Review** (Memory-enhanced analysis):
- **Pattern Evolution Tracking**: Compare current patterns to stored historical data
- **Risk Assessment Enhancement**: Validate risks against stored failure precedents
- **Research Integration**: Apply stored external knowledge to current code context
- **Context-Aware Analysis**: Use architectural memory for system-appropriate recommendations
- **Principle Adherence Trends**: Track principle compliance patterns over time

**AFTER Review** (Institutional knowledge preservation):
- **Pattern Storage**: Update pattern entities with new discoveries and frequency changes
- **Risk Documentation**: Store new risks and update historical success/failure rates
- **Research Archiving**: Preserve validated external solutions and implementation guidance
- **Context Evolution**: Record architectural changes and their impact on review findings
- **Principle Learning**: Document principle application outcomes and team preferences
- **Resolution Patterns**: Store successful conflict resolutions and their effectiveness

## Foundation Agent Integration

**AGGRESSIVE PARALLEL EXECUTION** (4-6 agents per cluster, all clusters simultaneous):

### Core Quality Cluster (4 agents)
- **foundation-patterns**: Memory-enhanced pattern detection and evolution tracking
- **foundation-principles**: SOLID/DRY/KISS validation with historical principle adherence data
- **foundation-critic**: Risk assessment with evidence-based alternative approaches  
- **foundation-researcher**: External best practices research and implementation guidance

### Deep Analysis Cluster (5 agents)  
- **foundation-context**: Architectural understanding with persistent memory-backed system synthesis
- **foundation-patterns**: Code structure analysis within architectural context
- **foundation-researcher**: External security research and vulnerability intelligence
- **foundation-critic**: Security risk assessment with historical failure pattern analysis
- **specialist-security**: Focused security analysis and compliance validation

### Architecture & Performance Cluster (5 agents)
- **foundation-context**: System architecture evolution and decision archaeology
- **foundation-principles**: Architectural principle validation (separation of concerns, loose coupling)
- **foundation-critic**: Performance risk assessment and scalability concerns
- **specialist-performance**: Performance optimization opportunities and bottleneck analysis
- **specialist-constraints**: Technical constraint analysis and trade-off evaluation

### Completeness & Testing Cluster (5 agents)
- **foundation-patterns**: Test pattern analysis and coverage gap identification
- **foundation-principles**: Testing principle adherence (AAA, single responsibility)
- **specialist-completer**: Comprehensive gap analysis and missing component identification
- **specialist-testing**: Test strategy optimization and quality assurance
- **foundation-critic**: Testing approach risk assessment and alternative strategies

### Documentation & Standards Cluster (5 agents)
- **specialist-docs**: Documentation quality analysis and maintenance requirements
- **specialist-guidelines-repo**: Repository-level standards compliance and guideline adherence
- **foundation-principles**: Documentation principle validation (clarity, maintainability)
- **foundation-researcher**: Documentation best practices and tooling research
- **specialist-completer**: Documentation completeness assessment and gap identification

### Synthesis & Resolution Phase (4 agents)
- **foundation-resolver**: Conflict mediation between competing cluster recommendations
- **foundation-critic**: Final risk assessment of proposed resolutions
- **foundation-principles**: Validate final recommendations against design principles
- **foundation-researcher**: Additional research for complex resolution scenarios

**COORDINATION PROTOCOL**: 
- **Single Message Execution**: All 5 clusters (28 total agents) execute simultaneously via single message with multiple Task() calls
- **Memory Integration**: Each foundation agent automatically stores findings in persistent memory graph
- **Cross-Cluster Synthesis**: foundation-resolver mediates conflicts and synthesizes final recommendations
- **Capability Boundary Awareness**: Each agent operates within defined boundaries to prevent overlap and ensure comprehensive coverage

## Execution Workflow

### Phase 1: Initial Analysis (2 agents parallel)
```
Task: "Load system context and research baseline" (foundation-context)
Task: "Research external best practices for identified technologies" (foundation-researcher)
```

### Phase 2: Core Review Clusters (28 agents across 5 parallel clusters)
```
Task: "Execute Core Quality analysis" (foundation-patterns + foundation-principles + foundation-critic + foundation-researcher)
Task: "Execute Deep Analysis review" (foundation-context + foundation-patterns + foundation-researcher + foundation-critic + specialist-security)
Task: "Execute Architecture & Performance analysis" (foundation-context + foundation-principles + foundation-critic + specialist-performance + specialist-constraints)
Task: "Execute Completeness & Testing review" (foundation-patterns + foundation-principles + specialist-completer + specialist-testing + foundation-critic)
Task: "Execute Documentation & Standards analysis" (specialist-docs + specialist-guidelines-repo + foundation-principles + foundation-researcher + specialist-completer)
```

### Phase 3: Synthesis & Resolution (4 agents parallel)
```
Task: "Resolve conflicts and synthesize recommendations" (foundation-resolver + foundation-critic + foundation-principles + foundation-researcher)
```

**MINIMUM AGENT COUNT**: 34 agents total (exceeds 6-agent requirement per CLAUDE.md aggressive parallel usage mandate)

**MEMORY INTEGRATION**: All foundation agents automatically store findings in persistent memory graph for institutional knowledge building

## Enhanced Output Structure

### Review Summary
- **Scope**: Files/commits analyzed with git context
- **Agent Execution**: Confirmation of all 34 agents executed successfully  
- **Memory Status**: Historical patterns loaded and new findings stored
- **Overall Assessment**: Critical/High/Medium/Low with confidence scores

### Multi-Dimensional Findings
- **Code Quality Issues**: From foundation-patterns with historical trend analysis
- **Principle Violations**: From foundation-principles with impact assessment
- **Security Concerns**: From specialist-security with threat intelligence
- **Performance Issues**: From specialist-performance with optimization opportunities
- **Architecture Risks**: From foundation-context with evolution analysis
- **Testing Gaps**: From specialist-testing with coverage analysis
- **Documentation Issues**: From specialist-docs with completeness assessment

### Conflict Resolution Results
- **Competing Approaches**: Identified by foundation-resolver
- **Trade-off Analysis**: Risk vs benefit with historical precedent data
- **Recommended Path**: Evidence-based decision with success probability
- **Mitigation Strategies**: For chosen approach based on stored risk patterns

### Prioritized Action Plan
- **Critical (Fix Immediately)**: Security vulnerabilities, system stability risks
- **High Priority**: Principle violations with significant impact, performance bottlenecks
- **Medium Priority**: Code quality improvements, testing gaps
- **Low Priority**: Documentation updates, minor consistency issues

### Memory Integration Report
- **Patterns Stored**: New code patterns and evolution trends preserved
- **Risks Documented**: Failure patterns and mitigation strategies recorded
- **Research Archived**: External solutions and best practices saved
- **Context Updated**: Architectural changes and decision rationale preserved
- **Resolution Patterns**: Successful conflict resolutions stored for future reference

## Related Commands

- `/security` - Focused security analysis with specialist-security agent
- `/test` - Test coverage improvements with specialist-testing coordination
- `/refactor` - Implement review suggestions with foundation agent coordination
- `/performance` - Deep performance analysis with specialist-performance focus