#!/usr/bin/env python3
"""
Claude Code TODO Scanner
Automatically scan codebase for TODO, FIXME, HACK, XXX comments and convert to managed TODOs
"""

import re
import os
import argparse
from pathlib import Path
from typing import List, Dict, Tuple
import subprocess

# TODO patterns to search for
TODO_PATTERNS = [
    r'#\s*(TODO|FIXME|HACK|XXX)\s*:?\s*(.+)',      # Python, shell comments
    r'//\s*(TODO|FIXME|HACK|XXX)\s*:?\s*(.+)',     # C++, Java, JavaScript comments
    r'/\*\s*(TODO|FIXME|HACK|XXX)\s*:?\s*(.+?)\*/', # C-style block comments
    r'<!--\s*(TODO|FIXME|HACK|XXX)\s*:?\s*(.+?)\s*-->', # HTML comments
]

# File extensions to scan
SCAN_EXTENSIONS = {
    '.py', '.js', '.ts', '.jsx', '.tsx', '.java', '.cpp', '.c', '.h', '.hpp',
    '.cs', '.php', '.rb', '.go', '.rs', '.swift', '.kt', '.scala', '.sh',
    '.md', '.txt', '.yml', '.yaml', '.json', '.html', '.css', '.scss'
}

# Directories to skip
SKIP_DIRS = {
    '.git', '.svn', '.hg', '__pycache__', 'node_modules', '.venv', 'venv',
    'dist', 'build', 'target', '.next', '.nuxt', 'coverage', '.coverage',
    '.pytest_cache', '.mypy_cache', '.tox', 'vendor'
}

class TODOItem:
    def __init__(self, file_path: str, line_number: int, todo_type: str, content: str, line_text: str):
        self.file_path = file_path
        self.line_number = line_number
        self.todo_type = todo_type.upper()
        self.content = content.strip()
        self.line_text = line_text.strip()
        self.managed_type = self.classify_type()
        self.impact = self.classify_impact()
        self.priority = self.classify_priority()
    
    def classify_type(self) -> str:
        """Classify TODO into management system types based on content"""
        content_lower = self.content.lower()
        
        if any(word in content_lower for word in ['fix', 'bug', 'error', 'issue', 'broken']):
            return 'bug'
        elif any(word in content_lower for word in ['add', 'implement', 'create', 'new']):
            return 'feature'
        elif any(word in content_lower for word in ['improve', 'optimize', 'enhance', 'better']):
            return 'improvement'
        elif any(word in content_lower for word in ['refactor', 'cleanup', 'reorganize', 'restructure']):
            return 'refactor'
        elif any(word in content_lower for word in ['test', 'spec', 'coverage', 'verify']):
            return 'test'
        elif any(word in content_lower for word in ['security', 'auth', 'permission', 'validate']):
            return 'security'
        elif any(word in content_lower for word in ['performance', 'speed', 'optimize', 'cache']):
            return 'performance'
        elif any(word in content_lower for word in ['doc', 'comment', 'document', 'explain']):
            return 'docs'
        else:
            return 'improvement'  # Default
    
    def classify_impact(self) -> str:
        """Classify SemVer impact based on content and type"""
        content_lower = self.content.lower()
        
        # Major impact indicators
        if any(word in content_lower for word in [
            'breaking', 'remove', 'delete', 'deprecate', 'incompatible',
            'major refactor', 'architecture', 'api change'
        ]):
            return 'major'
        
        # Minor impact (new features)
        if self.managed_type == 'feature':
            return 'minor'
        
        # Default to patch
        return 'patch'
    
    def classify_priority(self) -> str:
        """Classify priority based on TODO type and content"""
        content_lower = self.content.lower()
        
        # Critical priority indicators
        if (self.todo_type in ['FIXME', 'HACK'] or 
            any(word in content_lower for word in ['critical', 'urgent', 'security', 'crash', 'data loss'])):
            return 'critical'
        
        # High priority indicators
        if (self.todo_type == 'TODO' and self.managed_type in ['bug', 'security'] or
            any(word in content_lower for word in ['important', 'soon', 'asap', 'blocking'])):
            return 'high'
        
        # Low priority indicators
        if any(word in content_lower for word in ['minor', 'nice to have', 'later', 'someday', 'eventually']):
            return 'low'
        
        # Default to medium
        return 'medium'
    
    def suggest_assignee(self) -> str:
        """Suggest which agent should handle this TODO"""
        if self.managed_type == 'bug':
            return 'researcher'
        elif self.managed_type == 'feature':
            return 'completer'
        elif self.managed_type in ['improvement', 'refactor']:
            return 'patterns'
        elif self.managed_type == 'security':
            return 'researcher'
        elif self.managed_type == 'performance':
            return 'patterns'
        elif self.managed_type == 'docs':
            return 'docs'
        elif self.managed_type == 'test':
            return 'completer'
        else:
            return 'completer'
    
    def to_dict(self) -> Dict:
        """Convert to dictionary for JSON serialization"""
        return {
            'file_path': self.file_path,
            'line_number': self.line_number,
            'todo_type': self.todo_type,
            'content': self.content,
            'line_text': self.line_text,
            'managed_type': self.managed_type,
            'impact': self.impact,
            'priority': self.priority,
            'suggested_assignee': self.suggest_assignee()
        }

