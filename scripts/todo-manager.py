#!/usr/bin/env python3
"""
Claude Code TODO and CHANGELOG Management System
Automated TODO tracking and CHANGELOG generation with SemVer support
"""

import re
import yaml
import json
import argparse
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional
from dataclasses import dataclass, asdict, field
from enum import Enum

class TODOType(Enum):
    FEATURE = "feature"
    BUG = "bug"
    IMPROVEMENT = "improvement"
    REFACTOR = "refactor"
    DOCS = "docs"
    TEST = "test"
    SECURITY = "security"
    PERFORMANCE = "performance"

class Impact(Enum):
    MAJOR = "major"
    MINOR = "minor"
    PATCH = "patch"

class Status(Enum):
    PENDING = "pending"
    IN_PROGRESS = "in_progress"
    COMPLETED = "completed"
    BLOCKED = "blocked"
    CANCELLED = "cancelled"

class Priority(Enum):
    CRITICAL = "critical"
    HIGH = "high"
    MEDIUM = "medium"
    LOW = "low"

@dataclass
class TODO:
    id: str
    title: str
    type: TODOType
    impact: Impact
    status: Status = Status.PENDING
    priority: Priority = Priority.MEDIUM
    created: str = ""
    updated: str = ""
    assignee: str = ""
    estimate: str = ""
    dependencies: List[str] = field(default_factory=list)
    labels: List[str] = field(default_factory=list)
    files: List[str] = field(default_factory=list)
    description: str = ""
    acceptance_criteria: List[str] = field(default_factory=list)
    implementation_notes: str = ""
    breaking_changes: str = ""
    
    def __post_init__(self):
        if not self.created:
            self.created = datetime.now().strftime("%Y-%m-%d")
        if not self.updated:
            self.updated = self.created

