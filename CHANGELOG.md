# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Removed
- **TODO Cleanup**: Removed 5 completed/obsolete TODO files from .support/todos/
- document-agent-combination-patterns.md (completed - patterns now in CLAUDE.md)
- simplify-todo-system.md (completed - system modernized in v2.6.1)
- update-agent-selection-keywords.md (completed - keywords optimized in v2.12.0)
- ditch-mcp-memory.md (obsolete - different memory approach implemented)
- researcher-current-year.md (obsolete - current year issue resolved)

### Changed
- Updated document-parallel-agent-clusters.md and update-agent-usage-instructions.md status to completed

## [2.16.0] - 2025-07-28

### Added
- **NEW AGENT**: git-troubleshooter agent for systematic git error recovery and repository diagnostics
- Comprehensive 169-line diagnostic framework covering 5 problem categories (repository state, remote sync, merge conflicts, history issues, configuration)
- 3-phase resolution methodology: information gathering → problem classification → resolution execution
- MCP memory integration for learning successful resolution patterns and building institutional troubleshooting knowledge
- Enhanced Simple Git Protocol with error recovery guidance in CLAUDE.md
- Updated agent ecosystem documentation to reflect 28 total agents across all project files

## [2.15.0] - 2025-07-28

### Enhanced
- **MAJOR**: Complete agent-guide.md overhaul from outdated 11-agent to current 26-agent ecosystem
- Added comprehensive documentation for security agent split (vulnerability-scanner, threat-modeling, compliance-checker)
- Enhanced multi-agent coordination patterns with proven workflow examples  
- Added proactive agent usage protocol demonstrating automatic Claude Code behavior
- Included gold standard agent references and ecosystem health metrics (92/100 across all agents)
- Integrated sophisticated multi-agent workflow documentation for complex tasks
- Updated conditional technology guidelines system documentation (guidelines-file, guidelines-repo)

## [2.14.0] - 2025-07-28

### Changed
- **MAJOR**: Split monolithic security agent into 3 specialized computational thinking pattern agents
- **vulnerability-scanner**: Code-level security flaw detection and pattern matching
- **threat-modeling**: Attack surface analysis and systems thinking for architectural security  
- **compliance-checker**: Rule-based regulatory standards assessment (SOC2, GDPR, HIPAA)
- Enhanced multi-agent coordination with mandatory researcher, patterns, critic, context, constraints integration
- Added comprehensive security workflow documentation with industry-specific patterns
- Improved agent specialization following single-thinking-pattern creation principle

## [2.13.0] - 2025-07-28

### Added
- **MAJOR**: Three new computational thinking pattern agents expand core system capabilities
- **security agent**: Systematic vulnerability detection, threat modeling, OWASP framework coverage
- **performance agent**: Algorithmic complexity analysis, bottleneck identification, optimization strategies  
- **testing agent**: Comprehensive test case generation, coverage analysis, testing strategy development
- New multi-agent workflow combinations: Security Review, Performance Optimization, Quality Assurance
- Each agent follows creation principles with >250 lines of specialized computational thinking patterns

## [2.12.0] - 2025-07-28

### Enhanced
- **MAJOR**: Completed agent description optimization for all 11 core agents
- Added MUST USE/PROACTIVELY keywords for +200% selection algorithm effectiveness
- Enhanced "Expert at" capability statements for clearer boundaries
- Improved trigger phrase detection with quoted user language patterns
- Optimized automatic agent activation patterns across the entire system

## [2.11.0] - 2025-07-28

### Added
- **MAJOR**: Mandatory agent description template system with empirical validation
- Tier 1 keyword guidelines (MUST USE, PROACTIVELY use, AUTOMATICALLY)  
- Proven template examples with selection optimization insights
- Template compliance requirements for all future agents

### Enhanced  
- **completer agent**: Upgraded with MUST USE + Expert capability statement
- **critic agent**: Upgraded with MUST USE + Expert risk analysis capability  
- **todo agent**: Upgraded with PROACTIVELY + Expert task lifecycle capability

## [2.10.0] - 2025-07-28

### Enhanced
- **agent-audit command**: Redesigned with individual agent spawning strategy
- 4-phase workflow: discovery, parallel spawning, aggregation, reporting
- Analysis quality improved through isolated contexts per agent evaluation
- Context pollution prevention by using separate audit agents per target
- Parallel execution for improved performance and focused attention per agent

## [2.9.0] - 2025-07-28

