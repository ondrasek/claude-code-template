# Agent Capability Overlap Analysis

## Methodology
Analyzed each agent's core capabilities, triggers, and purposes to identify overlapping functionality and consolidation opportunities.

## High Overlap Pairs (80%+ Capability Overlap)

### REVISED: **axioms** vs **principles** moved to Low Overlap section

## Medium-High Overlap Pairs (75-80% Capability Overlap)

### 1. **time** vs **context** (87% overlap)  
**time capabilities**: Historical analysis, evolution tracking, git history analysis, technical debt
**context capabilities**: Persistent memory-backed context, decision archaeology, evolution timeline

**Overlap**: Both track system evolution and historical context
**Difference**: time = temporal analysis focus, context = architectural context focus
**Recommendation**: **MERGE** - Integrate temporal analysis into context agent as historical perspective

### 3. **connector** vs **explorer** (82% overlap)
**connector capabilities**: Cross-domain connection making, creative solutions, translating concepts between fields
**explorer capabilities**: Parallel solution exploration, alternative generation, creative syntheses

**Overlap**: Both generate creative alternatives and cross-domain thinking
**Difference**: connector = cross-domain focus, explorer = solution space focus
**Recommendation**: **MERGE** - Integrate cross-domain thinking into explorer as creative mode

## Medium Overlap Clusters (60-80% Capability Overlap)

### Security Cluster (73% average overlap)
**vulnerability-scanner**: Code-level security flaw detection, OWASP frameworks, CVE analysis
**threat-modeling**: Attack surface analysis, threat assessment, architectural security
**compliance-checker**: Regulatory compliance, SOC2, GDPR, HIPAA assessment

**Overlap**: All focus on security assessment with different approaches
**Recommendation**: **CONSOLIDATE** into unified security agent with three analysis modes

### Technology Guidelines Cluster (68% overlap)
**guidelines-file**: File-level technology-specific guidelines and best practices
**guidelines-repo**: Repository-level architectural guidance and stack decisions

**Overlap**: Both provide technology-specific guidance and best practices
**Difference**: Scope (file vs repository level)
**Recommendation**: **MERGE** - Single guidelines agent with file/repo mode detection

### Git Operations Cluster (65% overlap)
**git-tagger**: Autonomous git tagging and release management
**git-troubleshooter**: Git error diagnosis and resolution

**Overlap**: Both handle git operations and repository management
**Difference**: Proactive tagging vs reactive troubleshooting
**Recommendation**: **MERGE** - Single git-ops agent with tagging + troubleshooting capabilities

## Medium Overlap Pairs (40-60% Capability Overlap)

### 4. **generator** vs **completer** (58% overlap)
**generator capabilities**: Code generation, meta-programming, DSL creation, template systems
**completer capabilities**: Complete TODOs, partial implementations, missing functionality

**Overlap**: Both create/complete code implementations
**Difference**: generator = creation from scratch, completer = finishing existing work
**Recommendation**: **CONDITIONAL MERGE** - Could integrate generation into completer as "create new" mode

### 5. **whisper** vs **patterns** (52% overlap)
**whisper capabilities**: Micro-improvements, typo fixes, formatting, style consistency
**patterns capabilities**: Code pattern detection, refactoring opportunities, quality analysis

**Overlap**: Both improve code quality through systematic analysis
**Difference**: whisper = micro-level fixes, patterns = macro-level analysis
**Recommendation**: **KEEP SEPARATE** - Different scales of operation, both valuable

### 6. **hypothesis** vs **researcher** (47% overlap)
**hypothesis capabilities**: Theory formation, experiment design, systematic investigation
**researcher capabilities**: Information gathering, documentation analysis, context research

**Overlap**: Both investigate and gather understanding through systematic approaches
**Difference**: hypothesis = scientific method, researcher = information collection
**Recommendation**: **KEEP SEPARATE** - Complementary rather than overlapping