class TODOManager:
    def __init__(self, todo_file: str = "TODO.md", changelog_file: str = "CHANGELOG.md"):
        self.todo_file = Path(todo_file)
        self.changelog_file = Path(changelog_file)
        self.todos: Dict[str, TODO] = {}
        self.load_todos()
    
    def load_todos(self):
        """Load TODOs from TODO.md file"""
        if not self.todo_file.exists():
            return
        
        content = self.todo_file.read_text()
        
        # Extract TODO entries using regex
        pattern = r'---\n(.*?)\n---\n\n## Description\n(.*?)(?=\n---|\nX<!-- End TODO|\Z)'
        matches = re.findall(pattern, content, re.DOTALL)
        
        for yaml_content, description_content in matches:
            try:
                data = yaml.safe_load(yaml_content)
                if data and 'id' in data:
                    # Parse description content
                    desc_parts = description_content.split('\n### ')
                    description = desc_parts[0].strip()
                    
                    acceptance_criteria = []
                    implementation_notes = ""
                    breaking_changes = ""
                    
                    for part in desc_parts[1:]:
                        if part.startswith('Acceptance Criteria'):
                            criteria_text = part.split('Acceptance Criteria\n', 1)[1]
                            acceptance_criteria = [
                                line.strip('- [ ] ').strip()
                                for line in criteria_text.split('\n')
                                if line.strip().startswith('- [ ]')
                            ]
                        elif part.startswith('Implementation Notes'):
                            implementation_notes = part.split('Implementation Notes\n', 1)[1].strip()
                        elif part.startswith('Breaking Changes'):
                            breaking_changes = part.split('Breaking Changes\n', 1)[1].strip()
                    
                    todo = TODO(
                        id=data['id'],
                        title=data['title'],
                        type=TODOType(data['type']),
                        impact=Impact(data['impact']),
                        status=Status(data.get('status', 'pending')),
                        priority=Priority(data.get('priority', 'medium')),
                        created=data.get('created', ''),
                        updated=data.get('updated', ''),
                        assignee=data.get('assignee', ''),
                        estimate=data.get('estimate', ''),
                        dependencies=data.get('dependencies', []),
                        labels=data.get('labels', []),
                        files=data.get('files', []),
                        description=description,
                        acceptance_criteria=acceptance_criteria,
                        implementation_notes=implementation_notes,
                        breaking_changes=breaking_changes
                    )
                    self.todos[todo.id] = todo
            except Exception as e:
                print(f"Error parsing TODO: {e}")
                continue
    
    def save_todos(self):
        """Save TODOs to TODO.md file"""
        # Generate statistics
        stats = self.get_statistics()
        
        content = f"""# Project TODOs

## Statistics
- Total TODOs: {stats['total']}
- Pending: {stats['pending']}
- In Progress: {stats['in_progress']}
- Completed (this version): {stats['completed']}
- Blocked: {stats['blocked']}
- Cancelled: {stats['cancelled']}

## Quick Actions
- [Add New TODO](#add-new-todo)
- [Start Work](#start-work)
- [Complete TODO](#complete-todo)

## TODOs by Status

"""
        
        # Group TODOs by status
        status_groups = {
            Status.IN_PROGRESS: "🚀 In Progress",
            Status.PENDING: "⏳ Pending", 
            Status.BLOCKED: "⛔ Blocked",
            Status.COMPLETED: "✅ Completed (Current Version)",
            Status.CANCELLED: "❌ Cancelled"
        }
        
        for status, header in status_groups.items():
            todos_in_status = [t for t in self.todos.values() if t.status == status]
            if todos_in_status:
                content += f"### {header}\n"
                for todo in sorted(todos_in_status, key=lambda x: x.updated, reverse=True):
                    status_indicator = "⚠️" if todo.priority == Priority.CRITICAL else ""
                    content += f"[{todo.id}]: {todo.title} ({todo.assignee or 'unassigned'}, {todo.priority.value} priority) {status_indicator}\n"
                content += "\n"
        
        content += "---\n\n<!-- Detailed TODO entries follow -->\n\n"
        
        # Add detailed TODO entries
        for todo in self.todos.values():
            content += self.format_todo_entry(todo)
            content += "\n"
        
        self.todo_file.write_text(content)
    
    def format_todo_entry(self, todo: TODO) -> str:
        """Format a TODO entry for file output"""
        yaml_data = {
            'id': todo.id,
            'title': todo.title,
            'type': todo.type.value,
            'impact': todo.impact.value,
            'status': todo.status.value,
            'priority': todo.priority.value,
            'created': todo.created,
            'updated': todo.updated,
            'assignee': todo.assignee,
            'estimate': todo.estimate,
            'dependencies': todo.dependencies,
            'labels': todo.labels,
            'files': todo.files
        }
        
        # Remove empty fields
        yaml_data = {k: v for k, v in yaml_data.items() if v}
        
        yaml_content = yaml.dump(yaml_data, default_flow_style=False, sort_keys=False)
        
        entry = f"---\n{yaml_content}---\n\n## Description\n{todo.description}\n"
        
        if todo.acceptance_criteria:
            entry += "\n### Acceptance Criteria\n"
            for criterion in todo.acceptance_criteria:
                entry += f"- [ ] {criterion}\n"
        
        if todo.implementation_notes:
            entry += f"\n### Implementation Notes\n{todo.implementation_notes}\n"
        
        if todo.breaking_changes:
            entry += f"\n### Breaking Changes\n{todo.breaking_changes}\n"
        
        return entry
    
    def add_todo(self, todo: TODO) -> str:
        """Add a new TODO"""
        if todo.id in self.todos:
            raise ValueError(f"TODO with ID {todo.id} already exists")
        
        self.todos[todo.id] = todo
        self.save_todos()
        return f"Added TODO {todo.id}: {todo.title}"
    
    def update_todo_status(self, todo_id: str, new_status: Status, reason: str = "") -> str:
        """Update TODO status"""
        if todo_id not in self.todos:
            raise ValueError(f"TODO {todo_id} not found")
        
        todo = self.todos[todo_id]
        old_status = todo.status
        todo.status = new_status
        todo.updated = datetime.now().strftime("%Y-%m-%d")
        
        if new_status == Status.BLOCKED and reason:
            todo.implementation_notes += f"\nBlocked: {reason} (as of {todo.updated})"
        
        self.save_todos()
        return f"Updated TODO {todo_id} from {old_status.value} to {new_status.value}"
    
    def get_statistics(self) -> Dict[str, int]:
        """Get TODO statistics"""
        stats = {status.value: 0 for status in Status}
        stats['total'] = len(self.todos)
        
        for todo in self.todos.values():
            stats[todo.status.value] += 1
        
        return stats
    
    def list_todos(self, status: Optional[Status] = None, assignee: Optional[str] = None) -> List[TODO]:
        """List TODOs with optional filtering"""
        todos = list(self.todos.values())
        
        if status:
            todos = [t for t in todos if t.status == status]
        
        if assignee:
            todos = [t for t in todos if t.assignee == assignee]
        
        return sorted(todos, key=lambda x: (x.priority.value, x.updated), reverse=True)
    
    def calculate_version_bump(self, current_version: str, completed_todos: List[TODO]) -> str:
        """Calculate next version based on completed TODOs"""
        major, minor, patch = map(int, current_version.lstrip('v').split('.'))
        
        # Check for major version bump
        has_major = any(
            todo.impact == Impact.MAJOR or self.has_breaking_changes(todo)
            for todo in completed_todos
        )
        
        if has_major:
            return f"{major + 1}.0.0"
        
        # Check for minor version bump
        has_minor = any(
            todo.type == TODOType.FEATURE and todo.impact == Impact.MINOR
            for todo in completed_todos
        )
        
        if has_minor:
            return f"{major}.{minor + 1}.0"
        
        # Default to patch version bump
        return f"{major}.{minor}.{patch + 1}"
    
    def has_breaking_changes(self, todo: TODO) -> bool:
        """Check if TODO introduces breaking changes"""
        breaking_indicators = [
            'remove', 'delete', 'drop support', 'change behavior',
            'incompatible', 'breaking change', 'migration required'
        ]
        
        content = f"{todo.title} {todo.description} {todo.breaking_changes}".lower()
        return any(indicator in content for indicator in breaking_indicators)
    
    def generate_changelog_entry(self, version: str, completed_todos: List[TODO]) -> str:
        """Generate CHANGELOG entry from completed TODOs"""
        today = datetime.now().strftime("%Y-%m-%d")
        entry = f"\n## [{version}] - {today}\n\n"
        
        # Group by changelog sections
        sections = {
            'Added': [t for t in completed_todos if t.type == TODOType.FEATURE],
            'Changed': [t for t in completed_todos if t.type in [TODOType.IMPROVEMENT, TODOType.REFACTOR]],
            'Fixed': [t for t in completed_todos if t.type == TODOType.BUG],
            'Security': [t for t in completed_todos if t.type == TODOType.SECURITY],
            'Performance': [t for t in completed_todos if t.type == TODOType.PERFORMANCE],
            'Documentation': [t for t in completed_todos if t.type == TODOType.DOCS],
            'Removed': [t for t in completed_todos if self.has_breaking_changes(t)]
        }
        
        for section_name, todos in sections.items():
            if todos:
                entry += f"### {section_name}\n"
                for todo in todos:
                    entry += f"- {todo.title}\n"
                    if todo.breaking_changes and section_name == 'Removed':
                        entry += f"  - ⚠️ BREAKING: {todo.breaking_changes}\n"
                    entry += f"  - Implements {todo.id}: {todo.description[:100]}{'...' if len(todo.description) > 100 else ''}\n"
                entry += "\n"
        
        return entry
    
    def update_changelog(self, completed_todos: List[TODO]) -> str:
        """Update CHANGELOG.md with completed TODOs"""
        current_version = self.extract_current_version()
        new_version = self.calculate_version_bump(current_version, completed_todos)
        
        if self.changelog_file.exists():
            content = self.changelog_file.read_text()
        else:
            content = self.create_initial_changelog()
        
        new_entry = self.generate_changelog_entry(new_version, completed_todos)
        
        # Insert after [Unreleased] section
        unreleased_pattern = r'(## \[Unreleased\].*?)(\n## \[|\Z)'
        match = re.search(unreleased_pattern, content, re.DOTALL)
        
        if match:
            updated_content = content[:match.end(1)] + new_entry + content[match.start(2):]
        else:
            # Add at the beginning if no unreleased section
            header_pattern = r'(# Changelog.*?(?=\n## \[|\Z))'
            match = re.search(header_pattern, content, re.DOTALL)
            if match:
                updated_content = content[:match.end(1)] + new_entry + content[match.end(1):]
            else:
                updated_content = content + new_entry
        
        self.changelog_file.write_text(updated_content)
        return new_version
    
    def extract_current_version(self) -> str:
        """Extract current version from CHANGELOG.md"""
        if not self.changelog_file.exists():
            return "0.0.0"
        
        content = self.changelog_file.read_text()
        pattern = r'## \[(\d+\.\d+\.\d+)\]'
        matches = re.findall(pattern, content)
        
        if matches:
            return matches[0]  # First match is the latest version
        
        return "0.0.0"
    
    def create_initial_changelog(self) -> str:
        """Create initial CHANGELOG.md structure"""
        return """# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

"""

