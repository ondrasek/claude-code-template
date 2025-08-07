# Production Repository Layout for CCF Configuration Deployment

## Overview

This document defines the standardized repository layout for deploying Claude Code Forge (CCF) configuration to user projects. Based on analysis of the current CCF repository structure and user feedback, this layout separates CCF tool-specific state from Claude Code configuration to prevent conflicts with Claude Desktop and existing user configurations.

## Directory Structure

### Standard Layout for User Projects

When CCF tool is applied to a user project, the following directory structure should be created:

```
project-root/
├── .ccf/                           # CCF tool-specific directory
│   ├── config/                     # CCF tool configuration
│   │   ├── ccf.json               # CCF tool settings and state
│   │   ├── deployment.json        # Deployment configuration
│   │   └── overrides.json         # User-specific overrides
│   ├── templates/                  # CCF-managed templates
│   │   ├── agents/                # Agent definition templates
│   │   ├── commands/              # Command templates  
│   │   ├── guidelines/            # Guideline templates
│   │   ├── prompts/               # Prompt templates
│   │   └── stacks/                # Stack-specific templates
│   ├── backups/                   # Configuration backups
│   │   ├── claude/                # Backed up .claude/ configs
│   │   └── ccf/                   # CCF config history
│   └── state/                     # CCF tool state
│       ├── installed.json         # Tracking installed components
│       ├── versions.json          # Version tracking
│       └── migrations.json        # Migration history
├── .claude/                       # Claude Code configuration (user-managed)
│   ├── agents/                    # User's active agent definitions
│   │   ├── foundation/           
│   │   └── specialists/          
│   ├── commands/                  # User's active commands
│   └── settings.json             # Claude Code settings
├── CLAUDE.md                      # Project-specific instructions
└── [existing project files...]
```

## Configuration Hierarchy & Precedence

Configuration precedence follows this order (highest to lowest priority):

1. **Project-level**: `.claude/settings.json` and `CLAUDE.md`
2. **User-specific overrides**: `.ccf/config/overrides.json`
3. **CCF deployment config**: `.ccf/config/deployment.json`
4. **CCF defaults**: `.ccf/config/ccf.json`
5. **Global Claude Code**: User's global Claude configuration

## Component Placement Strategy

### .ccf/ Directory (CCF Tool-Managed)

**Purpose**: Store CCF tool state, templates, and deployment configuration separate from active Claude configuration.

