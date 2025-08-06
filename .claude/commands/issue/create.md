---
description: Create new GitHub Issue with proper classification and metadata.
argument-hint: Issue DESCRIPTION to create.
allowed-tools: Task
---

# GitHub Issue Creation

Create new GitHub Issue with proper classification and metadata in ondrasek/claude-code-forge repository.

## Instructions

1. Parse $ARGUMENTS for issue creation parameters:
   - --type [feat|fix|docs|refactor|test|chore] (force specific issue type)
   - --priority [high|medium|low] (override priority assessment)
   - --assignee [username] (assign to specific GitHub user)
   - DESCRIPTION (required issue description text)

2. Delegate issue creation to github-issues-workflow agent with enhanced coordination
1. invoke github-issues-workflow agent: create new GitHub Issue with enhanced agent coordination
2. coordinate parallel issue analysis:
   - **Classification Cluster**: patterns + principles + researcher (classify issue type with pattern recognition and researcher validation)
   - **Priority Assessment Cluster**: critic + constraint-solver (assess priority based on urgency, impact, and constraints)
   - **Completeness Validation Cluster**: code-cleaner + stack-advisor + constraint-solver (ensure complete issue specification with documentation standards)
3. generate descriptive issue title validated by code-cleaner + principles agents
4. create GitHub Issue with comprehensive metadata validated by stack-advisor + test-strategist agents

PARAMETERS:
--type [feat|fix|docs|refactor|test|chore] (force specific issue type)
--priority [high|medium|low] (override priority assessment)
--assignee [username] (assign to specific GitHub user)
DESCRIPTION (issue description text)

ENHANCED_AGENT_DELEGATION:
Primary: github-issues-workflow (comprehensive issue creation with universal agent coordination)
Classification: patterns + principles + researcher
Priority Assessment: critic + constraints + time
Completeness Validation: completer + docs + invariants
Quality Assurance: critic + principles + completer

ENHANCED_OUTPUT:
- GitHub Issue created in ondrasek/claude-code-forge with comprehensive metadata validation
- Issue properly classified and prioritized through multi-agent analysis
- Completeness verification ensuring all necessary information captured
- Clean confirmation without context pollution with quality assurance

EXAMPLE:
/issue create --type feat --priority high "Implement user authentication with JWT tokens"

BEHAVIOR:
- Delegates ALL issue management to github-issues-workflow agent
- Keeps main context clean and focused
- Returns only essential creation confirmation
- No issue tracking pollution in main conversation