def main():
    parser = argparse.ArgumentParser(description="Claude Code TODO Manager")
    parser.add_argument("--todo-file", default="TODO.md", help="Path to TODO.md file")
    parser.add_argument("--changelog-file", default="CHANGELOG.md", help="Path to CHANGELOG.md file")
    
    subparsers = parser.add_subparsers(dest="command", help="Available commands")
    
    # Add TODO command
    add_parser = subparsers.add_parser("add", help="Add new TODO")
    add_parser.add_argument("title", help="TODO title")
    add_parser.add_argument("--type", choices=[t.value for t in TODOType], required=True)
    add_parser.add_argument("--impact", choices=[i.value for i in Impact], required=True)
    add_parser.add_argument("--priority", choices=[p.value for p in Priority], default="medium")
    add_parser.add_argument("--assignee", help="Assigned agent or person")
    add_parser.add_argument("--description", help="Detailed description")
    
    # List TODOs command
    list_parser = subparsers.add_parser("list", help="List TODOs")
    list_parser.add_argument("--status", choices=[s.value for s in Status])
    list_parser.add_argument("--assignee", help="Filter by assignee")
    list_parser.add_argument("--format", choices=["table", "json"], default="table")
    
    # Update status command
    update_parser = subparsers.add_parser("update", help="Update TODO status")
    update_parser.add_argument("todo_id", help="TODO ID")
    update_parser.add_argument("--status", choices=[s.value for s in Status], required=True)
    update_parser.add_argument("--reason", help="Reason for status change")
    
    # Release command
    release_parser = subparsers.add_parser("release", help="Generate release from completed TODOs")
    release_parser.add_argument("--dry-run", action="store_true", help="Show what would be done")
    
    args = parser.parse_args()
    
    if not args.command:
        parser.print_help()
        return
    
    manager = TODOManager(args.todo_file, args.changelog_file)
    
    if args.command == "add":
        # Generate unique ID
        todo_id = f"TODO-{len(manager.todos) + 1:03d}"
        
        todo = TODO(
            id=todo_id,
            title=args.title,
            type=TODOType(args.type),
            impact=Impact(args.impact),
            priority=Priority(args.priority),
            assignee=args.assignee or "",
            description=args.description or ""
        )
        
        result = manager.add_todo(todo)
        print(result)
    
    elif args.command == "list":
        status_filter = Status(args.status) if args.status else None
        todos = manager.list_todos(status_filter, args.assignee)
        
        if args.format == "json":
            print(json.dumps([asdict(todo) for todo in todos], indent=2))
        else:
            print(f"{'ID':<12} {'Title':<40} {'Status':<12} {'Priority':<10} {'Assignee':<15}")
            print("-" * 90)
            for todo in todos:
                print(f"{todo.id:<12} {todo.title[:40]:<40} {todo.status.value:<12} {todo.priority.value:<10} {todo.assignee:<15}")
    
    elif args.command == "update":
        result = manager.update_todo_status(
            args.todo_id,
            Status(args.status),
            args.reason or ""
        )
        print(result)
    
    elif args.command == "release":
        completed_todos = manager.list_todos(Status.COMPLETED)
        
        if not completed_todos:
            print("No completed TODOs found for release")
            return
        
        if args.dry_run:
            current_version = manager.extract_current_version()
            new_version = manager.calculate_version_bump(current_version, completed_todos)
            print(f"Would create release {new_version} with {len(completed_todos)} completed TODOs:")
            for todo in completed_todos:
                print(f"  - {todo.id}: {todo.title}")
        else:
            new_version = manager.update_changelog(completed_todos)
            
            # Archive completed TODOs by changing their status
            for todo in completed_todos:
                todo.status = Status.CANCELLED  # Or remove them entirely
            
            manager.save_todos()
            print(f"Created release {new_version}")

if __name__ == "__main__":
    main()