# /review

TRIGGER: code review request
FOCUS: quality, security, best practices
SCOPE: uncommitted changes by default, or specified files/commits

ACTIONS:
1. git diff for changes OR git log for recent commits
2. invoke patterns agent: find code duplication, anti-patterns
3. invoke principles agent: check SOLID violations
4. scan for security vulnerabilities: SQL injection, XSS, hardcoded secrets
5. check test coverage for modified code
6. verify documentation updates

PARAMETERS:
--focus [security|performance|testing|docs]
--commits N (review last N commits)
--severity [critical|high|medium|low]
--fix (auto-fix simple issues)
FILES... (specific files to review)

AGENT_CHAIN:
patterns -> principles -> security -> complete -> docsync

OUTPUT:
- Multi-dimensional analysis results from all specialized clusters
- Categorized issues by severity and domain (quality/security/performance/completeness/architecture)
- Cross-cluster validation of findings and recommendations
- Prioritized remediation roadmap with dependency mapping
- Risk assessment with confidence scores from multiple analytical perspectives
- Memory-informed recommendations based on historical patterns and outcomes

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

**Parallel Review Clusters** ensure comprehensive coverage:
- **Quality**: patterns + principles + whisper + critic for code quality assessment
- **Security**: vulnerability-scanner + threat-modeling + compliance-checker for security analysis
- **Performance**: performance + constraints + hypothesis for optimization opportunities
- **Completeness**: completer + testing + docs for gap identification
- **Architecture**: explorer + invariants + guidelines-repo for design validation

**Cross-Cluster Validation**: Findings are validated across multiple analytical dimensions for comprehensive accuracy

## Related Commands

- `/security` - Focused security analysis with security specialist agents
- `/test` - Test coverage improvements with testing agent coordination
- `/refactor` - Implement review suggestions with advanced agent coordination
- `/agent-ecosystem-review` - Analyze review process effectiveness