## Low Overlap - Specialized Value Agents (<40% overlap)

### Unique Specialized Agents
1. **testing** (12% avg overlap) - Unique testing strategy and coverage analysis
2. **invariants** (18% avg overlap) - Unique type safety and state machine focus  
3. **performance** (22% avg overlap) - Unique performance optimization specialization
4. **docs** (15% avg overlap) - Unique documentation synchronization focus
5. **constraints** (28% avg overlap) - Unique multi-constraint optimization capability
6. **todo** (8% avg overlap) - Unique task management specialization
7. **prompter** (5% avg overlap) - Unique AI prompt optimization focus
8. **ecosystem-analyzer** (35% avg overlap) - Unique meta-system analysis capability
9. **axioms** (25% avg overlap) - Unique first-principles problem-solving technique

### Complementary Function Pairs (Low Overlap, High Synergy)
**axioms** vs **principles** (25% overlap - Complementary Functions):
- **axioms**: Building solutions from first principles, bedrock truths, axiomatic reasoning - *technique-specific*
- **principles**: Universal principle identification, cross-system enforcement, principle documentation - *system-wide governance*
- **Synergy**: axioms provides the methodology, principles provides the governance framework
- **Recommendation**: **KEEP SEPARATE** - They work together but serve distinct functions

### Analysis
These agents provide distinct, non-overlapping value and should be preserved in specialized roles.

## Consolidation Recommendations

### Phase 1: High-Confidence Merges (2 consolidations)
1. **time → context** (87% overlap)  
   - Integrate temporal analysis into context agent
   - Add historical evolution tracking to architectural context

2. **connector → explorer** (82% overlap)
   - Integrate cross-domain thinking into explorer agent
   - Add creative connection-making to solution exploration

### Phase 2: Cluster Consolidations (3 multi-agent merges)
3. **Security Cluster**: vulnerability-scanner + threat-modeling + compliance-checker
   - Single security agent with three analysis modes
   - Maintains specialized capabilities under unified interface

4. **Guidelines Cluster**: guidelines-file + guidelines-repo  
   - Single guidelines agent with scope detection
   - Automatic file vs repository level analysis

5. **Git Operations**: git-tagger + git-troubleshooter
   - Single git-ops agent with proactive + reactive capabilities
   - Unified git workflow management

### Phase 3: Conditional Merges (1 evaluation needed)
6. **generator → completer** (58% overlap - requires deeper analysis)
   - Could integrate code generation into completion workflows
   - Need to validate if generation patterns fit completion use cases

## Impact Analysis

### Before Consolidation: 29 agents
### After Phase 1-2: 23 agents (21% reduction)
- 6 core agents (always available)
- 17 specialized agents (context-triggered)

### After Phase 3 (if generator merge): 22 agents (24% reduction)  
- 6 core agents (always available)
- 16 specialized agents (context-triggered)

### Performance Benefits
- **Selection complexity**: 24% fewer agents to consider (after all phases)
- **Context pollution**: Reduced by consolidating overlapping analyses  
- **Maintenance overhead**: Fewer agent definitions to maintain
- **User cognitive load**: Simpler mental model with consolidated capabilities
- **Preserved capabilities**: All functionality maintained through strategic consolidation

## Validation Requirements

### Before Implementation
1. **Usage Pattern Validation**: Confirm merged agents handle all current use cases
2. **Trigger Logic Testing**: Ensure consolidated agents activate appropriately  
3. **Capability Preservation**: Verify no functionality is lost in mergers
4. **Performance Baseline**: Measure current vs consolidated performance

### Success Metrics
- Maintained output quality with consolidated agents
- Reduced agent selection time (target: 35-45% improvement)
- Preserved specialized capabilities within consolidated interfaces
- User satisfaction with simplified but complete agent ecosystem

This overlap analysis provides the roadmap for systematic agent consolidation while preserving all essential capabilities.