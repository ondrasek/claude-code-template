# /review

TRIGGER: code review request
FOCUS: quality, security, best practices
SCOPE: uncommitted changes by default, or specified files/commits

ENHANCED_ACTIONS:
1. git analysis with researcher + time + context agents for comprehensive change understanding
2. coordinate enhanced parallel review clusters for comprehensive analysis:
   - **Pattern & Quality Cluster**: patterns + principles + critic + researcher (find duplication, check SOLID, critical assessment with research validation)
   - **Security Analysis Cluster**: vulnerability-scanner + threat-modeling + compliance-checker + researcher (comprehensive security analysis with threat intelligence)
   - **Performance & Architecture Cluster**: performance + constraints + invariants + hypothesis (performance analysis with architectural validation)
   - **Completeness & Testing Cluster**: completer + testing + patterns + critic (test coverage analysis with gap identification)
   - **Documentation & Standards Cluster**: docs + guidelines-repo + principles + completer (documentation verification with standards compliance)
3. synthesize multi-dimensional findings with resolver + critic + principles validation
4. generate prioritized remediation roadmap with time + constraints + completer analysis

PARAMETERS:
--focus [security|performance|testing|docs]
--commits N (review last N commits)
--severity [critical|high|medium|low]
--fix (auto-fix simple issues)
FILES... (specific files to review)

ENHANCED_AGENT_CLUSTERS:
Pattern & Quality: patterns + principles + critic + researcher + whisper
Security Analysis: vulnerability-scanner + threat-modeling + compliance-checker + researcher
Performance & Architecture: performance + constraints + invariants + hypothesis + axioms
Completeness & Testing: completer + testing + patterns + critic + performance
Documentation & Standards: docs + guidelines-repo + principles + completer + time
Validation & Synthesis: resolver + critic + principles + invariants + completer
Coordination: All clusters execute in parallel for comprehensive multi-dimensional analysis

ENHANCED_OUTPUT:
- Multi-dimensional analysis results from enhanced specialized clusters with universal agent validation
- Categorized issues by severity and domain validated by critic + principles + resolver agents
- Cross-cluster validation with comprehensive findings correlation using patterns + researcher + context agents
- Prioritized remediation roadmap with dependency mapping analyzed by constraints + time + resolver agents
- Risk assessment with confidence scores from multiple analytical perspectives validated by critic + hypothesis + invariants agents
- Memory-informed recommendations based on historical patterns researched by researcher + time + context agents
- Comprehensive completeness assessment ensuring no gaps via completer + testing + docs agents
- Performance impact analysis with optimization recommendations from performance + constraints + patterns agents

## Memory Integration

**Before Review**: Use `mcp__memory__search_nodes()` to check for:
- Previous review findings and patterns for similar code changes
- Historical issue patterns and successful remediation approaches
- Code quality trends and improvement effectiveness
- Team-specific anti-patterns and coding preferences

**After Review**: Store findings with `mcp__memory__create_entities()` and `mcp__memory__create_relations()`:
- Review outcome patterns and improvement effectiveness
- Cross-domain issue relationships (security + performance, etc.)
- Remediation success rates and time-to-resolution patterns
- Code quality evolution trends and team learning patterns

## Agent Integration

**Enhanced Parallel Review Clusters** ensure comprehensive coverage with universal agent integration:
- **Pattern & Quality**: patterns + principles + whisper + critic + researcher for comprehensive code quality assessment with research validation
- **Security Analysis**: vulnerability-scanner + threat-modeling + compliance-checker + researcher + patterns for comprehensive security analysis with threat intelligence and pattern recognition
- **Performance & Architecture**: performance + constraints + hypothesis + axioms + invariants for optimization opportunities with architectural validation
- **Completeness & Testing**: completer + testing + docs + patterns + critic for comprehensive gap identification with quality validation
- **Documentation & Standards**: docs + guidelines-repo + principles + completer + time for design validation with historical context and completeness assessment
- **Validation & Synthesis**: resolver + critic + principles + invariants + completer for cross-cluster validation and conflict resolution

**Cross-Cluster Validation**: Findings are validated across multiple analytical dimensions for comprehensive accuracy

## Related Commands

- `/security` - Focused security analysis with security specialist agents
- `/test` - Test coverage improvements with testing agent coordination
- `/refactor` - Implement review suggestions with advanced agent coordination
- `/agent-ecosystem-review` - Analyze review process effectiveness