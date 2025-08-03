# Setup Scenarios Guide

## Overview

This guide provides specific setup instructions for different use cases and environments. Choose the scenario that best matches your situation.

## Scenario 1: First-Time User (Recommended)

**Situation**: You're new to Claude Code Template and want to get started quickly.

**Steps**:
1. Follow the [Manual Setup Guide](manual-setup-guide.md) completely
2. Start with the basic configuration and add customizations later
3. Test with simple commands like `/stacks` and `/review`

**What to expect**: Full feature set with all agents and commands available immediately.

## Scenario 2: Migrating from Automated Installation

**Situation**: You previously used automated installation scripts and need to migrate.

**Steps**:
1. Follow the [Migration Guide](migration-guide.md) step by step
2. Backup your current configuration before starting
3. Clean up old installation artifacts
4. Apply the new manual configuration

**What to expect**: Same functionality as before, but with cleaner, more maintainable setup.

## Scenario 3: Team Environment Setup

**Situation**: Setting up consistent configuration across a development team.

**Steps**:
1. **Team Lead**: Set up the configuration using [Manual Setup Guide](manual-setup-guide.md)
2. **Create team documentation**: Document your team's specific API key setup process
3. **Share configuration**: Either as a shared dotfiles repository or as team setup instructions
4. **Standardize environment variables**: Ensure all team members use the same variable names

**Team Setup Example**:
```bash
# 1. Clone team's dotfiles repository
git clone https://github.com/yourteam/dotfiles.git
cd dotfiles

# 2. Copy Claude configuration
cp -r .claude/ ~/.claude/

# 3. Set up team environment variables
echo 'export CLAUDE_API_KEY="your-individual-key"' >> ~/.bashrc
echo 'export TEAM_GITHUB_TOKEN="shared-token"' >> ~/.bashrc
source ~/.bashrc

# 4. Test team setup
claude /stacks
```

**What to expect**: Consistent development environment across all team members.

## Scenario 4: Project-Specific Configuration

**Situation**: You want different Claude Code configurations for different projects.

**Steps**:
1. Set up base configuration in `~/.claude/` using [Manual Setup Guide](manual-setup-guide.md)
2. Create project-specific customizations in each project's `.claude/` directory
3. Copy relevant support files to each project's `.support/` directory
4. Customize `CLAUDE.md` for each project's specific needs

**Project Structure Example**:
```
~/your-project/
├── .claude/           # Project-specific overrides
│   ├── commands/
│   └── agents/
├── .support/          # Project support files
│   ├── prompts/
│   └── instructions/
├── CLAUDE.md          # Project guidelines
└── [your project files]
```

**What to expect**: Base functionality from global config plus project-specific enhancements.

## Scenario 5: Minimal Installation

**Situation**: You only want specific features, not the full configuration.

**Steps**:
1. **Core only**: Copy just `settings.json` and `settings.local.json`
2. **Commands only**: Copy just the commands you want from `.claude/commands/`
3. **Agents only**: Copy just specific agents you need
4. **Custom selection**: Pick and choose from [Copying Instructions](copying-instructions.md)

**Minimal Setup Example**:
```bash
# Create minimal structure
mkdir -p ~/.claude/commands

# Copy only what you need
cp .claude/settings.json ~/.claude/
cp .claude/commands/review.md ~/.claude/commands/
cp .claude/commands/stacks.md ~/.claude/commands/

# Test minimal setup
claude /review
```

**What to expect**: Only the features you specifically installed.

## Scenario 6: Development and Testing

**Situation**: You're developing custom agents or commands and need a test environment.

**Steps**:
1. Set up full configuration using [Manual Setup Guide](manual-setup-guide.md)
2. Create a separate test directory for experimentation
3. Symlink configuration files for easy testing
4. Use version control for your custom configurations

