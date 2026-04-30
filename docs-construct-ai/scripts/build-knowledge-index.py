#!/usr/bin/env python3
"""
Build a searchable knowledge index from all markdown files in docs-construct-ai.

Extracts YAML frontmatter metadata and produces a single KNOWLEDGE-INDEX.json
that agents can query to discover documents by discipline, workflow, tag, etc.

Usage:
    python scripts/build-knowledge-index.py [--output PATH] [--root PATH]
"""

import json
import os
import re
import sys
import argparse
from pathlib import Path
from datetime import datetime


def extract_frontmatter(content: str) -> dict:
    """Extract YAML frontmatter from markdown content."""
    match = re.match(r'^---\n(.*?)\n---\n', content, re.DOTALL)
    if not match:
        return {}
    
    yaml_text = match.group(1)
    metadata = {}
    
    for line in yaml_text.split('\n'):
        line = line.strip()
        if not line or line.startswith('#'):
            continue
        
        # Handle key: value pairs
        if ':' in line and not line.startswith('-'):
            key, _, value = line.partition(':')
            key = key.strip()
            value = value.strip().strip('"').strip("'")
            metadata[key] = value
        # Handle list items under related_docs
        elif line.startswith('- ') and 'related_docs' in metadata:
            if isinstance(metadata['related_docs'], str):
                metadata['related_docs'] = [metadata['related_docs']]
            metadata['related_docs'].append(line[2:].strip())
    
    return metadata


def classify_document(path: Path, root: Path, metadata: dict) -> dict:
    """Classify a document based on its path and metadata."""
    rel_path = path.relative_to(root)
    path_str = str(rel_path)
    parts = path_str.split('/')
    top_dir = parts[0] if len(parts) > 1 else ''
    
    # Determine document type from path
    doc_type = "unknown"
    discipline_code = None
    discipline_name = None
    workflow_name = None
    
    if 'disciplines/' in path_str and 'disciplines-non/' not in path_str:
        # Extract discipline code and name from path
        parts_disc = path_str.split('disciplines/')
        if len(parts_disc) > 1:
            dir_part = parts_disc[1].split('/')[0]
            # Parse code_name or code-name format (e.g., "01900_procurement" or "00250-commercial")
            match = re.match(r'^(\d+)[_-](.+)$', dir_part)
            if match:
                discipline_code = match.group(1)
                discipline_name = match.group(2).replace('-', ' ').replace('_', ' ').title()
                doc_type = "discipline"
            
            if 'workflow_docs/' in path_str:
                doc_type = "workflow"
                workflow_name = path.stem.replace(f'{discipline_code}_', '').replace(f'{discipline_code}-', '').replace('_', ' ').replace('-', ' ').title() if discipline_code else path.stem.replace('_', ' ').replace('-', ' ').title()
            elif 'agent-data/' in path_str:
                doc_type = "agent-data"
            elif 'api/' in path_str:
                doc_type = "api-reference"
    
    elif 'disciplines-non/' in path_str:
        doc_type = "non-discipline"
        parts_disc = path_str.split('disciplines-non/')
        if len(parts_disc) > 1:
            dir_part = parts_disc[1].split('/')[0]
            match = re.match(r'^(\d+)[_-](.+)$', dir_part)
            if match:
                discipline_code = match.group(1)
                discipline_name = match.group(2).replace('-', ' ').replace('_', ' ').title()
    
    elif '/para/' in path_str:
        if '/projects/' in path_str:
            doc_type = "project"
        elif '/resources/' in path_str:
            doc_type = "resource"
        elif '/areas/' in path_str:
            doc_type = "area"
        elif '/pages/' in path_str:
            doc_type = "page"
        else:
            doc_type = "para"
    
    elif '/memory-integration/' in path_str:
        doc_type = "memory-integration"
    
    elif '/memory/' in path_str:
        doc_type = "daily-memory"
    
    elif '/chat-history-index/' in path_str:
        doc_type = "chat-history"
    
    # Map top-level directories to doc types
    type_map = {
        'codebase': 'codebase',
        'testing': 'testing',
        'error-tracking': 'error-tracking',
        'standards': 'standards',
        'procedures': 'procedure',
        'Archive': 'archive',
        'application-logic': 'application-logic',
        'audit': 'audit',
        'authentication': 'authentication',
        'backup-recon': 'backup-recon',
        'deployment': 'deployment',
        'dev-tools': 'dev-tools',
        'development': 'development',
        'documentation': 'documentation',
        'github': 'github',
        'hermes_agent': 'hermes-agent',
        'hooks': 'hooks',
        'implementation': 'implementation',
        'integration': 'integration',
        'mobile': 'mobile',
        'other': 'other',
        'pages-agents': 'pages-agents',
        'pages-chatbots': 'pages-chatbots',
        'pages-design': 'pages-design',
        'role-permissions': 'role-permissions',
        'scripts': 'scripts',
        'system': 'system',
        'templates': 'templates',
        'tests': 'tests',
        'user-interface': 'user-interface',
        'chat-history-index': 'chat-history',
        'memory-integration': 'memory-integration',
        'memory': 'daily-memory',
        'para': 'para',
    }
    
    if doc_type == "unknown" and top_dir in type_map:
        doc_type = type_map[top_dir]
    
    # Root-level files (AGENTS.md, README.md, etc.)
    if doc_type == "unknown" and top_dir == '':
        doc_type = "root"
    
    # Build tags from metadata and path
    tags = []
    memory_layer = metadata.get('memory_layer', '')
    if memory_layer:
        tags.append(f"layer:{memory_layer}")
    
    gigabrain_tags = metadata.get('gigabrain_tags', '')
    if gigabrain_tags:
        for tag in gigabrain_tags.split(','):
            tag = tag.strip()
            if tag:
                tags.append(tag)
    
    if discipline_code:
        tags.append(f"discipline:{discipline_code}")
        tags.append(f"discipline:{discipline_name.lower().replace(' ', '-')}")
    
    if workflow_name:
        tags.append(f"workflow:{workflow_name.lower().replace(' ', '-')}")
    
    tags.append(f"type:{doc_type}")
    
    return {
        "path": path_str,
        "title": metadata.get('title', path.stem.replace('_', ' ').replace('-', ' ').title()),
        "description": metadata.get('description', ''),
        "type": doc_type,
        "discipline_code": discipline_code,
        "discipline_name": discipline_name,
        "workflow_name": workflow_name,
        "memory_layer": memory_layer,
        "para_section": metadata.get('para_section', ''),
        "openstinger_context": metadata.get('openstinger_context', ''),
        "last_updated": metadata.get('last_updated', ''),
        "tags": list(set(tags)),  # deduplicate
        "related_docs": metadata.get('related_docs', []),
        "file_size_kb": round(path.stat().st_size / 1024, 1),
    }


