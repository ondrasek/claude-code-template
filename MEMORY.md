# Memory Dump Overview

This file provides an overview of memories stored in the MCP memory server. Individual memories are stored as separate files in the `memories/` directory following the TODO protocol format.

## Memory Index

### Research Topics
- **[Agent Parallelism Alternatives](memories/agent-parallelism-alternatives.md)** - Research on parallel agent execution frameworks and patterns

### Tagging Decisions  
- **[Successful Tag v2.0.1](memories/successful-tag-v2-0-1.md)** - Documentation of successful autonomous tagging decision and criteria

### Task Analysis
- **[CLAUDE.md Analysis Task](memories/claude-md-analysis-task.md)** - Analysis of redundancy violations in CLAUDE.md file

## Memory Statistics
- **Total Entities**: 3
- **Total Relations**: 0
- **Entity Types**: research_topic, tagging_decision, task
- **Memory Dump Date**: 2025-07-28

## Memory Structure
Each memory follows the same format as TODOs:
- YAML frontmatter with entity metadata
- Structured content with context and observations
- Individual files for easy management and version control

## Usage Notes
- Memories persist across Claude Code sessions via MCP memory server
- Individual memory files can be edited, updated, or removed as needed
- Memory data is excluded from git by default (see .gitignore)
- Run `./scripts/setup-claude-memory.sh` to enable persistent memory storage