Change of plans. This repo is not going to be used as a codespace template. We will develop a CLI tool that will "install" Claude configuration, scripts and anything else in .support into a repository.

It should have the following functionality:
1. init - initialize all custom configs provide with this repo, agents, commands, MCP, everything (with optional backup of existing configuration to .support/backups)
2. factory-reset - reset all this configuration to the default state (with backup of original config to .support/config-backups - stored in git and ignored by Claude (zipped?), is there something like .claudeignore?)
3. upgrade - upgrade to the latest available configuration (where to get it from?)
4. agent-ecosystem - run Claude Code with special prompt optimized for ecosystem analysis and run the ecosystem review command to build repository-specific agents and related commands.
5. troubleshoot - use launch-claude to launch log analysis with claude to troubleshoot claude and mcp issues
6. anything else that might be useful?
7. master-prompt - master-prompt management, run a wizard in Claude Code to help the user to craft master prompt using prompt engineering, web search and fetch, etc.

The CLI tool should also manage gitignore - add relevant parts to gitignore, it should work with init, factory reset, etc.

This tool should be implemented in Python. Have neat, clean code implementation and polished CLI interface. It must be runnable with UVX, available as a devcontainer feature and runnable in a devcontainer.

Backups in .support/backups should have dedicated sub-folders, one per backup. The name of the folder should be a timestamp (ISO?) with reason for backup. For example: 20250729-14h32m44-factory-reset.

After we implement this CLI, support for using this repo as dotfiles and template is gone. Update all documentation, etc. We should remove the install.sh script recognized by Codespaces from repo root.