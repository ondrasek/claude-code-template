#!/usr/bin/env python3
"""
Enhanced GitHub Issues Migration Script
Migrates a single spec file to GitHub Issue with full metadata preservation
"""

import re
import sys
import yaml
import subprocess
import json
from datetime import datetime
from pathlib import Path

def parse_spec_file(filepath):
    """Extract YAML frontmatter and content"""
    with open(filepath, 'r') as f:
        content = f.read()
    
    if content.startswith('---'):
        # Has YAML frontmatter
        parts = content.split('---', 2)
        if len(parts) >= 3:
            try:
                metadata = yaml.safe_load(parts[1])
                body = parts[2].strip()
                return metadata, body
            except yaml.YAMLError:
                print(f"Warning: Invalid YAML frontmatter in {filepath}")
                return {}, content.strip()
    
    # No frontmatter, infer metadata
    metadata = infer_metadata(filepath, content)
    body = content.strip()
    return metadata, body

def infer_metadata(filepath, content):
    """Infer metadata from filename and content"""
    filename = Path(filepath).stem
    
    # Infer type from content keywords
    type_mapping = {
        'implement': 'feat',
        'add': 'feat',
        'fix': 'fix',
        'bug': 'fix',
        'docs': 'docs',
        'documentation': 'docs',
        'refactor': 'refactor',
        'test': 'test',
        'cleanup': 'chore',
        'remove': 'chore'
    }
    
    spec_type = 'feat'  # default
    for keyword, mapped_type in type_mapping.items():
        if keyword in filename.lower() or keyword in content.lower()[:200]:
            spec_type = mapped_type
            break
    
    # Infer priority from keywords
    priority = 'medium'  # default
    content_lower = content.lower()
    if any(word in content_lower for word in ['critical', 'urgent', 'high priority', 'blocking']):
        priority = 'high'
    elif any(word in content_lower for word in ['low priority', 'optional', 'nice to have', 'enhancement']):
        priority = 'low'
    
    return {
        'status': 'pending',
        'type': spec_type,
        'priority': priority,
        'assignee': 'specs-analyst',
        'created': datetime.now().strftime('%Y-%m-%d')
    }

def build_labels(metadata):
    """Convert metadata to GitHub labels"""
    labels = []
    
    # Type mapping - the only useful categorization
    type_label_map = {
        'feat': 'enhancement',
        'fix': 'bug',
        'docs': 'documentation',
        'refactor': 'refactoring',
        'test': 'testing',
        'chore': 'maintenance'
    }
    labels.append(type_label_map.get(metadata.get('type', 'feat'), 'enhancement'))
    
    # Migration audit trail
    labels.append('migrated-from-specs')
    
    # That's it. No artificial priority or status theater.
    
    return labels

def format_issue_body(body, metadata, original_filename):
    """Format issue body with migration metadata header"""
    migration_date = datetime.now().strftime('%Y-%m-%d')
    
    migration_header = f"""<!-- Migrated from /specs/ on {migration_date} -->

## 📋 Migration Information
- **Original File:** `/specs/{original_filename}`  
- **Migration Date:** {migration_date}
- **Original Status:** {metadata.get('status', 'unknown')}
- **Original Type:** {metadata.get('type', 'unknown')}  
- **Original Priority:** {metadata.get('priority', 'unknown')}
- **Original Assignee:** {metadata.get('assignee', 'unknown')}
- **Original Created:** {metadata.get('created', 'unknown')}

---

"""
    return migration_header + body

def create_github_labels(repo, labels):
    """Create GitHub labels if they don't exist"""
    existing_labels = subprocess.run([
        'gh', 'label', 'list', '--repo', repo, '--json', 'name'
    ], capture_output=True, text=True)
    
    if existing_labels.returncode == 0:
        existing_names = {label['name'] for label in json.loads(existing_labels.stdout)}
        
        label_colors = {
            'migrated-from-specs': 'e1f5fe'
        }
        
        for label in labels:
            if label not in existing_names and label in label_colors:
                subprocess.run([
                    'gh', 'label', 'create', label,
                    '--color', label_colors[label],
                    '--repo', repo
                ], check=True)
                print(f"Created label: {label}")

def migrate_spec_to_issue(spec_file, repo):
    """Migrate a single spec file to GitHub Issue"""
    metadata, body = parse_spec_file(spec_file)
    original_filename = Path(spec_file).name
    
    # Generate title from filename
    title = Path(spec_file).stem.replace('-', ' ').title()
    
    # Build labels
    labels = build_labels(metadata)
    
    # Create labels if needed
    create_github_labels(repo, labels)
    
    # Format issue body with migration metadata
    formatted_body = format_issue_body(body, metadata, original_filename)
    
    # Write body to temp file
    temp_body_file = '/tmp/issue-body.md'
    with open(temp_body_file, 'w') as f:
        f.write(formatted_body)
    
    # Create GitHub Issue
    result = subprocess.run([
        'gh', 'issue', 'create',
        '--repo', repo,
        '--title', title,
        '--body-file', temp_body_file,
        '--label', ','.join(labels)
    ], capture_output=True, text=True)
    
    if result.returncode == 0:
        issue_url = result.stdout.strip()
        print(f"✅ Successfully migrated: {original_filename}")
        print(f"   GitHub Issue: {issue_url}")
        print(f"   Title: {title}")
        print(f"   Labels: {', '.join(labels)}")
        return issue_url
    else:
        print(f"❌ Failed to migrate {original_filename}")
        print(f"   Error: {result.stderr}")
        return None

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python3 migrate-spec.py <spec-file> <repo>")
        print("Example: python3 migrate-spec.py specs/add-cli-tool.md ondrasek/claude-code-forge")
        sys.exit(1)
    
    spec_file = sys.argv[1]
    repo = sys.argv[2]
    
    if not Path(spec_file).exists():
        print(f"Error: Spec file {spec_file} not found")
        sys.exit(1)
    
    migrate_spec_to_issue(spec_file, repo)