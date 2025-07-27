# LangChain Agent Development Command

Help me develop, test, and debug a LangChain agent:

## Development Tasks

1. **Agent Architecture**
   - Design the agent's tools and capabilities
   - Set up the LLM configuration
   - Configure memory (conversation, summary, etc.)
   - Implement custom tools

2. **Implementation**
   - Create the agent executor
   - Set up tool descriptions
   - Implement error handling
   - Add logging and monitoring

3. **Testing**
   - Write unit tests for tools
   - Test agent decision-making
   - Validate output parsing
   - Test error scenarios

4. **Optimization**
   - Improve prompt engineering
   - Optimize token usage
   - Enhance tool descriptions
   - Fine-tune agent behavior

## Common Patterns

### ReAct Agent
```python
from langchain.agents import create_react_agent
from langchain.tools import Tool
```

### Conversational Agent
```python
from langchain.agents import create_conversational_retrieval_agent
from langchain.memory import ConversationBufferMemory
```

### Custom Tools
```python
from langchain.tools import BaseTool
from pydantic import BaseModel
```

## What I Need to Know

1. What type of agent are you building?
2. What tools/capabilities does it need?
3. What LLM are you using?
4. Any specific challenges you're facing?