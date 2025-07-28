# Memory System Guide

The memory system is what makes this Claude Code template truly powerful - it provides persistent context and learning across all your development sessions.

## What the Memory System Does

Unlike standard Claude Code sessions that forget everything when they end, this template creates persistent memory that:

- **Remembers architectural decisions** and the reasoning behind them
- **Learns your coding patterns** and preferences over time  
- **Maintains project context** across multiple sessions
- **Stores important findings** from agent analysis
- **Tracks evolution** of your codebase and decisions

## How It Works

### MCP Memory Server
The system uses the Model Context Protocol (MCP) memory server that:
- Stores data in default memory.db location (managed by Claude Code)
- Automatically saves context before git commits via `/memory-export`
- Provides cross-session access to stored information
- Integrates seamlessly with Claude Code's conversation flow

### Automatic Memory Export
The template is configured with a git hook that automatically exports memory before commits:

```json
{
  "hooks": {
    "beforeBashExecution": {
      "patterns": ["git commit*", "git add -A && git commit*"],
      "command": "/memory-export"
    }
  }
}
```

This ensures important context is preserved at every commit point.

## What Gets Stored

### Architectural Decisions
- Design pattern choices and rationale
- Technology stack decisions
- API design principles
- Database schema evolution

### Code Patterns
- Recurring patterns in your codebase
- Naming conventions you prefer
- Code organization strategies
- Testing approaches

### Agent Insights
- Findings from the `patterns` agent about your code structure
- Recommendations from the `principles` agent
- Security concerns identified by analysis
- Performance optimization opportunities

### Project Evolution  
- Historical context from the `time` agent
- Evolution of requirements and constraints
- Lessons learned from previous implementations

## Memory Agents

Two specialized agents manage the memory system:

### `/memory-export` Agent
- **Purpose**: Exports current session context to persistent storage
- **When it runs**: Automatically before git commits
- **What it saves**: Key decisions, patterns found, important insights
- **Manual use**: Run `/memory-export` to save current context

### `/memory-import` Agent  
- **Purpose**: Retrieves relevant context from previous sessions
- **When it runs**: Automatically when starting new sessions
- **What it retrieves**: Related architectural decisions, relevant patterns
- **Manual use**: Run `/memory-import` to reload specific context

## Storage Structure

The memory system uses a knowledge graph approach:

### Entities
- **Project components** (services, modules, classes)
- **Architectural decisions** (patterns, principles applied)
- **Code patterns** (recurring structures, conventions)
- **Historical events** (major refactors, design changes)

### Relations
- **Dependencies** between components
- **Evolution** of design decisions over time
- **Pattern applications** to specific code areas
- **Decision rationale** linking choices to requirements

### Observations
- **Agent findings** about code quality
- **Performance insights** from analysis
- **Security recommendations** 
- **Refactoring opportunities**

## Leveraging Memory Effectively

### For New Projects
1. **Document early decisions** - The memory system learns your preferences
2. **Use consistent patterns** - Help the system recognize your conventions
3. **Export memory regularly** - Don't rely only on git hook exports
4. **Review imported context** - Start sessions by checking what's remembered

### For Ongoing Projects
1. **Reference past decisions** - Ask Claude Code to recall previous architectural choices
2. **Build on patterns** - The system will suggest consistent approaches
3. **Track evolution** - Use the `time` agent to understand how code has changed
4. **Maintain context** - Regular memory exports keep understanding current

### Advanced Usage
1. **Cross-project learning** - Memory can inform patterns across different projects
2. **Team knowledge sharing** - Export/import memory for team consistency  
3. **Decision archaeology** - Understand why past choices were made
4. **Pattern evolution** - See how your coding approaches have matured

## Memory Commands

### Manual Memory Management
```bash
# Export current session context
/memory-export

# Import relevant past context
/memory-import  

# Search memory for specific topics
/memory-search "authentication patterns"

# View memory statistics
/memory-stats
```

### Querying Memory
- **Ask about past decisions**: "What did we decide about the database layer?"
- **Request pattern recall**: "What naming conventions do we use for services?"
- **Get evolution context**: "How has our error handling approach changed?"
- **Check consistency**: "Are we following the same patterns we established earlier?"

## Benefits Over Standard Claude Code

### Standard Claude Code
- ❌ Forgets everything after each session
- ❌ No memory of past architectural decisions  
- ❌ Cannot build on previous analysis
- ❌ Repetitive explanations of project context

### With Memory System
- ✅ Maintains context across all sessions
- ✅ Remembers and builds on architectural decisions
- ✅ Learns from previous agent analysis
- ✅ Provides continuity and project understanding

## Privacy and Storage

### Local Storage
- Memory database managed by Claude Code in default location
- Exported memory files stored in `.support/memories/` for version control
- No external services or cloud storage involved
- You control retention and deletion

### What's Safe to Store
- Architectural decisions and reasoning
- Code patterns and conventions
- Design principles and guidelines
- Non-sensitive technical insights

### What to Avoid
- Sensitive credentials or API keys
- Personal or confidential information
- Large binary data or complete code dumps
- Temporary debugging information

## Troubleshooting

### Memory Not Persisting
1. Verify MCP memory server is running (`claude mcp status`)
2. Ensure git hooks are properly configured for `/memory-export`
3. Try manual `/memory-export` to test functionality
4. Check that `.support/memories/` directory is writable

### Performance Issues
1. Memory database getting too large - consider periodic cleanup
2. Slow memory queries - database may need optimization
3. Export taking too long - reduce context size before export

### Memory Issues
1. Export memory regularly with `/memory-export` for backup
2. Use `./.support/scripts/validate-template.sh` to check system health
3. Reimport memory with `/memory-import` if needed

The memory system transforms Claude Code from a stateless assistant into an intelligent development partner that grows smarter with every interaction.

---

**Next Steps:**
- 📋 Master [TODO Management](todo-system.md) for organized workflows
- 🛠️ Learn about [Customization](customization.md) options
- 📖 Explore all [Features](features.md) of the template
- 📚 Return to [Getting Started](getting-started.md)