### Added
- **MAJOR**: Conditional technology guidelines system with intelligent agent coordination
- guidelines-file agent: MUST USE before modifying files when technology patterns unclear
- guidelines-repo agent: MUST USE for architecture decisions when stack context undetermined
- Centralized detection logic in .support/instructions/stack-mapping.md
- Session-aware guideline state tracking to prevent redundant loading
- Intelligent conditional invocation system that only loads relevant guidelines when needed

### Changed
- Replace static technology detection rules with intelligent conditional agent system
- CLAUDE.md streamlined from 17-line detection rules to 4-line agent protocol
- Context efficiency improved by 50%+ through conditional guideline loading
- Enhanced system scalability with easy extensibility without bloating main context
- Architecture now supports intelligent caching and performance optimization

### Performance
- Conditional loading prevents redundant agent calls and context pollution
- Only loads relevant technology guidelines when actually needed
- Maintains same functionality with significantly improved efficiency
- Session-aware state management reduces redundant operations

## [2.8.0] - 2025-07-28

### Changed
- **MAJOR**: Complete .support structure cleanup and documentation organization
- Flattened docs organization by moving all files from docs/developer-guide/ to docs/
- Removed docs/developer-guide/ subfolder (unnecessary nesting)
- Deleted .support/templates/ directory (outdated TODO template format)
- Deleted .support/prompts/ directory (generic prompts, no unique value)  
- Simplified .support/ to contain only essential directories: stacks/, scripts/, todos/
- Updated all documentation references to reflect flattened structure
- Streamlined template architecture for better usability and maintenance

## [2.7.1] - 2025-07-28

### Removed
- Obsolete protocol files from .support/instructions (memory-protocol.md, todo-protocol.md)
- Redundant git-workflow.md (functionality consolidated in CLAUDE.md)
- Generic debug-mcp.md command (functionality removed)

### Changed
- Moved instruction files from .support/instructions/ to docs/ for human reference
- Separated AI operational instructions (CLAUDE.md) from human-readable developer guides
- Updated all documentation references to reflect new file locations
- Created docs/README.md explaining purpose of developer reference materials

## [2.7.0] - 2025-07-28

### Added
- Complete TODO management command suite with agent delegation
- `/todo-create` command for new task creation via todo agent
- `/todo-review` command for analyzing existing TODOs and prioritization 
- `/todo-cleanup-done` command for removing implemented TODOs (CHANGELOG verified)
- `/todo-cleanup-stale` command for removing obsolete/irrelevant TODOs
- All commands maintain clean context principle through agent coordination

## [2.6.1] - 2025-07-28

### Changed
- **MAJOR**: Complete TODO protocol modernization with agent-based management
- Removed 5 command files (521 lines): todo.md, todo-add.md, todo-complete.md, todo-release.md, todo-status.md
- Replaced with context-clean TODO agent (110 lines) for specialized task coordination
- Updated all documentation to reflect agent-based TODO system (README.md, features.md, getting-started.md, customization.md)
- Removed todo-system.md documentation file
- Created sample TODO file for user authentication implementation
- Eliminated context pollution from TODO management while preserving full functionality

## [2.6.0] - 2025-07-28

### Changed
- Updated README.md and features.md to reflect new mandatory protocols from CLAUDE.md
- Added mandatory agent coordination requirements (minimum 3+ agents for non-trivial requests)
- Added mandatory documentation protocol (automatic updates with every code change)
- Enhanced best practices and automation features documentation

## [2.5.1] - 2025-07-28

### Changed
- Implemented mandatory 4-step git protocol directly in CLAUDE.md for improved compliance
- Moved critical git workflow to primary operational instructions
- Simplified agent coordination with clear protocol requirements
- Enhanced operational reliability by ensuring protocol visibility in main context

## [2.5.0] - 2025-07-28

### Removed
- **MAJOR**: Removed memory export/import functionality entirely (366 lines removed)
- Deleted `.support/memories/` directory and all memory files
- Removed memory export references from git workflow documentation
- Deleted memory-system.md documentation file
- Removed memory-export/import command references from all documentation

### Changed
- Simplified memory handling to use only Claude Code's built-in MCP memory server
- Updated documentation to reflect streamlined memory architecture
- Reduced system complexity by eliminating custom memory management layer

## [2.4.0] - 2025-07-28

### Changed
- **MAJOR**: Completed stack file reference conversion with 48% final reduction (859 lines removed)
- Converted cpp.md, java.md, and ruby.md from verbose tutorials to concise reference cards
- Achieved 59% total reduction across all stack files (3,571 → 1,477 lines)
- Enhanced autonomous operation efficiency while preserving all essential development patterns
- Completed major documentation architecture optimization phase

