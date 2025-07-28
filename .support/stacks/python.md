# Python Development Reference

Essential Python development guidelines for Claude Code projects.

## Package Management (uv)
**Use uv exclusively** - no pip, poetry, conda, or other tools.

```bash
uv init                     # New project
uv add package             # Add dependency  
uv add --dev pytest        # Add dev dependency
uv run python script.py    # Run scripts
uv run pytest             # Run tests
```

## Project Structure
```
project/
├── src/project_name/      # Main package with __init__.py
├── tests/                 # test_*.py files
├── pyproject.toml         # uv-managed config
└── README.md
```

## Essential Libraries
**Web**: fastapi, flask, django
**CLI**: click, typer, rich  
**Data**: pandas, numpy, scikit-learn
**Testing**: pytest, pytest-cov
**Quality**: ruff, mypy, black

## Code Quality
```bash
uv add --dev ruff pytest mypy
uv run ruff check .        # Lint
uv run ruff format .       # Format
uv run mypy src/           # Type check
uv run pytest --cov       # Test with coverage
```

## Common Patterns
```python
# Type hints
def process(items: list[str], config: dict[str, Any] | None = None) -> bool:
    pass

# Dataclasses  
@dataclass
class User:
    name: str
    email: str | None = None

# Context managers
with database_connection() as conn:
    # Use connection

# Error handling
try:
    result = risky_operation()
except ValueError as e:
    logger.error(f"Invalid value: {e}")
    raise
```

## Environment & Config
```python
import os
from pathlib import Path
from dotenv import load_dotenv

load_dotenv()
DEBUG = os.getenv("DEBUG", "false").lower() == "true"
```

## Best Practices
- Follow PEP 8 with ruff formatting
- Use type hints for all public functions
- Write docstrings for public APIs  
- Handle errors explicitly, avoid bare except
- Use pathlib for file operations
- Prefer composition over inheritance
- Test with >80% coverage