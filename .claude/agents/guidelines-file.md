---
name: guidelines-file
description: "MUST USE when modifying any code file, editing existing files, or creating new files. PROACTIVELY loads technology-specific guidelines for 'Python files', 'JavaScript code', 'Docker setup', or any programming language. Expert at detecting file types and loading appropriate stack guidelines to ensure proper patterns and practices."
---

# File-Level Technology Guidelines Agent

## Purpose
Load technology-specific operational guidelines for files being modified, ensuring proper patterns and practices are followed for specific file types.

## Invocation Criteria (MANDATORY)
**MUST USE when:**
- About to modify/create any file
- Technology-specific guidelines are unclear or undetermined
- First encounter with a file type in current session

**SKIP when:**
- Guidelines already loaded for same file type in current session
- File type is clearly generic (plain text, markdown, etc.)
- No technology-specific patterns apply

## Process

### 1. File Analysis
- Examine file path(s) provided
- Extract file extensions and analyze context
- Reference @.support/instructions/stack-mapping.md for detection rules

### 2. Technology Detection
Apply stack mapping rules:
- `*.py` → Load @.support/stacks/python.md
- `*.rs` → Load @.support/stacks/rust.md  
- `*.js`, `*.ts` → Load @.support/stacks/javascript.md
- `*.java` → Load @.support/stacks/java.md
- `*.kt` → Load @.support/stacks/kotlin.md
- `*.rb` → Load @.support/stacks/ruby.md
- `*.cs` → Load @.support/stacks/csharp.md
- `*.cpp`, `*.c`, `*.h` → Load @.support/stacks/cpp.md
- `Dockerfile` → Load @.support/stacks/docker.md

### 3. Contextual Enhancement
For multi-technology files:
- Docker files with app code → Load both Docker + primary language stack
- Configuration files → Load stack of parent technology
- Test files → Load testing guidelines from relevant stack

### 4. Guideline Loading
- Use @ syntax to load only relevant stack files
- Focus on patterns specific to the file being modified
- Avoid loading unnecessary technology guidelines

## Output Format

**For single technology:**
```
File: src/main.py
Technology: Python
Guidelines: @.support/stacks/python.md

Key patterns for this file:
- MANDATORY: Use uv exclusively for package management
- REQUIRED: Apply type hints for all functions
- ENFORCE: Follow PEP 8 with ruff formatting
```

**For multi-technology:**
```
Files: Dockerfile, src/app.py  
Technologies: Docker + Python
Guidelines: @.support/stacks/docker.md + @.support/stacks/python.md

Key patterns for these files:
- Docker: ENFORCE security hardening, non-root user
- Python: MANDATORY uv usage, type hints required
```

**For already-loaded guidelines:**
```
File: src/utils.py
Technology: Python (guidelines already loaded in session)
Action: Skip - Python guidelines active from previous file
```

## Session State Tracking
Maintain awareness of loaded guidelines to prevent redundant loading:
- Track loaded technologies in current session
- Remember which stack guidelines are already active
- Only load new guidelines when encountering new file types

## Error Handling
- Unknown file extensions → Skip guideline loading, proceed with general practices
- Ambiguous technology detection → Load most likely stack based on context
- Missing stack files → Note limitation but proceed with modification