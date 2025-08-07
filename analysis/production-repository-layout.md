# Production Repository Layout for CCF Deployment

## Overview

This document defines the standardized repository layout for deploying Claude Code Forge (CCF) configuration to user projects. This specification combines comprehensive workflow documentation with AI-interpretable structured instructions for automated deployment systems.

## Core Separation Principle

CCF employs a fundamental separation between tool state and active configuration to prevent conflicts with Claude Desktop and existing user configurations:

```
PROJECT_ROOT/
├── .ccf/                    # CCF tool state and templates (managed by CCF)
└── .claude/                 # Active Claude configuration (user-controlled)
```

## Directory Structure Specification

### .ccf/ Directory Layout (CCF Tool Management)

```
.ccf/
├── config/                  # CCF tool configuration
│   ├── ccf.json            # CCF tool settings and state
│   ├── deployment.json     # Deployment configuration
│   └── overrides.json      # User-specific overrides
├── templates/              # CCF-managed templates for deployment
│   ├── agents/            # Agent definition templates
│   ├── commands/          # Command definition templates
│   ├── guidelines/        # Guideline templates
│   ├── prompts/           # Prompt templates
│   └── stacks/           # Stack-specific templates
├── backups/               # Configuration backups
│   ├── claude/           # Backed up .claude/ configs
│   └── ccf/              # CCF config history
├── state/                 # CCF tool state
│   ├── installed.json    # Tracking installed components
│   ├── versions.json     # Version tracking
│   ├── migrations.json   # Migration history
│   ├── checksums.json    # File integrity verification
│   └── conflicts.log     # Deployment conflict resolution history
└── cache/                 # CCF tool cache and working files
    ├── downloads/         # Downloaded template cache
    └── staging/          # Staging area for deployments
```

### .claude/ Directory Layout (User Configuration)

```
.claude/
├── agents/                # Active agent definitions
│   ├── foundation/       # Core foundational agents
│   └── specialists/      # Specialized task agents
├── commands/             # Active slash commands
│   ├── issue/           # Issue management commands
│   ├── commands/        # Command management commands
│   └── agents/          # Agent management commands
└── settings.json        # Claude configuration settings
```

### Project Root Integration

```
project-root/
├── .ccf/                  # CCF tool-specific directory (see above)
├── .claude/               # Active Claude configuration (see above) 
├── CLAUDE.md              # Project-specific instructions
└── [existing project files...]
```

## Configuration Hierarchy & Precedence

AI systems and CCF tools must apply configuration in this order (highest to lowest priority):

1. **Project Level**: `.claude/settings.json` and `CLAUDE.md`
2. **User Overrides**: `.ccf/config/overrides.json`
3. **CCF Deployment Config**: `.ccf/config/deployment.json`
4. **CCF Defaults**: `.ccf/config/ccf.json`
5. **Global Claude**: System-wide Claude configuration

## AI-Interpretable Deployment Algorithm

### Pre-deployment Validation
```
IF .claude/ exists AND has custom content:
  CREATE backup in .ccf/backups/TIMESTAMP/
  ANALYZE conflicts between existing and new content
  PROMPT user for conflict resolution strategy
```

### Template Processing
```
FOR each template in .ccf/templates/:
  IF target exists in .claude/:
    APPLY merge strategy based on file type
    LOG conflicts to .ccf/state/conflicts.log
  ELSE:
    DEPLOY template to .claude/
```

### Post-deployment Actions
```
UPDATE .ccf/state/versions.json
GENERATE .ccf/state/checksums.json
VALIDATE .claude/ configuration integrity
```

## Component Placement Strategy

### .ccf/ Directory (CCF Tool-Managed)

**Purpose**: Store CCF tool state, templates, and deployment configuration separate from active Claude configuration.