**Contents**:
- **config/**: CCF tool configuration files
- **templates/**: Template definitions for deployment to `.claude/`
- **backups/**: Automatic backups before modifications
- **state/**: Tool state tracking and migration history

**Version Control**: `.ccf/state/` should be gitignored; `.ccf/config/` and `.ccf/templates/` should be committed.

### .claude/ Directory (User-Managed)

**Purpose**: Active Claude Code configuration used by Claude Desktop and Claude CLI.

**Contents**: 
- **agents/**: Active agent definitions deployed from CCF templates
- **commands/**: Active command definitions deployed from CCF templates  
- **settings.json**: Claude Code runtime settings

**Management**: Populated and updated by CCF tool based on `.ccf/templates/` but remains user-editable.

## Integration Patterns

### New Project Setup

1. **Initialize CCF**: Create `.ccf/` structure with default templates
2. **Deploy Base Configuration**: Populate `.claude/` from CCF templates
3. **Create Project Instructions**: Generate initial `CLAUDE.md`
4. **Version Control Setup**: Configure appropriate `.gitignore` patterns

### Existing Project Integration

1. **Backup Existing**: Move existing `.claude/` to `.ccf/backups/`
2. **Merge Configurations**: Intelligently merge existing with CCF templates
3. **Conflict Resolution**: Present conflicts to user for resolution
4. **Gradual Migration**: Allow incremental adoption of CCF components

## Conflict Resolution Strategy

### File Conflicts

**Existing .claude/ directory**:
1. Backup to `.ccf/backups/claude/[timestamp]/`
2. Analyze existing configuration for custom components
3. Merge CCF templates with existing customizations
4. Present conflicts for user resolution

**Existing CLAUDE.md**:
1. Backup original to `.ccf/backups/`
2. Merge CCF instructions with existing content
3. Preserve user-specific sections marked with comments

### Template Updates

**CCF Template Changes**:
1. Compare current `.claude/` with `.ccf/templates/`
2. Identify user modifications vs CCF template changes
3. Present 3-way merge interface for conflicts
4. Maintain change history in `.ccf/state/migrations.json`

## Tool State Management

### Installation Tracking

`.ccf/state/installed.json`:
```json
{
  "ccf_version": "1.0.0",
  "installed_at": "2025-08-07T13:45:00Z",
  "components": {
    "agents": ["researcher", "patterns", "critic"],
    "commands": ["review", "deploy", "test"],
    "templates": ["python", "javascript", "docker"]
  },
  "user_modifications": {
    "agents/custom-analyzer.md": "2025-08-07T14:00:00Z",
    "CLAUDE.md": "2025-08-07T13:50:00Z"
  }
}
```

### Version Management

`.ccf/state/versions.json`:
```json
{
  "ccf_version": "1.0.0",
  "template_versions": {
    "agents": "1.0.0",
    "commands": "1.0.0", 
    "guidelines": "1.0.0"
  },
  "last_update": "2025-08-07T13:45:00Z",
  "update_available": false
}
```

## Configuration Files

### CCF Tool Configuration

`.ccf/config/ccf.json`:
```json
{
  "version": "1.0.0",
  "auto_update": false,
  "backup_enabled": true,
  "backup_retention_days": 30,
  "template_sources": [
    "https://github.com/ondrasek/claude-code-forge/templates"
  ],
  "deployment": {
    "merge_strategy": "intelligent",
    "conflict_resolution": "prompt",
    "preserve_customizations": true
  }
}
```

### User Override Configuration

`.ccf/config/overrides.json`:
```json
{
  "disabled_components": [],
  "custom_templates": {
    "agents": ["./custom-agents/"],
    "commands": ["./custom-commands/"]
  },
  "claude_settings_override": {
    "model": "claude-sonnet-4-20250514",
    "permissions": {
      "defaultMode": "ask"
    }
  }
}
```

## Git Integration

### Recommended .gitignore Patterns

```gitignore
# CCF tool state (local only)
.ccf/state/
.ccf/backups/

# Temporary files
.ccf/tmp/
.ccf/.cache/

# User-specific overrides (optional)
.ccf/config/overrides.json
```

### Recommended Git Commits

**Include in version control**:
- `.ccf/config/ccf.json` - Base CCF configuration
- `.ccf/config/deployment.json` - Deployment settings
- `.ccf/templates/` - CCF template definitions
- `.claude/` - Active Claude configuration
- `CLAUDE.md` - Project instructions

**Exclude from version control**:
- `.ccf/state/` - Tool state and tracking
- `.ccf/backups/` - Configuration backups
- `.ccf/config/overrides.json` - User-specific overrides

## Migration Strategy

### From Existing .claude/ Configurations

1. **Analysis Phase**: Scan existing `.claude/` for customizations
2. **Backup Phase**: Create timestamped backup in `.ccf/backups/`
3. **Template Matching**: Identify which components match CCF templates
4. **Custom Component Identification**: Flag user-created components
5. **Merge Planning**: Create merge plan for user review
6. **Execution**: Apply merge plan with user confirmation

### From Legacy CCF Versions

1. **Version Detection**: Identify current CCF version from `.ccf/state/`
2. **Migration Scripts**: Execute version-specific migration logic
3. **Template Updates**: Update templates to latest versions
4. **Configuration Migration**: Migrate configuration format changes
5. **Validation**: Verify migration completeness and functionality

## Deployment Workflow

### CCF Tool Implementation

1. **Project Detection**: Identify project type and existing configurations
2. **Template Selection**: Choose appropriate templates based on project stack
3. **Conflict Analysis**: Identify potential conflicts before deployment
4. **User Confirmation**: Present deployment plan for approval
5. **Backup Creation**: Create comprehensive backups
6. **Template Deployment**: Deploy selected templates to `.claude/`
7. **Configuration Generation**: Create `CLAUDE.md` and tool configuration
8. **State Tracking**: Record deployment state and versions

### Update Workflow

1. **Update Detection**: Check for CCF template updates
2. **Impact Analysis**: Analyze changes impact on user configuration
3. **Merge Planning**: Plan intelligent merge of updates with user changes
4. **User Notification**: Present update summary and conflicts
5. **Selective Updates**: Allow user to choose which updates to apply
6. **Backup & Apply**: Backup and apply selected updates
7. **Verification**: Validate successful update application

## Security Considerations

### File Permissions

- `.ccf/config/` - Read/write by user only (600)
- `.ccf/templates/` - Read-only after deployment (444)
- `.ccf/backups/` - Read/write by user only (600)
- `.claude/` - Standard Claude Code permissions

### Sensitive Data

- Never store API keys or secrets in `.ccf/config/`
- Use environment variables or external secret management
- Exclude sensitive files from git via `.gitignore`
- Provide clear documentation on secret management

## Validation & Testing

### Configuration Validation

- JSON schema validation for all configuration files
- Template syntax validation before deployment
- Circular dependency detection in agent configurations
- Permission validation for file operations

### Integration Testing

- Test CCF deployment on empty projects
- Test integration with existing `.claude/` configurations
- Test update workflows with user modifications
- Test conflict resolution scenarios

## Future Considerations

### Extensibility

- Plugin system for custom CCF components
- Integration with external template repositories  
- API for programmatic CCF management
- Integration with CI/CD pipelines

### Multi-Repository Support

- Shared CCF configurations across multiple projects
- Organization-wide CCF template repositories
- Team-specific template customizations
- Cross-project configuration synchronization

---

**Priority**: High - This specification blocks CCF tool implementation and user onboarding workflows.

**Dependencies**: 
- CCF tool implementation
- Template repository structure
- User migration tooling
- Documentation and user guides

🤖 Generated with [Claude Code](https://claude.ai/code)