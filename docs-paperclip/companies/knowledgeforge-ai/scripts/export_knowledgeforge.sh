#!/bin/bash
# KnowledgeForge Knowledge Export Script
# 
# This script exports the docs-construct-ai knowledge base into a portable archive
# that can be imported into any KnowledgeForge deployment.
#
# Usage: ./scripts/export_knowledgeforge.sh [source_dir] [output_dir]

set -euo pipefail

KNOWLEDGE_DIR="${1:-../../../docs-construct-ai}"
OUTPUT_DIR="${2:-./knowledge-export}"
DATE=$(date +%Y%m%d)

echo "🔨 KnowledgeForge Knowledge Export"
echo "=================================="
echo "Source: $KNOWLEDGE_DIR"
echo "Output: $OUTPUT_DIR"
echo ""

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Core knowledge domains
echo "📁 Exporting disciplines..."
if [ -d "$KNOWLEDGE_DIR/disciplines" ]; then
    rsync -av --include='*/' --include='*.md' --exclude='*' \
        "$KNOWLEDGE_DIR/disciplines/" "$OUTPUT_DIR/disciplines/"
    echo "  ✓ Disciplines exported"
else
    echo "  ⚠ Disciplines directory not found"
fi

echo "📁 Exporting codebase documentation..."
if [ -d "$KNOWLEDGE_DIR/codebase" ]; then
    rsync -av --include='*/' --include='*.md' --exclude='*' \
        "$KNOWLEDGE_DIR/codebase/" "$OUTPUT_DIR/codebase/"
    echo "  ✓ Codebase documentation exported"
else
    echo "  ⚠ Codebase directory not found"
fi

echo "📁 Exporting testing documentation..."
if [ -d "$KNOWLEDGE_DIR/testing" ]; then
    rsync -av --include='*/' --include='*.md' --exclude='*' \
        "$KNOWLEDGE_DIR/testing/" "$OUTPUT_DIR/testing/"
    echo "  ✓ Testing documentation exported"
else
    echo "  ⚠ Testing directory not found"
fi

echo "📁 Exporting error tracking..."
if [ -d "$KNOWLEDGE_DIR/error-tracking" ]; then
    rsync -av --include='*/' --include='*.md' --exclude='*' \
        "$KNOWLEDGE_DIR/error-tracking/" "$OUTPUT_DIR/error-tracking/"
    echo "  ✓ Error tracking exported"
else
    echo "  ⚠ Error tracking directory not found"
fi

echo "📁 Exporting standards..."
if [ -d "$KNOWLEDGE_DIR/standards" ]; then
    rsync -av --include='*/' --include='*.md' --exclude='*' \
        "$KNOWLEDGE_DIR/standards/" "$OUTPUT_DIR/standards/"
    echo "  ✓ Standards exported"
else
    echo "  ⚠ Standards directory not found"
fi

echo "📁 Exporting procedures..."
if [ -d "$KNOWLEDGE_DIR/procedures" ]; then
    rsync -av --include='*/' --include='*.md' --exclude='*' \
        "$KNOWLEDGE_DIR/procedures/" "$OUTPUT_DIR/procedures/"
    echo "  ✓ Procedures exported"
else
    echo "  ⚠ Procedures directory not found"
fi

# Create archive
ARCHIVE_NAME="knowledgeforge-${DATE}.tar.gz"
echo "📦 Creating archive: $ARCHIVE_NAME"
tar czf "$OUTPUT_DIR/$ARCHIVE_NAME" -C "$OUTPUT_DIR" .

# Generate manifest
echo "📋 Generating manifest..."
cat > "$OUTPUT_DIR/manifest.json" << EOF
{
  "name": "KnowledgeForge Knowledge Export",
  "date": "$(date -Iseconds)",
  "source": "$KNOWLEDGE_DIR",
  "version": "1.0.0",
  "contents": {
    "disciplines": $(find "$OUTPUT_DIR/disciplines" -name "*.md" 2>/dev/null | wc -l | tr -d ' '),
    "codebase": $(find "$OUTPUT_DIR/codebase" -name "*.md" 2>/dev/null | wc -l | tr -d ' '),
    "testing": $(find "$OUTPUT_DIR/testing" -name "*.md" 2>/dev/null | wc -l | tr -d ' '),
    "error-tracking": $(find "$OUTPUT_DIR/error-tracking" -name "*.md" 2>/dev/null | wc -l | tr -d ' '),
    "standards": $(find "$OUTPUT_DIR/standards" -name "*.md" 2>/dev/null | wc -l | tr -d ' '),
    "procedures": $(find "$OUTPUT_DIR/procedures" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
  },
  "archive": "$ARCHIVE_NAME"
}
EOF

echo ""
echo "✅ Export complete!"
echo "   Archive: $OUTPUT_DIR/$ARCHIVE_NAME"
echo "   Manifest: $OUTPUT_DIR/manifest.json"
echo ""
echo "To import this knowledge into another KnowledgeForge instance:"
echo "  1. Copy the archive to the target instance"
echo "  2. Extract: tar xzf $ARCHIVE_NAME -C /path/to/knowledgeforge-ai/knowledge/"
echo "  3. Run: paperclip companies sync knowledgeforge-ai"