**Contents**:
- **config/**: CCF tool configuration files
- **templates/**: Template definitions for deployment to `.claude/`
- **backups/**: Automatic backups before modifications
- **state/**: Tool state tracking and migration history
- **cache/**: Working files and download cache

**Version Control**: `.ccf/state/` and `.ccf/cache/` should be gitignored; `.ccf/config/` and `.ccf/templates/` should be committed.

### .claude/ Directory (User-Managed)

**Purpose**: Active Claude Code configuration used by Claude Desktop and Claude CLI.

**Contents**: 
- **agents/**: Active agent definitions deployed from CCF templates
- **commands/**: Active command definitions deployed from CCF templates  
- **settings.json**: Claude Code runtime settings

**Management**: Populated and updated by CCF tool based on `.ccf/templates/` but remains user-editable.

## Conflict Resolution Strategies

### File-Type Specific Merging

| Template Type | Source Location | Target Location | Merge Strategy |
|---------------|----------------|-----------------|----------------|
| Agent Definitions | `.ccf/templates/agents/` | `.claude/agents/` | Type-based merge, preserve user modifications |
| Slash Commands | `.ccf/templates/commands/` | `.claude/commands/` | User version precedence, log CCF updates |
| Settings | `.ccf/templates/settings.json` | `.claude/settings.json` | Deep merge with user priority |
| Guidelines | `.ccf/templates/guidelines/` | Referenced in CLAUDE.md | Additive merge with conflict markers |

### Legacy Configuration Handling

```
IF .claude/ exists AND no .ccf/:
  CREATE .ccf/backups/migration-TIMESTAMP/
  COPY existing .claude/ to backup
  ANALYZE existing configuration
  APPLY CCF templates with preservation strategy
  LOG migration actions to .ccf/state/migrations.json
```

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

### Project Type Detection

```
IF package.json exists:
  SET project_type = "node"
  APPLY node-specific CCF templates
ELIF Cargo.toml exists:
  SET project_type = "rust"
  APPLY rust-specific CCF templates
ELIF pom.xml OR build.gradle exists:
  SET project_type = "java"
  APPLY java-specific CCF templates
...
```

## Configuration File Specifications

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

## Git Integration

### Recommended .gitignore Patterns

```gitignore
# CCF tool state (exclude from version control)
.ccf/state/
.ccf/backups/
.ccf/cache/

# Temporary files
.ccf/tmp/
.ccf/.cache/

# User-specific overrides (optional)
.ccf/config/overrides.json
```

### Version Control Strategy

**Include in version control**:
- `.ccf/config/ccf.json` - Base CCF configuration
- `.ccf/config/deployment.json` - Deployment settings
- `.ccf/templates/` - CCF template definitions
- `.claude/` - Active Claude configuration
- `CLAUDE.md` - Project instructions

**Exclude from version control**:
- `.ccf/state/` - Tool state and tracking
- `.ccf/backups/` - Configuration backups
- `.ccf/cache/` - Working files and downloads
- `.ccf/config/overrides.json` - User-specific overrides

## Tool State Management & Workflows

### Deployment Workflow

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

### Migration Strategy

#### From Existing .claude/ Configurations

1. **Analysis Phase**: Scan existing `.claude/` for customizations
2. **Backup Phase**: Create timestamped backup in `.ccf/backups/`
3. **Template Matching**: Identify which components match CCF templates
4. **Custom Component Identification**: Flag user-created components
5. **Merge Planning**: Create merge plan for user review
6. **Execution**: Apply merge plan with user confirmation

#### From Legacy CCF Versions

1. **Version Detection**: Identify current CCF version from `.ccf/state/`
2. **Migration Scripts**: Execute version-specific migration logic
3. **Template Updates**: Update templates to latest versions
4. **Configuration Migration**: Migrate configuration format changes
5. **Validation**: Verify migration completeness and functionality

## Security and Validation

### File Permissions
- `.ccf/`: 755 (CCF tool read/write)
- `.claude/`: 755 (user read/write)  
- `.ccf/config/` - Read/write by user only (600)
- `.ccf/backups/` - Read/write by user only (600)
- Sensitive files: 600 (owner only)

### Validation Rules
- No executable permissions on configuration files
- JSON schema validation for all configuration files
- Template syntax validation before deployment
- Circular dependency detection in agent configurations
- Permission validation for file operations
- Scan for potentially malicious content in templates
- Verify CCF signatures on template downloads

### Sensitive Data Management
- Never store API keys or secrets in `.ccf/config/`
- Use environment variables or external secret management
- Exclude sensitive files from git via `.gitignore`
- Provide clear documentation on secret management

### Error Handling

#### Critical Failures
```
IF backup creation fails:
  ABORT deployment
  REPORT error to user
  
IF .claude/ corruption detected:
  RESTORE from latest .ccf/backups/
  REPORT restoration to user
  
IF CCF template integrity fails:
  REFUSE deployment
  PROMPT for manual template verification
```

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

**Implementation Priority**: High - This specification blocks CCF tool implementation and user onboarding workflows.

**Dependencies**: 
- CCF tool implementation
- Template repository structure
- User migration tooling
- Documentation and user guides

**GitHub Issue**: #61

🤖 Generated with [Claude Code](https://claude.ai/code)