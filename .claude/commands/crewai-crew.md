# CrewAI Development Command

Help me build and debug a CrewAI multi-agent system:

## CrewAI Development Tasks

1. **Crew Architecture**
   - Design agent roles and responsibilities
   - Define tasks and workflows
   - Set up inter-agent communication
   - Configure tools for each agent

2. **Agent Implementation**
   ```python
   from crewai import Agent, Task, Crew
   ```
   - Create specialized agents
   - Define agent goals and backstories
   - Assign appropriate tools
   - Set up delegation rules

3. **Task Design**
   - Break down complex workflows
   - Define task dependencies
   - Set expected outputs
   - Configure task callbacks

4. **Crew Orchestration**
   - Sequential vs parallel execution
   - Error handling strategies
   - Result aggregation
   - Performance monitoring

## Common Patterns

### Research Crew
- Researcher Agent: Gathers information
- Analyst Agent: Processes data
- Writer Agent: Creates reports

### Development Crew
- Architect Agent: Designs solutions
- Developer Agent: Implements code
- Tester Agent: Validates implementation

### Business Crew
- Strategy Agent: Plans approach
- Execution Agent: Implements plans
- Review Agent: Quality control

## Debugging Checklist

1. Agent communication issues
2. Task delegation problems
3. Tool execution errors
4. Memory/context management
5. Output formatting

## What I Need to Know

1. What is your crew trying to accomplish?
2. How many agents do you need?
3. What tools does each agent require?
4. Any specific workflow requirements?