class TODOScanner:
    def __init__(self, root_path: str = '.'):
        self.root_path = Path(root_path).resolve()
        self.todos: List[TODOItem] = []
    
    def scan_file(self, file_path: Path) -> List[TODOItem]:
        """Scan a single file for TODOs"""
        todos = []
        
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                for line_num, line in enumerate(f, 1):
                    for pattern in TODO_PATTERNS:
                        matches = re.finditer(pattern, line, re.IGNORECASE)
                        for match in matches:
                            todo_type = match.group(1)
                            content = match.group(2)
                            
                            todo_item = TODOItem(
                                file_path=str(file_path.relative_to(self.root_path)),
                                line_number=line_num,
                                todo_type=todo_type,
                                content=content,
                                line_text=line
                            )
                            todos.append(todo_item)
        except Exception as e:
            print(f"Warning: Could not scan {file_path}: {e}")
        
        return todos
    
    def scan_directory(self, directory: Path) -> None:
        """Recursively scan directory for TODOs"""
        for item in directory.iterdir():
            if item.is_dir():
                if item.name not in SKIP_DIRS:
                    self.scan_directory(item)
            elif item.is_file():
                if item.suffix in SCAN_EXTENSIONS:
                    file_todos = self.scan_file(item)
                    self.todos.extend(file_todos)
    
    def scan(self) -> List[TODOItem]:
        """Scan for all TODOs in the project"""
        self.todos = []
        self.scan_directory(self.root_path)
        return self.todos
    
    def group_by_file(self) -> Dict[str, List[TODOItem]]:
        """Group TODOs by file"""
        grouped = {}
        for todo in self.todos:
            if todo.file_path not in grouped:
                grouped[todo.file_path] = []
            grouped[todo.file_path].append(todo)
        return grouped
    
    def generate_managed_todos(self, output_file: str = 'found-todos.md') -> None:
        """Generate managed TODO entries from found TODOs"""
        if not self.todos:
            print("No TODOs found in codebase")
            return
        
        content = f"""# Found TODOs in Codebase

Generated by TODO scanner on {self.root_path}

## Summary
- Total TODOs found: {len(self.todos)}
- Files with TODOs: {len(self.group_by_file())}

## Conversion Commands

To add these TODOs to the managed system, run:

```bash
"""
        
        todo_id = 1
        for todo in self.todos:
            # Create safe title (truncate and clean)
            title = todo.content[:60].replace('"', "'").replace('\n', ' ').strip()
            if len(todo.content) > 60:
                title += "..."
            
            cmd = f'claude-todo add "{title}" --type {todo.managed_type} --impact {todo.impact} --priority {todo.priority} --assignee {todo.suggest_assignee()}'
            content += f"# TODO-{todo_id:03d}: {todo.file_path}:{todo.line_number}\n"
            content += f"{cmd}\n\n"
            todo_id += 1
        
        content += "```\n\n## Detailed Findings\n\n"
        
        # Group by file for detailed output
        grouped = self.group_by_file()
        for file_path, file_todos in grouped.items():
            content += f"### {file_path}\n\n"
            for todo in file_todos:
                content += f"**Line {todo.line_number}** - {todo.todo_type}: {todo.content}\n"
                content += f"- Type: `{todo.managed_type}` | Impact: `{todo.impact}` | Priority: `{todo.priority}` | Assignee: `{todo.suggest_assignee()}`\n"
                content += f"- Code: `{todo.line_text}`\n\n"
        
        # Write to file
        with open(output_file, 'w') as f:
            f.write(content)
        
        print(f"Generated {output_file} with {len(self.todos)} TODOs")
    
    def auto_convert(self, dry_run: bool = True) -> None:
        """Automatically convert found TODOs to managed TODOs"""
        if not self.todos:
            print("No TODOs found to convert")
            return
        
        script_dir = Path(__file__).parent
        claude_todo = script_dir / 'claude-todo'
        
        if not claude_todo.exists():
            print(f"Error: claude-todo script not found at {claude_todo}")
            return
        
        print(f"Found {len(self.todos)} TODOs to convert")
        
        todo_id = 1
        for todo in self.todos:
            # Create safe title
            title = todo.content[:60].replace('"', "'").replace('\n', ' ').strip()
            if len(todo.content) > 60:
                title += "..."
            
            # Build description with location info
            description = f"Found in {todo.file_path}:{todo.line_number}\\n{todo.content}"
            
            cmd = [
                str(claude_todo), 'add', title,
                '--type', todo.managed_type,
                '--impact', todo.impact,
                '--priority', todo.priority,
                '--assignee', todo.suggest_assignee(),
                '--description', description
            ]
            
            if dry_run:
                print(f"Would run: {' '.join(cmd)}")
            else:
                try:
                    result = subprocess.run(cmd, capture_output=True, text=True)
                    if result.returncode == 0:
                        print(f"✓ Converted TODO-{todo_id:03d}: {title}")
                    else:
                        print(f"✗ Failed to convert TODO-{todo_id:03d}: {result.stderr}")
                except Exception as e:
                    print(f"✗ Error converting TODO-{todo_id:03d}: {e}")
            
            todo_id += 1
        
        if dry_run:
            print("\nRun with --convert (no --dry-run) to actually create the TODOs")