**Development Setup Example**:
```bash
# Create development workspace
mkdir ~/claude-dev
cd ~/claude-dev

# Symlink configuration for easy testing
ln -s ~/.claude claude-config

# Create test configurations
mkdir test-agents test-commands

# Test custom configurations
cp test-agents/my-agent.md ~/.claude/agents/specialists/
claude  # Test your custom agent
```

**What to expect**: Full development environment for creating and testing custom configurations.

## Scenario 7: Multiple Claude Code Installations

**Situation**: You have multiple Claude Code installations (global, project-specific, etc.).

**Steps**:
1. Set up base configuration in `~/.claude/` for global access
2. Create environment-specific configurations in separate directories
3. Use shell aliases or wrapper scripts to switch between configurations
4. Document which configuration is used for which environment

**Multi-Environment Example**:
```bash
# Global configuration
~/.claude/

# Development environment configuration
~/dev-environments/claude-dev/.claude/

# Production environment configuration  
~/prod-environments/claude-prod/.claude/

# Shell aliases for switching
alias claude-dev='CLAUDE_CONFIG=~/dev-environments/claude-dev/.claude claude'
alias claude-prod='CLAUDE_CONFIG=~/prod-environments/claude-prod/.claude claude'
```

**What to expect**: Ability to use different configurations for different purposes.

## Scenario 8: Container/Docker Environment

**Situation**: Using Claude Code in containerized environments.

**Steps**:
1. Copy configuration to your container's user directory
2. Mount configuration as volumes if needed
3. Handle environment variables securely
4. Ensure proper file permissions in container

**Container Setup Example**:
```dockerfile
# In your Dockerfile
COPY .claude/ /home/user/.claude/
RUN chown -R user:user /home/user/.claude/
```

**Docker Compose Example**:
```yaml
services:
  development:
    volumes:
      - ./claude-config:/home/user/.claude
    environment:
      - CLAUDE_API_KEY=${CLAUDE_API_KEY}
```

**What to expect**: Claude Code Template working in containerized environments.

## Scenario 9: Backup and Recovery

**Situation**: You want to backup your configuration or recover from a corrupted setup.

**Steps**:
1. **Backup**: Regularly backup your `~/.claude/` directory
2. **Version control**: Consider putting your customizations under version control
3. **Recovery**: Use backups or re-apply configuration from the template
4. **Testing**: Verify configuration after recovery

**Backup Example**:
```bash
# Create backup
tar -czf claude-config-backup-$(date +%Y%m%d).tar.gz -C ~ .claude

# Restore backup
cd ~
tar -xzf claude-config-backup-20240803.tar.gz

# Verify restoration
claude /stacks
```

**What to expect**: Reliable backup and recovery process for your configuration.

## Common Issues Across Scenarios

### File Permissions
```bash
# Fix common permission issues
chmod -R 755 ~/.claude/
find ~/.claude -type f -exec chmod 644 {} \;
```

### Environment Variables
```bash
# Verify environment variables are set
echo $CLAUDE_API_KEY
echo $PERPLEXITY_API_KEY

# Add to shell configuration if missing
echo 'export CLAUDE_API_KEY="your-key"' >> ~/.bashrc
source ~/.bashrc
```

### Configuration Validation
```bash
# Test configuration is working
claude /stacks
claude /agents-guide

# Check file structure
ls -la ~/.claude/agents/foundation/
ls -la ~/.claude/commands/
```

## Getting Help

If you encounter issues with any scenario:

1. **Check the specific guide**: Each scenario links to relevant detailed guides
2. **Review troubleshooting sections**: Most guides include troubleshooting steps
3. **Start with minimal setup**: If full setup fails, try minimal installation first
4. **Check file permissions**: Many issues are related to file permissions
5. **Verify environment variables**: Ensure API keys are properly set

## Next Steps

After choosing and completing your scenario:

1. **Test thoroughly**: Verify all expected functionality works
2. **Customize as needed**: Modify agents and commands for your workflow
3. **Document your setup**: Record any project-specific or team-specific modifications
4. **Stay updated**: Periodically check for template updates

Your Claude Code Template is now configured for your specific use case!