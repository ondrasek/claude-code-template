#!/usr/bin/env python3
"""
TODO Migration Utility

Converts existing TODO.md format to new YAML frontmatter format
for the Claude Code TODO management system.
"""

import re
import sys
from pathlib import Path
from datetime import datetime
from todo_manager import TODO, TodoType, SemVerImpact, TodoStatus, Priority, TODOFormatter


def parse_old_format_todo(content: str, section_title: str) -> TODO:
    """Parse a TODO from the old markdown format"""
    lines = content.strip().split('\n')
    
    # Extract title from section header
    title_match = re.match(r'^### \d+\.\s*(.+)$', section_title)
    title = title_match.group(1) if title_match else section_title.replace('### ', '')
    
    # Default values
    status = TodoStatus.PENDING
    todo_type = TodoType.IMPROVEMENT  
    impact = SemVerImpact.PATCH
    priority = Priority.MEDIUM
    assignee = "unassigned"
    description = ""
    acceptance_criteria = []
    implementation_notes = ""
    dependencies = []
    
    # Parse fields from content
    current_section = None
    description_lines = []
    criteria_lines = []
    implementation_lines = []
    
    for line in lines:
        stripped = line.strip()
        
        # Field parsing
        if stripped.startswith('**Status**:'):
            status_text = stripped.split(':', 1)[1].strip()
            try:
                status = TodoStatus(status_text.lower())
            except ValueError:
                status = TodoStatus.PENDING
        
        elif stripped.startswith('**Type**:'):
            type_text = stripped.split(':', 1)[1].strip()
            try:
                todo_type = TodoType(type_text.lower())
            except ValueError:
                todo_type = TodoType.IMPROVEMENT
        
        elif stripped.startswith('**SemVer Impact**:'):
            impact_text = stripped.split(':', 1)[1].strip()
            try:
                impact = SemVerImpact(impact_text.lower())
            except ValueError:
                impact = SemVerImpact.PATCH
        
        elif stripped.startswith('**Assigned**:'):
            assignee = stripped.split(':', 1)[1].strip()
            if '+' in assignee:
                assignee = assignee.split('+')[0].strip()  # Take first agent
        
        elif stripped.startswith('**Dependencies**:'):
            deps_text = stripped.split(':', 1)[1].strip()
            if deps_text.lower() != 'none':
                dependencies = [dep.strip() for dep in deps_text.split(',')]
        
        elif stripped.startswith('**Description**:'):
            current_section = 'description'
            desc_text = stripped.split(':', 1)[1].strip()
            if desc_text:
                description_lines.append(desc_text)
        
        elif stripped.startswith('**Acceptance Criteria**:'):
            current_section = 'criteria'
        
        elif stripped.startswith('**') and stripped.endswith('**:'):
            current_section = 'other'
        
        # Content sections
        elif stripped.startswith('- [ ]'):
            if current_section == 'criteria':
                criteria_lines.append(stripped[5:].strip())
        
        elif stripped.startswith('```') or stripped.startswith('- '):
            if current_section == 'description':
                description_lines.append(line)
            elif current_section == 'other':
                implementation_lines.append(line)
        
        elif current_section == 'description' and stripped:
            description_lines.append(line)
        elif current_section == 'other' and stripped:
            implementation_lines.append(line)
    
    # Determine priority from section
    if 'high priority' in section_title.lower():
        priority = Priority.HIGH
    elif 'medium priority' in section_title.lower():
        priority = Priority.MEDIUM
    elif 'low priority' in section_title.lower():
        priority = Priority.LOW
    
    # Build description
    if description_lines:
        description = '\n'.join(description_lines).strip()
    
    # Build acceptance criteria
    acceptance_criteria = criteria_lines
    
    # Build implementation notes
    implementation_notes = '\n'.join(implementation_lines).strip()
    
    # Generate ID
    todo_id = generate_todo_id(title)
    
    now = datetime.now().strftime("%Y-%m-%d")
    
    return TODO(
        id=todo_id,
        title=title,
        type=todo_type,
        impact=impact,
        status=status,
        priority=priority,
        created=now,
        updated=now,
        assignee=assignee,
        dependencies=dependencies,
        description=description,
        acceptance_criteria=acceptance_criteria,
        implementation_notes=implementation_notes
    )


def generate_todo_id(title: str) -> str:
    """Generate a TODO ID from title"""
    # Convert to uppercase, remove special chars, take first few words
    words = re.findall(r'\w+', title.upper())
    return f"TODO-{'-'.join(words[:3])}"


def migrate_todo_file(file_path: Path) -> list[TODO]:
    """Migrate old format TODO file to new format"""
    if not file_path.exists():
        print(f"File not found: {file_path}")
        return []
    
    content = file_path.read_text(encoding='utf-8')
    todos = []
    
    # Split into sections by ### headers
    sections = re.split(r'\n### ', content)
    
    for i, section in enumerate(sections):
        if i == 0:
            continue  # Skip header section
        
        # Add back the ### prefix
        section = '### ' + section
        
        # Find the title line
        lines = section.split('\n')
        title_line = lines[0]
        
        # Skip if this is not a numbered task
        if not re.match(r'^### \d+\.', title_line):
            continue
        
        # Get content (everything after title until next ### or end)
        content_lines = []
        for line in lines[1:]:
            if line.startswith('### '):
                break
            content_lines.append(line)
        
        section_content = '\n'.join(content_lines)
        
        try:
            todo = parse_old_format_todo(section_content, title_line)
            todos.append(todo)
            print(f"Migrated: {todo.title}")
        except Exception as e:
            print(f"Failed to migrate section '{title_line}': {e}")
    
    return todos


def main():
    """Main migration function"""
    import argparse
    
    parser = argparse.ArgumentParser(description="Migrate TODO.md to new format")
    parser.add_argument("--input", default="TODO.md", help="Input TODO file")
    parser.add_argument("--output", default="TODO-new.md", help="Output file")
    parser.add_argument("--dry-run", action="store_true", help="Show what would be done")
    parser.add_argument("--replace", action="store_true", help="Replace original file")
    
    args = parser.parse_args()
    
    input_path = Path(args.input)
    output_path = Path(args.output)
    
    if args.replace:
        output_path = input_path
    
    # Migrate TODOs
    todos = migrate_todo_file(input_path)
    
    if not todos:
        print("No TODOs found to migrate")
        return 1
    
    # Format as new structure
    formatted_content = TODOFormatter.format_file(todos)
    
    if args.dry_run:
        print("\nMigrated content preview:")
        print("=" * 50)
        print(formatted_content[:1000] + "..." if len(formatted_content) > 1000 else formatted_content)
        print("=" * 50)
        print(f"\nWould write {len(todos)} TODOs to {output_path}")
    else:
        output_path.write_text(formatted_content, encoding='utf-8')
        print(f"\nSuccessfully migrated {len(todos)} TODOs to {output_path}")
        
        if args.replace:
            print(f"Replaced original file: {input_path}")
    
    return 0


if __name__ == "__main__":
    sys.exit(main())