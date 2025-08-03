# Detailed Copying Instructions

## Overview

This guide provides detailed, step-by-step instructions for copying configuration files from the Claude Code Template to your system. Follow these instructions exactly to ensure proper setup.

## Prerequisites

Before starting, ensure you have:
- Claude Code installed (`npm install -g @anthropic/claude-code`)
- Terminal access
- Appropriate permissions to modify your home directory
- The Claude Code Template repository cloned locally

## Directory Preparation

### Step 1: Create Required Directories

```bash
# Create the main Claude Code configuration directory
mkdir -p ~/.claude

# Create subdirectories
mkdir -p ~/.claude/agents
mkdir -p ~/.claude/agents/foundation
mkdir -p ~/.claude/agents/specialists
mkdir -p ~/.claude/commands
```

### Step 2: Verify Directory Structure

```bash
# Verify directories were created
ls -la ~/.claude
# Should show: agents/ commands/

ls -la ~/.claude/agents
# Should show: foundation/ specialists/
```

## Core Configuration Files

### Step 3: Copy Settings Files

```bash
# Navigate to the template directory
cd /path/to/claude-code-template

# Copy main settings file
cp .claude/settings.json ~/.claude/settings.json

# Copy local settings file  
cp .claude/settings.local.json ~/.claude/settings.local.json

# Verify files were copied
ls -la ~/.claude/*.json
```

**Expected output**:
```
-rw-r--r-- 1 user user    2 date settings.json
-rw-r--r-- 1 user user  110 date settings.local.json
```

### What These Files Do

**settings.json**: Main Claude Code configuration
- Currently minimal (empty object)
- Future versions may include global settings

**settings.local.json**: Local environment permissions
- Controls command permissions
- Security settings for bash commands
- Local environment overrides

## Agent Configuration Files

### Step 4: Copy Foundation Agents

Foundation agents are the core AI assistants used for all complex tasks.

```bash
# Copy all foundation agents
cp .claude/agents/foundation/foundation-research.md ~/.claude/agents/foundation/
cp .claude/agents/foundation/foundation-patterns.md ~/.claude/agents/foundation/
cp .claude/agents/foundation/foundation-criticism.md ~/.claude/agents/foundation/
cp .claude/agents/foundation/foundation-principles.md ~/.claude/agents/foundation/
cp .claude/agents/foundation/foundation-context.md ~/.claude/agents/foundation/
cp .claude/agents/foundation/foundation-conflicts.md ~/.claude/agents/foundation/

# Verify foundation agents
ls ~/.claude/agents/foundation/
```

**Expected output**:
```
foundation-conflicts.md
foundation-context.md
foundation-criticism.md
foundation-patterns.md
foundation-principles.md
foundation-research.md
```

#### Foundation Agent Descriptions

| Agent | Purpose | Auto-Invoked When |
|-------|---------|------------------|
| **foundation-research.md** | Information gathering, best practices | Any request needing external knowledge |
| **foundation-patterns.md** | Code pattern recognition, architecture analysis | Code reviews, refactoring requests |
| **foundation-criticism.md** | Critical analysis, honest feedback | All requests requiring evaluation |
| **foundation-principles.md** | SOLID principles, design pattern enforcement | Architecture decisions, code quality |
| **foundation-context.md** | Deep system understanding, context synthesis | Complex system analysis |
| **foundation-conflicts.md** | Mediate between competing agent approaches | When agents provide conflicting advice |

### Step 5: Copy Specialist Agents

Specialist agents are domain-specific experts for particular technologies or workflows.

```bash
# Copy all specialist agents
cp .claude/agents/specialists/specialist-code-cleaner.md ~/.claude/agents/specialists/
cp .claude/agents/specialists/specialist-constraint-solver.md ~/.claude/agents/specialists/
cp .claude/agents/specialists/specialist-git-workflow.md ~/.claude/agents/specialists/
cp .claude/agents/specialists/specialist-meta-programmer.md ~/.claude/agents/specialists/
cp .claude/agents/specialists/specialist-options-analyzer.md ~/.claude/agents/specialists/
cp .claude/agents/specialists/specialist-performance-optimizer.md ~/.claude/agents/specialists/
cp .claude/agents/specialists/specialist-prompt-engineer.md ~/.claude/agents/specialists/
cp .claude/agents/specialists/specialist-stack-advisor.md ~/.claude/agents/specialists/
cp .claude/agents/specialists/specialist-test-strategist.md ~/.claude/agents/specialists/
cp .claude/agents/specialists/specialist-todo-manager.md ~/.claude/agents/specialists/

# Verify specialist agents
ls ~/.claude/agents/specialists/
```