def main():
    parser = argparse.ArgumentParser(description="Scan codebase for TODOs and convert to managed TODOs")
    parser.add_argument("path", nargs="?", default=".", help="Path to scan (default: current directory)")
    parser.add_argument("--output", "-o", default="found-todos.md", help="Output file for found TODOs")
    parser.add_argument("--convert", action="store_true", help="Auto-convert TODOs to managed system")
    parser.add_argument("--dry-run", action="store_true", default=True, help="Show what would be done (default)")
    parser.add_argument("--format", choices=["markdown", "json"], default="markdown", help="Output format")
    
    args = parser.parse_args()
    
    # If --convert is specified without --dry-run, disable dry run
    if args.convert and not any(arg == '--dry-run' for arg in os.sys.argv):
        args.dry_run = False
    
    scanner = TODOScanner(args.path)
    todos = scanner.scan()
    
    print(f"Scanned {args.path}")
    print(f"Found {len(todos)} TODOs in {len(scanner.group_by_file())} files")
    
    if not todos:
        print("No TODOs found!")
        return
    
    # Show summary
    by_type = {}
    by_priority = {}
    for todo in todos:
        by_type[todo.managed_type] = by_type.get(todo.managed_type, 0) + 1
        by_priority[todo.priority] = by_priority.get(todo.priority, 0) + 1
    
    print("\nBy Type:")
    for todo_type, count in sorted(by_type.items()):
        print(f"  {todo_type}: {count}")
    
    print("\nBy Priority:")
    for priority, count in sorted(by_priority.items()):
        print(f"  {priority}: {count}")
    
    if args.format == "json":
        import json
        output = {
            'summary': {
                'total': len(todos),
                'files': len(scanner.group_by_file()),
                'by_type': by_type,
                'by_priority': by_priority
            },
            'todos': [todo.to_dict() for todo in todos]
        }
        
        with open(args.output.replace('.md', '.json'), 'w') as f:
            json.dump(output, f, indent=2)
        print(f"\nJSON output written to {args.output.replace('.md', '.json')}")
    else:
        scanner.generate_managed_todos(args.output)
    
    if args.convert:
        print("\nConverting TODOs to managed system...")
        scanner.auto_convert(dry_run=args.dry_run)

if __name__ == "__main__":
    main()