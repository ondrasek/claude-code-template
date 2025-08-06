---
status: pending
type: refactor
priority: high
assignee: specs-analyst
created: 2025-08-06
---

# Claude Code Forge Repository Restructuring Proposal

## Executive Summary

The claude-code-forge repository has evolved from a template/dotfiles collection into a CLI tool distribution platform. This evolution has created structural confusion with the current `.support/` directory mixing development files with user templates, causing poor user experience and maintainability issues.

This proposal outlines a comprehensive restructuring plan to separate development workspace (`/dev/`) from distributable templates (`/templates/`) while eliminating the confusing root-level `.support/` directory. This change will:

- **Improve user experience**: Clear separation between what users get vs development artifacts
- **Enhance maintainability**: Logical organization of development vs distribution files
- **Enable CLI distribution**: Clean structure optimized for CLI tool packaging
- **Reduce confusion**: Eliminate mixed-purpose directories

## Current State Analysis

### Repository Evolution Timeline
1. **Origin**: Template/dotfiles repository with `.support/` for development
2. **Current**: Mixed-purpose repository serving both development and CLI distribution
3. **Target**: Clean CLI tool distribution with separate development workspace

### Current Structure Problems

#### 1. Confusing Root-Level `.support/` Directory
```
/.support/
├── analysis/           # Development analysis - not for users
├── archive/           # Development history - not for users  
├── implementation/    # Development specs - not for users
├── instructions/      # Development guidelines - not for users
├── logs/             # Runtime logs - not for users
├── mcp-servers/      # User templates - should be distributed
├── prompts/          # User templates - should be distributed
└── specs/            # Development tasks - not for users
```

**Issues:**
- Mixes development files with user templates
- Users don't understand what `.support/` contains
- CLI distribution includes unnecessary development artifacts
- Maintenance burden from mixed concerns

#### 2. Poor Separation of Concerns
- **User templates** scattered in `.support/prompts/`, `.support/mcp-servers/`
- **Development files** mixed with distribution content
- **No clear boundary** between "what users get" vs "what developers need"

#### 3. CLI Distribution Challenges
- Current structure distributes 74+ development markdown files to users
- Logs and analysis files included in user installations
- No clear packaging boundary for CLI tool

### Current Directory Inventory

**User-Facing Templates (Should be distributed):**
- `.support/prompts/` (74 prompt templates)
- `.support/mcp-servers/` (MCP server configurations)
- `.claude/` (Agent and command definitions)
- `.devcontainer/` (Development environment)
- `docs/` (User documentation)

**Development-Only Files (Should not be distributed):**
- `.support/analysis/` (10 development analysis files)
- `.support/archive/` (Historical development files)
- `.support/implementation/` (Development specifications)
- `.support/instructions/` (Development guidelines)
- `.support/logs/` (Runtime diagnostics)
- `.support/specs/` (Development task management)

## Proposed Structure

### New Directory Layout

```
claude-code-forge/
├── README.md                    # Project overview
├── CHANGELOG.md                 # Release history
├── LICENSE                      # Legal
├── CLAUDE.md                    # Core operational rules
│
├── /dev/                        # DEVELOPMENT WORKSPACE
│   ├── analysis/               # Development analysis
│   ├── archive/                # Historical artifacts
│   ├── implementation/         # Development specs
│   ├── instructions/           # Development guidelines
│   ├── logs/                   # Runtime diagnostics
│   ├── specs/                  # Task management
│   └── README.md               # Development guide
│
├── /templates/                  # USER DISTRIBUTION
│   ├── .claude/               # Agent & command templates
│   │   ├── agents/
│   │   └── commands/
│   ├── .devcontainer/         # Dev environment template
│   ├── docs/                  # User documentation
│   ├── prompts/               # Prompt library
│   ├── mcp-servers/           # MCP configurations
│   └── README.md              # Template usage guide
│
├── .github/                    # Repository automation
└── .gitignore                 # Git configuration
```

### Rationale for New Structure

#### `/dev/` - Development Workspace
- **Purpose**: All development-only files and tooling
- **Audience**: Contributors and maintainers only
- **Distribution**: Excluded from CLI tool packages
- **Benefits**: Clear development environment, easy to exclude from distribution

