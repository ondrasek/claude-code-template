# Claude Code Forge CLI Tool Specification

## Overview

The Claude Code Forge CLI tool provides comprehensive Claude Code configuration management for repositories. It manages agents, commands, MCP servers, prompts, and related configurations through a secure, atomic, and user-friendly interface.

## Core Principles

- **Security First**: Sandboxed operations restricted to `.claude/`, `.support/`, and `CLAUDE.md`
- **Atomic Operations**: All changes either succeed completely or rollback entirely
- **Zero Installation**: Runnable via `uvx` without system dependencies
- **Backup Everything**: Timestamped backups before any destructive operation
- **Template-Driven**: Configuration sourced from GitHub releases

## Command Specifications

### 1. `init` - Initialize Configuration

**Purpose**: Set up Claude Code configuration in repository

**Parameters**:
- `--template VERSION` - Specific template version (default: latest)
- `--backup/--no-backup` - Create backup of existing config (default: true)
- `--merge-strategy {overwrite,merge,prompt}` - How to handle conflicts (default: prompt)
- `--components COMPONENTS` - Comma-separated list: agents,commands,prompts,mcp (default: all)

**Behavior**:
1. Validate repository is git-initialized
2. Create backup of existing `.claude/` and `.support/` if present
3. Download latest template from GitHub releases
4. Install selected components with chosen merge strategy
5. Update `.gitignore` with Claude-specific patterns
6. Create/update `CLAUDE.md` with installation metadata

### 2. `factory-reset` - Reset to Clean State

**Purpose**: Remove all Claude Code configuration

**Parameters**:
- `--keep-backups` - Preserve `.support/backups/` directory
- `--restore-original` - Restore pre-init state from backup
- `--force` - Skip confirmation prompts

**Behavior**:
1. Create backup of current configuration
2. Remove `.claude/` directory entirely
3. Remove `.support/` (except backups if --keep-backups)
4. Clean Claude-specific entries from `.gitignore`
5. Restore original `CLAUDE.md` if backup exists

### 3. `upgrade` - Update Configuration

**Purpose**: Upgrade to newer template version

**Parameters**:
- `--to VERSION` - Target version (default: latest)
- `--preview` - Show changes without applying
- `--merge-strategy {overwrite,merge,prompt}` - Conflict resolution
- `--rollback` - Rollback to previous version

**Behavior**:
1. Compare current version with target
2. Show upgrade preview if requested
3. Create backup with upgrade context
4. Download and merge new configuration
5. Validate configuration integrity
6. Update metadata in `CLAUDE.md`

### 4. `agent-ecosystem` - Repository-Specific Agent Generation

**Purpose**: Generate custom agents based on repository analysis

**Parameters**:
- `--analyze-depth {shallow,deep,comprehensive}` - Analysis scope
- `--technologies TECH_LIST` - Force specific technology detection
- `--dry-run` - Show proposed agents without creating
- `--interactive` - Step-by-step agent creation

**Behavior**:
1. Launch Claude Code with ecosystem analysis prompt
2. Scan repository structure and technologies
3. Generate repository-specific agents
4. Create corresponding commands where applicable
5. Update agent registry in `.claude/agents/`

### 5. `troubleshoot` - Diagnostic and Repair

**Purpose**: Diagnose and fix Claude Code configuration issues

**Parameters**:
- `--component {agents,commands,mcp,prompts,all}` - Focus area
- `--auto-fix` - Attempt automatic repairs
- `--verbose` - Detailed diagnostic output
- `--export-logs` - Save diagnostic data

**Behavior**:
1. Validate configuration file integrity
2. Check MCP server connectivity
3. Verify agent and command syntax
4. Test file permissions and paths
5. Generate diagnostic report
6. Offer repair suggestions or auto-fixes

### 6. `master-prompt` - Master Prompt Management

**Purpose**: Interactive master prompt creation and management

**Parameters**:
- `--template TEMPLATE` - Base template (coding, research, analysis)
- `--interactive` - Guided prompt creation
- `--validate` - Test prompt effectiveness
- `--backup` - Backup current prompt

