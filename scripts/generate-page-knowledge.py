#!/usr/bin/env python3
"""
Page Knowledge Generation Script

Generates page-specific knowledge files for KnowledgeForge AI agents
by combining templates with discipline-specific configurations.

Usage:
    python3 scripts/generate-page-knowledge.py [discipline_code]

Example:
    python3 scripts/generate-page-knowledge.py 01900_procurement
"""

import json
import os
import sys
from pathlib import Path
from datetime import datetime

def load_template(template_path):
    """Load the template file."""
    with open(template_path, 'r', encoding='utf-8') as f:
        return f.read()

def load_config(config_path):
    """Load the configuration file."""
    with open(config_path, 'r', encoding='utf-8') as f:
        return json.load(f)

def generate_knowledge(template_content, config_data, discipline_key):
    """Generate knowledge content by replacing template variables."""
    discipline_config = config_data['disciplines'][discipline_key]

    # Replace all template variables
    content = template_content
    for key, value in discipline_config.items():
        placeholder = f"{{{key}}}"
        content = content.replace(placeholder, str(value))

    return content

def save_knowledge_file(content, output_path):
    """Save the generated knowledge file."""
    # Create directory if it doesn't exist
    output_path.parent.mkdir(parents=True, exist_ok=True)

    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(content)

    print(f"Generated: {output_path}")

def main():
    if len(sys.argv) != 2:
        print("Usage: python3 scripts/generate-page-knowledge.py <discipline_key>")
        print("Example: python3 scripts/generate-page-knowledge.py 01900_procurement")
        sys.exit(1)

    discipline_key = sys.argv[1]

    # Define paths
    script_dir = Path(__file__).parent
    project_root = script_dir.parent

    template_path = project_root / "docs-paperclip" / "disciplines" / "PAGE-KNOWLEDGE-TEMPLATE.md"
    config_path = project_root / "docs-paperclip" / "disciplines" / "PAGE-KNOWLEDGE-CONFIG.json"

    # Load template and config
    try:
        template_content = load_template(template_path)
        config_data = load_config(config_path)
    except FileNotFoundError as e:
        print(f"Error: {e}")
        sys.exit(1)

    # Check if discipline exists in config
    if discipline_key not in config_data['disciplines']:
        print(f"Error: Discipline '{discipline_key}' not found in configuration")
        print(f"Available disciplines: {list(config_data['disciplines'].keys())}")
        sys.exit(1)

    # Generate knowledge content
    discipline_config = config_data['disciplines'][discipline_key]
    knowledge_content = generate_knowledge(template_content, config_data, discipline_key)

    # Determine output path
    discipline_code = discipline_config['DISCIPLINE_CODE']
    discipline_slug = discipline_config['discipline_slug']
    output_dir = project_root / "docs-paperclip" / "disciplines" / f"{discipline_code}-{discipline_slug}" / "knowledge"
    output_path = output_dir / "PAGE-KNOWLEDGE.md"

    # Save the file
    save_knowledge_file(knowledge_content, output_path)

    print(f"Successfully generated page knowledge for {discipline_key}")

if __name__ == "__main__":
    main()