#### `/templates/` - User Distribution
- **Purpose**: Clean templates and configurations for user projects
- **Audience**: CLI tool users and end developers
- **Distribution**: Primary content for CLI tool packages
- **Benefits**: Clear user focus, optimized for distribution

## Detailed Migration Plan

### Phase 1: Create New Structure
1. Create `/dev/` directory with subdirectories
2. Create `/templates/` directory with subdirectories
3. Update `.gitignore` to handle new structure

### Phase 2: Migrate Development Files
**Target: `/dev/`**
- `.support/analysis/` → `/dev/analysis/`
- `.support/archive/` → `/dev/archive/`
- `.support/implementation/` → `/dev/implementation/`
- `.support/instructions/` → `/dev/instructions/`
- `.support/logs/` → `/dev/logs/`
- `.support/specs/` → `/dev/specs/`

### Phase 3: Migrate User Templates
**Target: `/templates/`**
- `.claude/` → `/templates/.claude/`
- `.devcontainer/` → `/templates/.devcontainer/`
- `docs/` → `/templates/docs/`
- `.support/prompts/` → `/templates/prompts/`
- `.support/mcp-servers/` → `/templates/mcp-servers/`

### Phase 4: Update References
1. Update CLAUDE.md file structure rules
2. Update all agent and command file references
3. Update documentation paths
4. Update automation scripts and workflows

### Phase 5: Cleanup
1. Remove empty `.support/` directory
2. Verify all references updated
3. Test CLI distribution packaging

## File Movement Mapping

### Complete Migration Map

| Current Location | New Location | Type | Notes |
|------------------|--------------|------|-------|
| `.support/analysis/` | `/dev/analysis/` | Development | 10 analysis files |
| `.support/archive/` | `/dev/archive/` | Development | Historical artifacts |
| `.support/implementation/` | `/dev/implementation/` | Development | Specs and planning |
| `.support/instructions/` | `/dev/instructions/` | Development | Guidelines (6 files) |
| `.support/logs/` | `/dev/logs/` | Development | Runtime diagnostics |
| `.support/specs/` | `/dev/specs/` | Development | Task management |
| `.support/prompts/` | `/templates/prompts/` | Distribution | 74 prompt files |
| `.support/mcp-servers/` | `/templates/mcp-servers/` | Distribution | MCP configurations |
| `.claude/` | `/templates/.claude/` | Distribution | Agent definitions |
| `.devcontainer/` | `/templates/.devcontainer/` | Distribution | Dev environment |
| `docs/` | `/templates/docs/` | Distribution | User documentation |

### Files Requiring Path Updates

**CLAUDE.md:**
- File structure location rules
- Agent and command path references

**Agent Files (.claude/agents/):**
- Internal cross-references
- Specification file paths
- Instruction file references

**Command Files (.claude/commands/):**
- Specification creation paths
- Analysis file references

**Documentation:**
- Cross-reference links
- File location examples

**Automation Scripts:**
- GitHub workflows
- Development container scripts

## Impact Assessment

### What Breaks
1. **All hardcoded paths** in agent and command files
2. **CLAUDE.md file structure rules** need complete rewrite
3. **Documentation links** throughout repository
4. **Development workflows** expecting old paths
5. **CLI packaging scripts** (when created)

### What Continues Working
1. **Git history** preserved through file moves
2. **Core functionality** remains unchanged
3. **Agent behavior** unchanged after path updates
4. **User experience** improves with cleaner structure

### Update Requirements

**High Priority:**
- CLAUDE.md file structure rules
- All .claude/ agent and command files
- Development container scripts
- GitHub workflow references

**Medium Priority:**
- Documentation cross-references
- README file examples
- Analysis and specification files

**Low Priority:**
- Archive file references
- Historical documentation

## Risk Analysis

### High Risks

#### 1. Mass Path Update Errors
**Risk**: Updating 100+ files simultaneously introduces errors
**Mitigation**: 
- Automated search/replace with verification
- Comprehensive testing after each phase
- Git branch protection during migration

#### 2. Agent Functionality Disruption
**Risk**: Path updates break agent file references
**Mitigation**:
- Test agent functionality after path updates
- Phase migration to isolate issues
- Rollback plan for each phase

#### 3. Development Workflow Interruption
**Risk**: Contributors blocked during migration
**Mitigation**:
- Coordinate migration timing
- Clear communication plan
- Complete migration in single session

