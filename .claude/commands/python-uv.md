# Python Project Setup with uv

Please help me set up or manage a Python project using uv.

## Initial Setup

If this is a new project:
1. Run `uv init` to create the project structure
2. Set up the appropriate Python version
3. Configure pyproject.toml

## Dependency Management

For dependency operations:
- **Add dependencies**: Use `uv add package-name`
- **Add dev dependencies**: Use `uv add --dev package-name`
- **Remove dependencies**: Use `uv remove package-name`
- **Update dependencies**: Use `uv lock --upgrade-package package-name`
- **Sync environment**: Use `uv sync`

## Running Code

Always use `uv run`:
- `uv run python script.py`
- `uv run pytest`
- `uv run ruff check`
- `uv run ruff format`

## Best Practices

1. Never use pip directly - always use uv commands
2. Keep uv.lock file in version control
3. Use `uv sync` after pulling changes
4. Specify Python version in pyproject.toml
5. Use dev dependencies for testing and linting tools

## Common Tasks

- **New project**: `uv init && uv add --python 3.12`
- **Add testing**: `uv add --dev pytest pytest-cov`
- **Add linting**: `uv add --dev ruff`
- **Add type checking**: `uv add --dev mypy`
- **Add common data science**: `uv add pandas numpy matplotlib`
- **Add web framework**: `uv add fastapi uvicorn[standard]`
- **Add AI/ML**: `uv add langchain openai anthropic`