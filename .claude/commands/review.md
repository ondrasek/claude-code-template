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
- categorized issues by severity
- file:line references
- specific fix recommendations with code examples
- overall risk assessment