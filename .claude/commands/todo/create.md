---
description: Create new TODO task with proper classification and metadata.
argument-hint: Task DESCRIPTION to create.
allowed-tools: Task
---

# TODO Creation

Create new TODO task with proper classification and metadata in .support/specs/ directory.

## Instructions

1. Parse $ARGUMENTS for task creation parameters:
   - --type [feat|fix|docs|refactor|test|chore] (force specific task type)
   - --priority [high|medium|low] (override priority assessment)
   - --assignee [agent-name] (assign to specific agent)
   - DESCRIPTION (required task description text)

2. Delegate task creation to specs-analyst agent with enhanced coordination
1. invoke todo agent: create new TODO file with enhanced agent coordination
2. coordinate parallel task analysis:
   - **Classification Cluster**: patterns + principles + researcher (classify task type with pattern recognition and researcher validation)
   - **Priority Assessment Cluster**: critic + constraint-solver (assess priority based on urgency, impact, and constraints)
   - **Completeness Validation Cluster**: code-cleaner + stack-advisor + constraint-solver (ensure complete task specification with documentation standards)
3. generate kebab-case filename validated by code-cleaner + principles agents
4. create markdown file with comprehensive metadata validated by stack-advisor + test-strategist agents

PARAMETERS:
--type [feat|fix|docs|refactor|test|chore] (force specific task type)
--priority [high|medium|low] (override priority assessment)
--assignee [agent-name] (assign to specific agent)
DESCRIPTION (task description text)

ENHANCED_AGENT_DELEGATION:
Primary: todo (comprehensive task creation with universal agent coordination)
Classification: patterns + principles + researcher
Priority Assessment: critic + constraints + time
Completeness Validation: completer + docs + invariants
Quality Assurance: critic + principles + completer

ENHANCED_OUTPUT:
- TODO file created in .support/specs/ with comprehensive metadata validation
- Task properly classified and prioritized through multi-agent analysis
- Completeness verification ensuring all necessary information captured
- Clean confirmation without context pollution with quality assurance

EXAMPLE:
/todo-create --type feat --priority high "Implement user authentication with JWT tokens"

BEHAVIOR:
- Delegates ALL task management to todo agent
- Keeps main context clean and focused
- Returns only essential creation confirmation
- No TODO tracking pollution in main conversation