### Medium Risks

#### 4. Documentation Link Rot
**Risk**: Broken cross-references between files
**Mitigation**:
- Automated link checking
- Systematic verification process
- Update documentation in parallel

#### 5. CLI Tool Integration Complexity
**Risk**: New structure complicates CLI packaging
**Mitigation**:
- Design structure with CLI in mind
- Test packaging early in process
- Simple template directory distribution

### Low Risks

#### 6. User Confusion During Transition
**Risk**: Users confused by structure change
**Mitigation**:
- Clear migration announcement
- Updated documentation
- Gradual transition communication

## Implementation Phases

### Phase 1: Foundation (High Priority)
**Objective**: Create new structure and migrate development files

**Actions:**
1. Create `/dev/` and `/templates/` directories
2. Move `.support/analysis/` → `/dev/analysis/`
3. Move `.support/archive/` → `/dev/archive/`
4. Move `.support/implementation/` → `/dev/implementation/`
5. Move `.support/instructions/` → `/dev/instructions/`
6. Move `.support/logs/` → `/dev/logs/`
7. Move `.support/specs/` → `/dev/specs/`

**Validation**: Development files accessible in new locations

### Phase 2: Template Migration (High Priority)
**Objective**: Move user-facing templates to distribution directory

**Actions:**
1. Move `.support/prompts/` → `/templates/prompts/`
2. Move `.support/mcp-servers/` → `/templates/mcp-servers/`
3. Move `.claude/` → `/templates/.claude/`
4. Move `.devcontainer/` → `/templates/.devcontainer/`
5. Move `docs/` → `/templates/docs/`

**Validation**: All user templates in `/templates/` directory

### Phase 3: Reference Updates (Medium Priority)
**Objective**: Update all file references to new paths

**Actions:**
1. Update CLAUDE.md file structure rules
2. Update all agent file references
3. Update all command file references
4. Update documentation cross-references
5. Update automation scripts

**Validation**: All references point to correct new paths

### Phase 4: Cleanup (Low Priority)
**Objective**: Remove old structure and finalize migration

**Actions:**
1. Remove empty `.support/` directory
2. Update root README.md
3. Verify no broken references
4. Test complete workflow

**Validation**: Clean structure with no legacy artifacts

## Success Criteria

### Functional Requirements
1. **All agents function correctly** with new file paths
2. **All commands execute successfully** with updated references
3. **Development workflow uninterrupted** after migration
4. **Documentation links work** throughout repository

### Structural Requirements
1. **Clear separation** between development (`/dev/`) and distribution (`/templates/`)
2. **No remaining `.support/` directory** artifacts
3. **Logical organization** of all file types
4. **CLI-ready structure** for future packaging

### Quality Requirements
1. **No broken references** in any file
2. **Consistent path usage** throughout repository
3. **Updated documentation** reflects new structure
4. **Git history preserved** through file moves

### Performance Requirements
1. **Migration completes** in single development session
2. **No functionality regression** during or after migration
3. **Automated verification** confirms all updates successful

## CLI Tool Integration

### Distribution Optimization
**New structure enables:**
1. **Clean template packaging**: Only `/templates/` directory distributed
2. **Reduced package size**: Exclude 74+ development files
3. **Clear user experience**: No confusion about `.support/` contents
4. **Logical organization**: Users understand what they receive

### CLI Tool Benefits
1. **Simplified packaging**: `tar -czf templates.tar.gz templates/`
2. **Clear installation**: Extract templates to user project
3. **Maintainable distribution**: Separate development from user files
4. **Extensible structure**: Easy to add new template categories

### Future CLI Enhancement
- **Template selection**: Users choose specific template categories
- **Version management**: Track template versions separately from development
- **Update mechanism**: Update user templates without development artifacts
- **Customization support**: Clear structure for user modifications

## Implementation Readiness

This proposal provides:
- ✅ **Complete analysis** of current state and problems
- ✅ **Detailed migration plan** with specific steps
- ✅ **Comprehensive file mapping** for every directory and file
- ✅ **Risk assessment** with mitigation strategies  
- ✅ **Success criteria** for validation
- ✅ **CLI integration** planning

**Ready for implementation** with clear guidance for safe, systematic migration from mixed-purpose structure to clean CLI tool distribution model.