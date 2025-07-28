# Getting Started with Claude Code Template

## What This Does

Transform your Claude Code experience with:
- ✅ **20+ AI agents** with mandatory coordination (minimum 3+ agents for complex tasks)
- ✅ **Custom slash commands** like `/review`, `/test`, `/refactor` for instant help
- ✅ **Technology-specific guidance** - Python, Rust, Java, JavaScript, and more
- ✅ **Persistent memory** - Claude remembers your project decisions across sessions
- ✅ **Automatic documentation** - Updates docs with every code change
- ✅ **Automatic setup** - One-time install, works in every project

## Quick Start (5 Minutes)

**Recommended**: Use as GitHub Dotfiles
1. [Fork this repository](https://github.com/your-username/claude-code-template/fork) and rename it to `dotfiles`
2. Go to GitHub Settings → Codespaces → Dotfiles → Enable
3. Open any project in Claude Code - you now have superpowers! ✨

**Try immediately:**
```
/review          # Get comprehensive code feedback
/agent-guide     # Explore your AI helpers  
/discuss         # Challenge your architectural ideas
```

## What You Get

### Essential AI Agents (Mandatory Baseline)
- **`researcher`** - Find answers and current best practices
- **`patterns`** - Spot code problems and suggest improvements
- **`critic`** - Get honest feedback on your ideas and decisions

**Note**: These 3 agents are automatically used together for all non-trivial requests as part of the mandatory coordination protocol.

### Advanced AI Agents
<details>
<summary>Click to see 16 more specialized agents</summary>

**Problem Solving:**
- `hypothesis` - Scientific debugging approach
- `constraints` - Handle competing requirements
- `resolver` - Mediate conflicting approaches

**Code Quality:**
- `completer` - Find missing functionality and TODOs
- `whisper` - Micro-improvements and polish
- `invariants` - Type safety and state machines

**Architecture:**
- `explorer` - Generate multiple solution approaches
- `axioms` - First-principles reasoning
- `context` - Deep system understanding
- `principles` - Apply SOLID, DRY, KISS principles

**Workflow:**
- `generator` - Code generation and templates
- `prompter` - AI agent development
- `time` - Historical analysis and evolution
- `connector` - Cross-domain creative solutions
- `tagger` - Automatic release management

</details>

### Custom Commands
- `/review` - Comprehensive code review
- `/test` - Testing assistance and generation
- `/refactor` - Code improvement suggestions  
- `/security` - Security audit and recommendations

## Documentation Guides

| Guide | Purpose |
|-------|---------|
| **[Features](features.md)** | Complete overview of all capabilities |
| **[TODO System](todo-system.md)** | Task management and progress tracking |
| **[Memory System](memory-system.md)** | How persistent memory works |
| **[Customization](customization.md)** | Adapt the template for your project |

## Real-World Examples

**Note**: All examples automatically include the mandatory baseline agents (researcher + patterns + critic) plus any additional specialized agents.

### Debugging a Complex Bug
```
1. /discuss "Should I rewrite this authentication module?"
2. System automatically uses: researcher + patterns + critic + hypothesis
3. /test to generate test cases that isolate the problem
```

### Architecture Review
```
1. /review to get comprehensive feedback on your code
2. System automatically uses: researcher + patterns + critic + principles
3. Documentation automatically updated with architectural decisions
```

### New Feature Planning
```
1. Use explorer agent for multiple approaches (includes baseline agents)
2. Use constraints agent to handle competing requirements  
3. /discuss the trade-offs before implementing
4. Documentation automatically updated when feature is implemented
```

## Troubleshooting

**Commands not working?**
- Make sure you're in a Claude Code session
- Check that the template was installed correctly with `ls .claude/`

**Agents not responding as expected?**
- Try being more specific about what you want
- Use `/agent-guide` to see what each agent does best

**Memory not persisting?**
- Memory is handled by Claude Code's built-in MCP memory server
- No additional setup required for basic memory functionality

## Need Help?

- 📖 **[Full Feature Guide](features.md)** - Everything the template can do
- 📋 **[TODO System Guide](todo-system.md)** - Task management and progress tracking
- 🛠️ **[Customization Guide](customization.md)** - Make it yours
- 🐛 **Issues?** [Report bugs or request features](https://github.com/your-username/claude-code-template/issues)

---

*Ready to supercharge your coding with AI? Install the template and try `/review` on your current code!*