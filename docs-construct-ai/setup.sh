#!/bin/bash

# Superpowers Setup Script
# This script ensures all submodules are properly initialized and updated

set -e

echo "🚀 Setting up Superpowers with all submodules..."

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Error: Not in a git repository. Please run this script from the superpowers repository root."
    exit 1
fi

# Initialize and update all submodules
echo "📦 Initializing and updating submodules..."
git submodule update --init --recursive

# Verify submodules are properly set up
echo "✅ Verifying submodule setup..."
if git submodule status | grep -q "^-"; then
    echo "⚠️  Warning: Some submodules may not be properly checked out."
    echo "   Run 'git submodule update --init --recursive' manually if needed."
else
    echo "✅ All submodules are properly initialized!"
fi

echo ""
echo "🎉 Superpowers setup complete!"
echo "   You can now use all features including documentation submodules."