**Expected output**:
```
specialist-code-cleaner.md
specialist-constraint-solver.md
specialist-git-workflow.md
specialist-meta-programmer.md
specialist-options-analyzer.md
specialist-performance-optimizer.md
specialist-prompt-engineer.md
specialist-stack-advisor.md
specialist-test-strategist.md
specialist-todo-manager.md
```

#### Specialist Agent Descriptions

| Agent | Purpose | Triggered For |
|-------|---------|---------------|
| **specialist-code-cleaner.md** | Code quality improvement, refactoring | Code cleanup, style improvements |
| **specialist-constraint-solver.md** | Handle competing requirements | Complex requirement analysis |
| **specialist-git-workflow.md** | Git operations, version control | Git issues, workflow automation |
| **specialist-options-analyzer.md** | Solution exploration, alternatives | Decision making, approach comparison |
| **specialist-performance-optimizer.md** | Performance analysis and optimization | Speed/memory optimization requests |
| **specialist-prompt-engineer.md** | AI prompt creation and optimization | Creating effective AI prompts |
| **specialist-stack-advisor.md** | Technology selection, architecture | Technology recommendations |
| **specialist-test-strategist.md** | Testing strategies, test design | Test planning, quality assurance |
| **specialist-todo-manager.md** | Task organization, project management | Task tracking, project planning |
| **specialist-meta-programmer.md** | Code generation, template creation | Automated code generation |

## Command Configuration Files

### Step 6: Copy Core Commands

Commands provide instant access to common development tasks via slash commands.

```bash
# Copy core command files
cp .claude/commands/review.md ~/.claude/commands/
cp .claude/commands/test.md ~/.claude/commands/
cp .claude/commands/refactor.md ~/.claude/commands/
cp .claude/commands/security.md ~/.claude/commands/
cp .claude/commands/stacks.md ~/.claude/commands/
cp .claude/commands/discuss.md ~/.claude/commands/
cp .claude/commands/research.md ~/.claude/commands/
cp .claude/commands/fix.md ~/.claude/commands/
cp .claude/commands/generate.md ~/.claude/commands/
cp .claude/commands/performance.md ~/.claude/commands/
cp .claude/commands/monitor.md ~/.claude/commands/
cp .claude/commands/deploy.md ~/.claude/commands/
cp .claude/commands/git.md ~/.claude/commands/
cp .claude/commands/doc-update.md ~/.claude/commands/
cp .claude/commands/version-prepare.md ~/.claude/commands/

# Verify core commands
ls ~/.claude/commands/*.md
```

#### Core Command Descriptions

| Command | Purpose | Usage Example |
|---------|---------|---------------|
| `/review` | Comprehensive code review | `/review` - Analyzes current code for improvements |
| `/test` | Testing assistance and strategy | `/test` - Generates tests and testing plans |
| `/refactor` | Code improvement suggestions | `/refactor` - Suggests code restructuring |
| `/security` | Security audit and recommendations | `/security` - Scans for security vulnerabilities |
| `/stacks` | List available technology stacks | `/stacks` - Shows available tech stack guidance |
| `/discuss` | Critical analysis of ideas | `/discuss` - Get honest feedback on proposals |
| `/research` | Research and information gathering | `/research` - Find best practices and solutions |
| `/fix` | Problem diagnosis and resolution | `/fix` - Debug and resolve issues |
| `/generate` | Code and template generation | `/generate` - Create boilerplate and templates |
| `/performance` | Performance analysis | `/performance` - Optimize for speed and efficiency |
| `/monitor` | System monitoring setup | `/monitor` - Set up monitoring and metrics |
| `/deploy` | Deployment assistance | `/deploy` - Help with deployment planning |
| `/git` | Git workflow assistance | `/git` - Git operations and troubleshooting |
| `/doc-update` | Update documentation | `/doc-update` - Sync docs with code changes |
| `/version-prepare` | Prepare version releases | `/version-prepare` - Release planning and prep |

### Step 7: Copy Command Groups

Copy organized command groups for specialized functionality.

```bash
# Create command group directories
mkdir -p ~/.claude/commands/agents
mkdir -p ~/.claude/commands/commands  
mkdir -p ~/.claude/commands/todo

# Copy agent management commands
cp .claude/commands/agents/audit.md ~/.claude/commands/agents/
cp .claude/commands/agents/create.md ~/.claude/commands/agents/
cp .claude/commands/agents/guide.md ~/.claude/commands/agents/

# Copy command management commands
cp .claude/commands/commands/create.md ~/.claude/commands/commands/
cp .claude/commands/commands/review.md ~/.claude/commands/commands/

# Copy TODO management commands
cp .claude/commands/todo/cleanup.md ~/.claude/commands/todo/
cp .claude/commands/todo/create.md ~/.claude/commands/todo/
cp .claude/commands/todo/next.md ~/.claude/commands/todo/
cp .claude/commands/todo/review.md ~/.claude/commands/todo/

# Verify command groups
ls ~/.claude/commands/agents/
ls ~/.claude/commands/commands/
ls ~/.claude/commands/todo/
```

