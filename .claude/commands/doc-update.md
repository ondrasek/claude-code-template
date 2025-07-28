# /doc-update

TRIGGER: documentation update request, code changes requiring doc sync
FOCUS: comprehensive documentation synchronization with code changes
SCOPE: all project documentation including README, CHANGELOG, API docs, guides

ACTIONS:
1. invoke docs agent: systematic documentation analysis and update coordination
2. coordinate parallel documentation analysis:
   - **patterns + completer**: identify documentation gaps and inconsistencies
   - **researcher + time**: analyze documentation evolution and historical patterns
   - **guidelines-repo + constraints**: ensure documentation follows project standards
   - **critic + testing**: validate documentation accuracy and completeness
3. generate comprehensive documentation update plan with priority mapping
4. implement updates with cross-reference validation and consistency checking

PARAMETERS:
--scope [api|readme|changelog|all] (documentation scope, default: all)
--changes-since [commit|tag|date] (analyze changes since specific point)
--validate-examples (test all code examples for accuracy)
--dry-run (show what would be updated without making changes)
--priority [critical|high|medium|low] (filter updates by priority)

AGENT_CLUSTERS:
Primary Documentation: docs (comprehensive documentation strategy)
Gap Analysis: patterns + completer + whisper
Historical Context: researcher + time + context
Standards Compliance: guidelines-repo + constraints + principles
Quality Validation: critic + testing + invariants
Coordination: All clusters support docs agent leadership

OUTPUT:
- Comprehensive documentation audit with gap identification
- Prioritized update plan with change impact analysis
- Cross-referenced documentation updates ensuring consistency
- Validation report for all code examples and technical accuracy
- Integration with git workflow for synchronized commits

## Documentation Analysis Framework

**Multi-Dimensional Documentation Assessment**:
- **Content Accuracy**: Code example validation and technical correctness
- **Completeness**: Gap identification and coverage analysis
- **Consistency**: Cross-document reference validation and style compliance
- **Usability**: User journey analysis and accessibility assessment
- **Maintenance**: Historical update patterns and sustainability analysis

**Memory-Enhanced Documentation**: Leverages historical documentation effectiveness and user feedback patterns

## Memory Integration

**Before Documentation Update**: Use `mcp__memory__search_nodes()` to check for:
- Previous documentation update patterns and effectiveness
- Historical user feedback and documentation pain points
- Successful documentation structures and content strategies
- Cross-project documentation best practices and lessons learned

**After Documentation Update**: Store findings with `mcp__memory__create_entities()` and `mcp__memory__create_relations()`:
- Documentation update effectiveness and user engagement metrics
- Content structure evolution and accessibility improvements
- Cross-document relationship patterns and maintenance strategies
- Documentation-code synchronization success rates and automation opportunities

## Focus Areas

- **New features**: README features section + usage examples + API documentation
- **Breaking changes**: CHANGELOG entries + migration guides + compatibility matrices
- **API changes**: Endpoint documentation + parameter updates + response examples
- **Configuration changes**: Setup instructions + environment variables + deployment guides
- **Bug fixes**: CHANGELOG entries + corrected examples + troubleshooting updates
- **Performance improvements**: Documentation of optimizations + benchmark updates
- **Security enhancements**: Security documentation + best practices + compliance updates

## Integration with Development Workflow

**Synchronized with Simple Git Protocol**:
1. Documentation updates committed with related code changes
2. Cross-validation with code examples and technical accuracy
3. Automated consistency checking across all documentation
4. Integration with version management and release documentation

## Related Commands

- `/review` - Include documentation review in comprehensive code analysis
- `/refactor` - Ensure documentation updates accompany code refactoring
- `/version-prepare` - Integrate with release documentation and CHANGELOG generation
- `/agent-ecosystem-review` - Analyze documentation process effectiveness and agent coordination