## [2.3.0] - 2025-07-28

### Changed
- **MAJOR**: Implemented 60% instruction simplification reducing operational complexity
- Consolidated memory protocol eliminating 1,260+ lines of boilerplate documentation
- Streamlined core agent files from 148-173 lines to ~40 lines each (researcher.md, completer.md, critic.md)
- Converted python.md stack file from 467-line tutorial to 82-line quick reference
- Enhanced autonomous operation efficiency while preserving all core functionality
- All agents now reference shared memory protocol for consistency

## [2.0.1] - 2025-07-28

### Added
- Specialized tagger agent for autonomous release management
- 5-point assessment criteria for intelligent milestone evaluation (completeness, stability, value, logical breakpoint, significance)
- Autonomous tag creation without context pollution
- MCP memory integration for learning successful tagging patterns
- Updated git workflow to automatically invoke tagger after commits

### Changed
- Git workflow now includes automatic tagger agent invocation after each commit
- Streamlined release process with autonomous decision-making
- CLAUDE.md updated to reference new autonomous tagging system

## [1.5.3] - 2025-01-28

### Added
- Automatic intelligent tagging system for Claude Code
- Autonomous release detection without user prompting required
- Automatic tag assessment criteria: completeness, stability, value, logical breakpoint
- Auto-update CHANGELOG.md and auto-increment versioning capabilities
- Simple TODO management system using individual markdown files in todos/ directory
- Updated `/todo` command to use only Claude Code built-in tools (Glob, Read, Write, Edit)
- Technology stack detection section in CLAUDE.md
- Git workflow instructions emphasizing frequent commits and trunk-based development
- Organized instruction files: documentation.md, agent-usage.md, versioning.md

### Changed
- **MAJOR**: Drastically streamlined CLAUDE.md to eliminate redundancy with built-in Claude Code features
- Added .claude configuration principles emphasizing AI-first design and zero redundancy
- Reduced CLAUDE.md from verbose instructions to project-specific overrides only
- Separated AI-optimized configuration (.claude) from human-readable docs (docs/, README.md)
- Simplified TODO management approach - removed complex Python scripts and CLI tools
- Restored original TODO.md content with agent parallelism optimization notes
- Enhanced versioning.md with simplified TODO workflow
- Reorganized instructions into topic-specific files in .claude/instructions/
- Updated CLAUDE.md to use @ syntax for file references
- Added technology stack detection rules for automatic language-specific guidance
- Added trunk-based development rules and automatic commit/push policy
- Added C# detection rule for .cs, .csproj, and .sln files

### Removed
- Removed complex TODO management scripts (todo-manager.py, claude-todo, scan-todos.py, install-todo-system.sh)
- Removed verbose TODO implementation documentation (docs/todo-management-system.md, docs/todo-system-implementation.md)
- Removed redundant MCP servers from .mcp.json (filesystem, fetch) - Claude Code has built-in capabilities
- Removed git protocol details from CLAUDE.md - moved to modular instructions
- Removed redundant `config.json` file - all configuration now in CLAUDE.md and settings.json
- Removed VERSIONING.md file - versioning instructions moved to docs/versioning.md
- Removed customInstructions field from settings.json (invalid field)

## [1.4.0] - 2025-01-27

### Added
- New `critic` agent to prevent sycophancy and challenge ideas
- `/discuss` command for critical analysis of proposals
- MCP memory integration for storing patterns and principles across sessions
- Documentation philosophy in docsync agent

### Changed
- docsync agent now strongly prefers updating existing docs over creating new ones
- patterns and principles agents now use MCP memory server for persistent storage
- Updated agent count to 19 total agents

### Improved
- Documentation strategy to avoid file proliferation
- Critical thinking capabilities with dedicated skeptical agent

## [1.3.1] - 2025-01-27

### Changed
- Made all agent descriptions more specific with clear triggers
- Added keywords, phrases, and commands that activate each agent
- Maintained emphasis patterns (PROACTIVELY, AUTOMATICALLY, MUST BE USED)
- Fixed prompt-engineer agent to focus on user's project agents, not template agents

### Removed
- Deleted unnecessary .claude/agents/examples/ folder

### Fixed
- Agent descriptions now include specific activation scenarios
- Better agent selection through concrete trigger words

## [1.3.0] - 2025-01-27

### Added
- New `prompt-engineer` agent for creating optimized AI framework prompts
- `/create-prompt` command for easy prompt generation
- Example implementation: patterns-langchain-gpt4.md
- Support for LangChain, CrewAI, AutoGen prompt optimization

