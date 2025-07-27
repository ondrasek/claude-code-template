# Python Development Guidelines

This file contains Python-specific development guidelines for Claude Code.

## Python Development with uv

### Project Management
- **Always use uv** for Python projects - no pip, poetry, conda, or other tools
- **Project initialization**: `uv init` for new projects
- **Dependencies**: `uv add package` and `uv remove package`
- **Virtual environments**: Managed automatically by uv
- **Running scripts**: `uv run python script.py`
- **Installing tools**: `uv tool install package`

### Common uv Commands
```bash
uv init                    # Initialize new project
uv add pandas numpy       # Add dependencies
uv add --dev pytest ruff  # Add dev dependencies
uv sync                   # Sync dependencies
uv run python main.py     # Run Python scripts
uv run pytest            # Run tests
uv tool install ruff     # Install tools globally
```

### Python Project Structure
```
project/
├── src/
│   └── project_name/
│       ├── __init__.py
│       └── main.py
├── tests/
│   └── test_main.py
├── pyproject.toml       # uv manages this
├── README.md
└── .python-version      # Optional, for uv
```

### Testing with Python
- **Test framework**: Use pytest (install with `uv add --dev pytest`)
- **Test location**: Tests go in `tests/` directory
- **Test naming**: Use `test_*.py` or `*_test.py`
- **Run tests**: `uv run pytest`
- **Coverage**: `uv add --dev pytest-cov` then `uv run pytest --cov`

### Code Quality Tools
```bash
# Install development tools
uv add --dev ruff pytest mypy black isort

# Run linting
uv run ruff check .
uv run ruff format .

# Type checking
uv run mypy src/

# Format code
uv run black .
uv run isort .
```

### Common Python Patterns

#### 1. **Type Hints**
Always use type hints for better code clarity:
```python
from typing import List, Optional, Dict

def process_data(items: List[str], config: Optional[Dict[str, any]] = None) -> bool:
    """Process data with optional configuration."""
    pass
```

#### 2. **Dataclasses for Data Structures**
```python
from dataclasses import dataclass
from typing import Optional

@dataclass
class User:
    id: int
    name: str
    email: Optional[str] = None
```

#### 3. **Context Managers**
Use context managers for resource management:
```python
from contextlib import contextmanager

@contextmanager
def database_connection():
    conn = create_connection()
    try:
        yield conn
    finally:
        conn.close()
```

#### 4. **Error Handling**
Be specific with exception handling:
```python
try:
    result = risky_operation()
except ValueError as e:
    logger.error(f"Invalid value: {e}")
    raise
except Exception as e:
    logger.exception("Unexpected error")
    raise
```

### Python-Specific Commands
- `/python-uv` - Set up a new Python project with uv
- `/python-test` - Create test structure and examples
- `/python-api` - Create FastAPI or Flask application
- `/python-cli` - Create CLI application with Click or Typer

### Common Python Libraries

#### Web Frameworks
- **FastAPI**: Modern, fast web framework - `uv add fastapi`
- **Flask**: Lightweight web framework - `uv add flask`
- **Django**: Full-featured web framework - `uv add django`

#### Data Science
- **pandas**: Data manipulation - `uv add pandas`
- **numpy**: Numerical computing - `uv add numpy`
- **scikit-learn**: Machine learning - `uv add scikit-learn`

#### CLI Tools
- **click**: Command line interfaces - `uv add click`
- **typer**: Modern CLI library - `uv add typer`
- **rich**: Beautiful terminal output - `uv add rich`

### Environment Variables
```python
import os
from pathlib import Path
from dotenv import load_dotenv

# Load .env file
load_dotenv()

# Get environment variables with defaults
DEBUG = os.getenv("DEBUG", "false").lower() == "true"
DATABASE_URL = os.getenv("DATABASE_URL", "sqlite:///./app.db")
```

### Debugging Python Code
1. **Use the built-in debugger**:
   ```python
   import pdb; pdb.set_trace()  # Add breakpoint
   ```

2. **Use logging instead of print**:
   ```python
   import logging
   
   logging.basicConfig(level=logging.INFO)
   logger = logging.getLogger(__name__)
   
   logger.info("Processing started")
   logger.debug(f"Data: {data}")
   ```

3. **Use IPython for interactive debugging**:
   ```bash
   uv add --dev ipython
   uv run ipython
   ```

### Python Best Practices
1. **Follow PEP 8** - Use `ruff` for automatic formatting
2. **Write docstrings** - Document all public functions and classes
3. **Use virtual environments** - uv handles this automatically
4. **Pin dependencies** - uv creates lock files automatically
5. **Write tests** - Aim for >80% code coverage
6. **Use type hints** - Enable better IDE support and catch bugs early
7. **Handle errors gracefully** - Don't let exceptions bubble up unexpectedly
8. **Keep functions small** - Each function should do one thing well
9. **Use meaningful variable names** - Code should be self-documenting
10. **Avoid global state** - Pass dependencies explicitly

### Integration with AI Agents
When working with Python projects, use these specialized agents:
- **researcher**: For finding Python libraries and best practices
- **patterns**: For identifying Pythonic patterns in code
- **principles**: For Python's "Zen of Python" principles
- **docsync**: For updating Python documentation and docstrings