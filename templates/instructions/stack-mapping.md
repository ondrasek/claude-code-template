# Technology Stack Mapping Rules

Centralized technology detection logic for guidelines-file and guidelines-repo agents.

## File Extension to Stack Mapping

### Python Projects
**File indicators**: `*.py`, `pyproject.toml`, `requirements.txt`, `Pipfile`, `setup.py`
**Stack file**: `@.support/stacks/python.md`
**Key patterns**: Python files, uv/pip configuration

### Rust Projects  
**File indicators**: `*.rs`, `Cargo.toml`, `Cargo.lock`
**Stack file**: `@.support/stacks/rust.md`
**Key patterns**: Rust source files, Cargo configuration

### JavaScript/TypeScript Projects
**File indicators**: `*.js`, `*.ts`, `*.jsx`, `*.tsx`, `package.json`, `package-lock.json`, `yarn.lock`, `tsconfig.json`
**Stack file**: `@.support/stacks/javascript.md`
**Key patterns**: JS/TS files, npm/yarn configuration

### Java Projects
**File indicators**: `*.java`, `pom.xml`, `build.gradle`, `gradle.properties`, `settings.gradle`
**Stack file**: `@.support/stacks/java.md`
**Key patterns**: Java source files, Maven/Gradle configuration

### Kotlin Projects
**File indicators**: `*.kt`, `*.kts`, `build.gradle.kts`
**Stack file**: `@.support/stacks/kotlin.md`
**Key patterns**: Kotlin source files, Gradle Kotlin DSL

### Ruby Projects
**File indicators**: `*.rb`, `Gemfile`, `Gemfile.lock`, `Rakefile`, `config.ru`
**Stack file**: `@.support/stacks/ruby.md`
**Key patterns**: Ruby source files, Bundler configuration

### C# Projects
**File indicators**: `*.cs`, `*.csproj`, `*.sln`, `*.props`, `Directory.Build.props`
**Stack file**: `@.support/stacks/csharp.md`
**Key patterns**: C# source files, MSBuild configuration

### C++ Projects
**File indicators**: `*.cpp`, `*.cc`, `*.cxx`, `*.c`, `*.h`, `*.hpp`, `CMakeLists.txt`, `Makefile`
**Stack file**: `@.support/stacks/cpp.md`
**Key patterns**: C++ source files, CMake/Make configuration

### Docker Projects
**File indicators**: `Dockerfile`, `docker-compose.yml`, `docker-compose.yaml`, `.dockerignore`
**Stack file**: `@.support/stacks/docker.md`
**Key patterns**: Docker configuration files

### Go Projects
**File indicators**: `*.go`, `go.mod`, `go.sum`
**Stack file**: `@.support/stacks/go.md`
**Key patterns**: Go source files, Go modules configuration

## Detection Priority Rules

### Multi-Technology Repositories
When multiple technologies are detected:
1. **Primary language**: Most source files determines primary stack
2. **Supporting technologies**: Docker, CI/CD configurations apply additionally
3. **Framework detection**: Web frameworks, testing frameworks override general language rules

### File-Level Detection Logic
```
1. Check file extension against mapping table
2. If extension matches multiple technologies, use context:
   - .js with package.json → JavaScript stack
   - .js without package.json → Generic web stack
3. For configuration files, detect parent technology:
   - Dockerfile → Docker stack + primary language stack
   - package.json → JavaScript stack
4. Unknown extensions → Skip guideline loading
```

### Repository-Level Detection Logic
```
1. Scan all files in repository root and src/ directories
2. Count file types and identify primary technologies
3. Load all relevant stack guidelines for architectural decisions
4. Prioritize by file count: most frequent file type = primary stack
```

## Agent Integration

### guidelines-file Agent Usage
- **Input**: Specific file path(s) being modified
- **Process**: Map file extensions to appropriate stack files
- **Output**: Load only relevant stack guidelines for those file types
- **Optimization**: Skip if guidelines already loaded for same file type in session

### guidelines-repo Agent Usage  
- **Input**: Repository context or architectural question
- **Process**: Scan repository for all technologies present
- **Output**: Load all relevant stack guidelines for repository-wide decisions
- **Optimization**: Skip if repository guidelines already determined in session

## Stack Loading Syntax

Use @ syntax to reference stack files:
```
For Python files: @.support/stacks/python.md
For Docker files: @.support/stacks/docker.md  
For multi-tech repos: @.support/stacks/python.md + @.support/stacks/docker.md
```