**Behavior**:
1. Launch Claude Code with prompt engineering specialist
2. Guide user through prompt crafting process
3. Validate prompt against repository context
4. Test prompt with sample scenarios
5. Install prompt to `CLAUDE.md`
6. Create documentation and examples

## Additional Commands

### 7. `status` - Configuration Status

**Purpose**: Show current configuration state

**Behavior**:
- Display installed template version
- List active components and their status
- Show backup history
- Validate configuration integrity
- Report any issues or recommendations

### 8. `backup` - Manual Backup Creation

**Purpose**: Create manual configuration backup

**Parameters**:
- `--reason REASON` - Backup reason description
- `--compress` - Create compressed backup

### 9. `restore` - Restore from Backup

**Purpose**: Restore configuration from backup

**Parameters**:
- `--backup TIMESTAMP` - Specific backup to restore
- `--list` - Show available backups
- `--preview` - Show what would be restored

## Technical Architecture

### Core Components

**1. Configuration Manager**
- Template downloading and caching
- Atomic file operations with rollback
- Configuration validation and integrity checks

**2. Backup System**
- Timestamped backup creation (`YYYYMMDD-HHmmss-reason`)
- Incremental and full backup strategies
- Backup integrity verification
- Automatic cleanup of old backups

**3. Security Layer**
- Path traversal protection
- File permission validation
- Sandboxed operations
- Input sanitization

**4. User Interface**
- Rich CLI with progress indicators
- Interactive prompts with validation
- Comprehensive error messages
- Detailed logging

### Implementation Requirements

**Language**: Python 3.9+
**Dependencies**: Minimal, included in standard library where possible
**Distribution**: Single-file executable compatible with `uvx`
**Platform**: Cross-platform (Windows, macOS, Linux)

### Security Considerations

**Sandboxing**:
- Operations restricted to `.claude/`, `.support/`, `CLAUDE.md`
- No system-wide changes
- No execution of downloaded code

**Validation**:
- Cryptographic verification of downloads
- Schema validation of configuration files
- Path traversal attack prevention

**Audit Trail**:
- All operations logged with timestamps
- Backup metadata includes operation context
- Configuration change tracking

## User Workflows

### Initial Setup
```bash
uvx claude-code-forge init
# Interactive setup with component selection and merge strategy
```

### Regular Maintenance
```bash
uvx claude-code-forge status
uvx claude-code-forge upgrade --preview
uvx claude-code-forge upgrade
```

### Repository-Specific Customization
```bash
uvx claude-code-forge agent-ecosystem --interactive
uvx claude-code-forge master-prompt --template coding
```

### Problem Resolution
```bash
uvx claude-code-forge troubleshoot --auto-fix
uvx claude-code-forge restore --list
uvx claude-code-forge restore --backup 20250806-143244-pre-upgrade
```

## Success Metrics

**Reliability**:
- 99.9% success rate for atomic operations
- Zero data loss incidents
- Complete rollback capability

**Performance**:
- < 5s for configuration operations
- < 30s for full ecosystem analysis
- Minimal network bandwidth usage

**Security**:
- No privilege escalation vulnerabilities
- Sandboxed operations only
- Secure download verification

**User Experience**:
- Self-explanatory command interface
- Clear error messages with solutions
- Comprehensive help system

## Implementation Roadmap

**High Priority**:
- Core configuration management (init, factory-reset, upgrade)
- Backup system with atomic operations
- Template downloading from GitHub releases
- Basic security sandboxing

**Medium Priority**:
- Agent ecosystem generation
- Master prompt wizard
- Troubleshooting and diagnostics
- Rich CLI interface

**Low Priority**:
- Advanced backup strategies
- Performance optimizations
- Extended validation
- Plugin architecture foundation

## Migration Notes

After CLI implementation:
1. Remove `install.sh` from repository root
2. Update all documentation to reference CLI tool
3. Archive dotfiles/template functionality
4. Create migration guide for existing users
5. Implement GitHub workflow for release automation