#### Command Group Descriptions

**Agent Management Commands**:
- `/agents-audit` - Audit agent usage and effectiveness
- `/agents-create` - Create new custom agents
- `/agents-guide` - Guide to using agents effectively

**Command Management Commands**:
- `/commands-create` - Create new custom commands
- `/commands-review` - Review and improve existing commands

**TODO Management Commands**:
- `/todo-create` - Create and organize tasks
- `/todo-next` - Get next priority task
- `/todo-review` - Review task progress
- `/todo-cleanup` - Clean up completed tasks

## Project-Specific Files

### Step 8: Copy Project Guidelines (Optional)

For project-specific setup, copy additional files to your project directory.

```bash
# Navigate to your project directory
cd /path/to/your/project

# Copy main project guidelines
cp /path/to/claude-code-template/CLAUDE.md ./

# Create support directory (optional)
mkdir -p .support

# Copy support files if needed
cp -r /path/to/claude-code-template/.support/prompts .support/
cp -r /path/to/claude-code-template/.support/instructions .support/
```

**Project Files Explained**:
- **CLAUDE.md**: Project-specific guidelines for Claude Code
- **.support/prompts/**: Reusable prompts and templates
- **.support/instructions/**: Additional guidelines and frameworks

## Verification Steps

### Step 9: Verify File Structure

Check that all files were copied correctly:

```bash
# Check main directory structure
tree ~/.claude -I "*.log"
```

**Expected structure**:
```
~/.claude/
├── agents/
│   ├── foundation/
│   │   ├── foundation-conflicts.md
│   │   ├── foundation-context.md
│   │   ├── foundation-criticism.md
│   │   ├── foundation-patterns.md
│   │   ├── foundation-principles.md
│   │   └── foundation-research.md
│   └── specialists/
│       ├── specialist-code-cleaner.md
│       ├── specialist-constraint-solver.md
│       ├── specialist-git-workflow.md
│       ├── specialist-meta-programmer.md
│       ├── specialist-options-analyzer.md
│       ├── specialist-performance-optimizer.md
│       ├── specialist-prompt-engineer.md
│       ├── specialist-stack-advisor.md
│       ├── specialist-test-strategist.md
│       └── specialist-todo-manager.md
├── commands/
│   ├── agents/
│   ├── commands/
│   ├── todo/
│   └── [various .md files]
├── settings.json
└── settings.local.json
```

### Step 10: File Count Verification

```bash
# Count foundation agents (should be 6)
ls ~/.claude/agents/foundation/*.md | wc -l

# Count specialist agents (should be 10)
ls ~/.claude/agents/specialists/*.md | wc -l

# Count core commands (should be 15)
ls ~/.claude/commands/*.md | wc -l

# Check settings files (should be 2)
ls ~/.claude/settings*.json | wc -l
```

### Step 11: File Permissions

Set appropriate permissions:

```bash
# Set directory permissions
find ~/.claude -type d -exec chmod 755 {} \;

# Set file permissions
find ~/.claude -type f -exec chmod 644 {} \;

# Verify permissions
ls -la ~/.claude/
ls -la ~/.claude/agents/foundation/
```

## Troubleshooting Copy Issues

### Permission Denied Errors

```bash
# If you get permission denied errors:
sudo chown -R $USER:$USER ~/.claude
chmod -R 755 ~/.claude
find ~/.claude -type f -exec chmod 644 {} \;
```

### File Not Found Errors

```bash
# If source files are missing, verify template structure:
ls -la .claude/agents/foundation/
ls -la .claude/commands/

# Re-clone template if files are missing:
git clone https://github.com/yourusername/claude-code-template.git
```

### Incomplete Copies

```bash
# If copies are incomplete, use bulk copy commands:
cp -r .claude/* ~/.claude/

# Then verify structure:
find ~/.claude -name "*.md" | wc -l
# Should show 29 total .md files (6 foundation + 10 specialists + 13+ commands)
```

## Final Verification

### Step 12: Test Configuration

Start Claude Code and verify the configuration is loaded:

```bash
# Start Claude Code
claude

# Test commands in Claude Code:
# /review
# /stacks  
# /agents-guide
```

### Step 13: Test Agent Coordination

Ask Claude Code to perform a complex task that should trigger multiple agents:

"Please review this code and suggest improvements with a focus on performance and maintainability."

You should see evidence of multiple agents working together (foundation agents + specialists).

## Next Steps

After successful copying:

1. **Set up environment variables** - Add API keys to your shell configuration
2. **Test all commands** - Try each slash command to ensure they work
3. **Customize for your needs** - Modify agents and commands as needed
4. **Read the configuration reference** - Understand what each file does

Your Claude Code Template is now manually installed and ready to use!