def build_index(root_dir: str, output_path: str):
    """Build the knowledge index."""
    root = Path(root_dir)
    if not root.exists():
        print(f"Error: {root_dir} does not exist")
        sys.exit(1)
    
    index = {
        "version": "1.0.0",
        "generated_at": datetime.now().isoformat(),
        "root": str(root),
        "summary": {},
        "documents": [],
        "disciplines": {},
        "workflows": {},
        "tags_index": {},
    }
    
    md_files = list(root.rglob('*.md'))
    print(f"Scanning {len(md_files)} markdown files...")
    
    for path in md_files:
        # Skip hidden directories and common exclusions
        if any(part.startswith('.') for part in path.parts):
            continue
        if 'node_modules' in path.parts or 'venv' in path.parts:
            continue
        
        try:
            content = path.read_text(encoding='utf-8')
        except Exception as e:
            print(f"  Warning: Could not read {path}: {e}")
            continue
        
        metadata = extract_frontmatter(content)
        doc_entry = classify_document(path, root, metadata)
        index["documents"].append(doc_entry)
        
        # Build discipline index
        if doc_entry["discipline_code"]:
            code = doc_entry["discipline_code"]
            if code not in index["disciplines"]:
                index["disciplines"][code] = {
                    "code": code,
                    "name": doc_entry["discipline_name"],
                    "document_count": 0,
                    "workflow_count": 0,
                    "paths": [],
                    "workflow_paths": [],
                }
            index["disciplines"][code]["document_count"] += 1
            index["disciplines"][code]["paths"].append(doc_entry["path"])
            
            if doc_entry["type"] == "workflow":
                index["disciplines"][code]["workflow_count"] += 1
                index["disciplines"][code]["workflow_paths"].append(doc_entry["path"])
                
                # Build workflow index
                wf_name = doc_entry["workflow_name"] or doc_entry["title"]
                if wf_name not in index["workflows"]:
                    index["workflows"][wf_name] = {
                        "discipline_code": code,
                        "discipline_name": doc_entry["discipline_name"],
                        "paths": [],
                    }
                index["workflows"][wf_name]["paths"].append(doc_entry["path"])
        
        # Build tag index
        for tag in doc_entry["tags"]:
            if tag not in index["tags_index"]:
                index["tags_index"][tag] = []
            index["tags_index"][tag].append(doc_entry["path"])
    
    # Build summary
    doc_types = {}
    for doc in index["documents"]:
        t = doc["type"]
        doc_types[t] = doc_types.get(t, 0) + 1
    
    index["summary"] = {
        "total_documents": len(index["documents"]),
        "total_disciplines": len(index["disciplines"]),
        "total_workflows": len(index["workflows"]),
        "total_tags": len(index["tags_index"]),
        "by_type": doc_types,
    }
    
    # Sort documents by path for readability
    index["documents"].sort(key=lambda d: d["path"])
    
    # Write output
    output = Path(output_path)
    output.parent.mkdir(parents=True, exist_ok=True)
    
    with open(output, 'w', encoding='utf-8') as f:
        json.dump(index, f, indent=2, ensure_ascii=False)
    
    print(f"\nIndex built: {output}")
    print(f"  Total documents: {index['summary']['total_documents']}")
    print(f"  Disciplines: {index['summary']['total_disciplines']}")
    print(f"  Workflows: {index['summary']['total_workflows']}")
    print(f"  Unique tags: {index['summary']['total_tags']}")
    print(f"\nBy type:")
    for t, count in sorted(doc_types.items()):
        print(f"  {t}: {count}")


def main():
    parser = argparse.ArgumentParser(description='Build knowledge index from markdown files')
    parser.add_argument('--root', default='.', help='Root directory of docs-construct-ai (default: .)')
    parser.add_argument('--output', default='KNOWLEDGE-INDEX.json', help='Output file path (default: KNOWLEDGE-INDEX.json)')
    args = parser.parse_args()
    
    build_index(args.root, args.output)


if __name__ == '__main__':
    main()