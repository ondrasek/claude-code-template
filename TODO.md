# Project TODOs

This file provides an overview of project TODOs. Individual TODOs are managed as separate markdown files in the `todos/` directory.

## Active TODOs

### High Priority
- **[document-parallel-agent-clusters.md](todos/document-parallel-agent-clusters.md)** - Document natural parallel agent clusters
- **[remove-artificial-sequential-dependencies.md](todos/remove-artificial-sequential-dependencies.md)** - Remove artificial sequential dependencies

### Medium Priority  
- **[create-workflow-templates-parallel-execution.md](todos/create-workflow-templates-parallel-execution.md)** - Create workflow templates for native parallel execution
- **[update-agent-usage-instructions.md](todos/update-agent-usage-instructions.md)** - Update agent usage instructions
- **[create-codebase-specific-agent-optimization.md](todos/create-codebase-specific-agent-optimization.md)** - Create codebase-specific agent optimization system

### Low Priority
- **[add-development-environment-enhancements.md](todos/add-development-environment-enhancements.md)** - Add development environment enhancements

## TODO Management

Use Claude Code built-in tools to manage TODOs:
- `/todo-list` - List all TODOs using Glob tool
- `/todo-show <filename>` - View TODO details using Read tool  
- `/todo-complete <filename>` - Mark TODO as completed using Edit tool

## Architecture Focus

This project focuses on optimizing for Claude Code's native parallelism capabilities rather than building custom coordination infrastructure.

## Success Metrics

- **Reduced Execution Time**: Parallel agent clusters should complete faster than sequential chains
- **Better Resource Utilization**: Agents should run concurrently without conflicts  
- **Clearer Workflows**: Users should understand which agents work well together
- **Fewer Dependencies**: Reduced artificial sequential bottlenecks