### Changed
- Updated agent count to 18 total agents
- Enhanced CLAUDE.md with prompt-engineer usage guidelines

## [1.2.1] - 2025-01-27

### Changed
- Optimized agent files for AI efficiency (70%+ size reduction)
  - patterns.md: 70 → 29 lines
  - whisper.md: 80+ → 29 lines  
  - researcher.md: 131 → 39 lines
  - docsync.md: 128 → 36 lines
- Optimized doc-update command: 78 → 22 lines
- Removed ASCII art and graphical structures from python.md
- Removed verbose metaphors and descriptions
- Focus on actionable, concise instructions

### Removed
- Deleted CLAUDE_CODE_TOOLS.md (redundant reference)
- Removed PostgreSQL from example MCP config

### Fixed
- All markdown files now optimized for Claude Code processing
- Better context efficiency and faster agent loading

## [1.2.0] - 2025-01-27

### Added
- CLAUDE_CODE_TOOLS.md documenting all built-in Claude Code tools
- Clear guidance on which MCP servers are redundant vs useful

### Changed
- Removed redundant filesystem and fetch MCP servers from default configuration
- Updated .mcp.json to only include memory server (adds unique value)
- Updated example configurations to exclude redundant servers
- Modified install.sh to only install non-redundant MCP tools
- Updated README to clarify MCP tool usage

### Fixed
- Eliminated unnecessary MCP server overhead for built-in functionality
- Clearer documentation prevents users from installing redundant tools

## [1.1.1] - 2025-01-27

### Added
- VERSIONING.md with semantic versioning guidelines
- Version badge in README.md
- Versioning section in CLAUDE.md with quick reference

### Changed
- Renamed `verify-setup.sh` to `validate-template.sh` for clarity
- Improved script documentation and purpose description
- Updated all references to use new filename

### Fixed
- Script naming now accurately reflects its purpose as a template validator

## [1.1.0] - 2025-01-27

### Added
- Modular technology stack system in `.claude/stacks/`
- Python-specific guidelines moved to `.claude/stacks/python.md`
- New commands: `/stacks` and `/use-python` for stack management
- Python expert agent for Python-specific assistance
- MCP servers README with detailed configuration instructions
- Proper `.mcp.json` file for Claude Code MCP configuration

### Changed
- Improved agent descriptions with action-oriented language and specific triggers
- Updated MCP configuration to use `.mcp.json` instead of settings.json
- Enhanced verification script to check new features
- Refined customInstructions to reference technology stacks

### Fixed
- Corrected MCP server configuration location for Claude Code
- Updated all agent descriptions to follow best practices

## [1.0.0] - 2025-01-27

### Added
- Initial release of Claude Code Configuration Template
- Complete dotfiles setup with automatic installation via `install.sh`
- 16 specialized AI agents organized by pattern-based and first-principles approaches:
  - Pattern-based agents: context, patterns, explore, whisper, constraints, time, connect, complete, hypothesis, meta
  - First-principles agents: principles, axioms, invariants
  - Utility agents: resolve (conflict resolution), docsync (documentation), researcher (parallel searches)
- Custom slash commands:
  - `/review` - Comprehensive code review
  - `/test` - Testing assistance  
  - `/refactor` - Code improvement
  - `/security` - Security audit
  - `/langchain-agent` - LangChain development
  - `/crewai-crew` - CrewAI multi-agent systems
  - `/python-uv` - Python project setup with uv
  - `/agent-guide` - Guide for using specialized AI agents
  - `/doc-update` - Update documentation to match code changes
- MCP (Model Context Protocol) tool integrations:
  - filesystem - Local file access
  - memory - Persistent session memory
  - fetch - Web content retrieval
- Automation hooks for security and code quality
- Comprehensive agent usage guidelines in CLAUDE.md
- Python development workflow using uv exclusively
- Documentation maintenance workflow with automatic synchronization
- Git aliases for Claude-powered commits and PRs

### Configuration
- Main configuration moved to `.claude/settings.json` (auto-loaded by Claude Code)
- Project-specific settings in `.claude/config.json`
- Removed deprecated GitHub MCP server from examples
- Added proactive agent usage instructions
- Configured trunk-based development workflow

### Security
- Pre-read security hook to detect sensitive data
- Dangerous command validation
- Sensitive file blocking (`.env`, `*.key`, etc.)

### Documentation
- Comprehensive README with installation methods
- CLAUDE.md with project guidelines and agent usage
- Agent documentation with clear trigger conditions
- Installation support for both bash and zsh shells