---
memory_layer: durable_knowledge
para_section: pages/documentation
gigabrain_tags: documentation
documentation
openstinger_context: general-documentation
last_updated: 2026-03-30
related_docs:
  - docs/
---

# Development Shortcuts Procedure

## Overview
This document outlines the development shortcuts system for the ConstructAI project, providing quick access to frequently used commands and workflows.

## Table of Contents
1. [Terminal Shortcuts](#terminal-shortcuts)
2. [VS Code Tasks](#vs-code-tasks)
3. [Available Shortcuts](#available-shortcuts)
4. [Adding New Shortcuts](#adding-new-shortcuts)
5. [Best Practices](#best-practices)
6. [Troubleshooting](#troubleshooting)

## Terminal Shortcuts

### Setup
Terminal shortcuts are managed through the `.zshrc_dev_shortcut` file in the project root.

**Automatic Loading:**
The shortcuts are automatically loaded when your terminal starts via your `~/.zshrc` file:

```bash
# Load development shortcuts (primary: current project location)
[ -f "/Users/PagesUI/construct_ai/.zshrc_dev_shortcut" ] && source "/Users/PagesUI/construct_ai/.zshrc_dev_shortcut"

# Fallback locations for other project setups
[ -f "/Users/_PropAI/construct_ai/.zshrc_dev_shortcut" ] && source "/Users/_PropAI/construct_ai/.zshrc_dev_shortcut"
[ -f "/Users/Discipline_agents/construct_ai/.zshrc_dev_shortcut" ] && source "/Users/Discipline_agents/construct_ai/.zshrc_dev_shortcut"
```

**Manual Loading:**
If you need to reload shortcuts in an active terminal session:

```bash
source ~/.zshrc
```

### File Structure
```bash
construct_ai/
├── .zshrc_dev_shortcut          # Terminal shortcuts definitions
└── docs/shortcuts/              # Shortcut documentation
    └── 0000_SHORTCUTS_PROCEDURE.md
```

## VS Code Tasks

### Setup
VS Code tasks are defined in `.vscode/tasks.json` and provide integrated development shortcuts within the VS Code environment.

**Accessing VS Code Tasks:**
- Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
- Type "Tasks: Run Task"
- Select the desired task from the list

**Alternative Access:**
- Press `Ctrl+Shift+P` → "Tasks: Run Build Task" for default build tasks
- Use the Command Palette for quick access

### Task Configuration
Tasks are configured in `.vscode/tasks.json` with the following properties:
- `label`: Display name in the task picker
- `type`: Task type (usually "shell")
- `command`: Command to execute
- `args`: Command arguments
- `group`: Task grouping ("build", "test", etc.)
- `isBackground`: Whether the task runs in the background
- `presentation`: How output is displayed

## Available Shortcuts

### Terminal Shortcuts

#### `devbuild`
**Purpose:** Start the development server with full build process
**Usage:** `devbuild`
**Function:**
```bash
devbuild() {
  cd /Users/_PropAI/construct_ai
  npm run dev:with-build
}
```
**What it does:**
1. Checks for conflicting ports (3060, 3001, 8000)
2. Clears all caches
3. Installs dependencies with legacy peer deps
4. Builds the client fresh
5. Starts the language extraction server
6. Starts the nodemon development server

### VS Code Tasks

#### "Dev Server with Build"
**Purpose:** Integrated VS Code task for development server startup
**Access:** `Ctrl+Shift+P` → "Tasks: Run Task" → "Dev Server with Build"
**Configuration:**
- **Type:** Background task
- **Group:** Build (default)
- **Command:** `npm run dev:with-build`
- **Environment:** NODE_ENV=development

#### "Update Database Schema"
**Purpose:** Update database schema from documentation
**Access:** `Ctrl+Shift+P` → "Tasks: Run Task" → "Update Database Schema"
**Configuration:**
- **Type:** Shell task
- **Command:** `bash docs/schema/run_schema_update.sh`
- **Environment:** NODE_ENV=development

## Adding New Shortcuts

### Adding Terminal Shortcuts

1. **Edit the shortcuts file:**
   ```bash
   code .zshrc_dev_shortcut
   ```

2. **Add your function or alias:**
   ```bash
   # Example function
   mybuild() {
     cd /Users/_PropAI/construct_ai
     npm run build
   }

   # Example alias
   alias quicktest='npm test -- --watch'
   ```

3. **Reload shortcuts:**
   ```bash
   source ~/.zshrc
   ```

4. **Test the shortcut:**
   ```bash
   mybuild
   ```

### Adding VS Code Tasks

1. **Edit the tasks configuration:**
   ```bash
   code .vscode/tasks.json
   ```

2. **Add a new task object:**
   ```json
   {
     "label": "My Custom Task",
     "type": "shell",
     "command": "npm",
     "args": ["run", "my-script"],
     "group": "build",
     "presentation": {
       "echo": true,
       "reveal": "always",
       "focus": false,
       "panel": "shared"
     },
     "options": {
       "cwd": "${workspaceFolder}",
       "env": {
         "NODE_ENV": "development"
       }
     }
   }
   ```

3. **Save and test:**
   - Save the file
   - Press `Ctrl+Shift+P` → "Tasks: Run Task"
   - Your new task should appear in the list

## Best Practices

### Naming Conventions
- Use lowercase for function names
- Use descriptive names that indicate the action
- Avoid single letters or abbreviations that aren't obvious
- Example: `devbuild` instead of `db` or `build`

### Function vs Alias
- **Use functions** when you need:
  - Multiple commands
  - Error handling
  - Parameters
  - Complex logic
- **Use aliases** for:
  - Simple command replacements
  - Flag combinations
  - Short frequently-used commands

### Documentation
- Document all shortcuts in this procedure file
- Include purpose, usage, and what the shortcut does
- Keep examples current and tested
- Update when shortcuts change

### Safety
- Always include `cd /Users/_PropAI/construct_ai` in functions
- Test shortcuts before committing to avoid breaking workflows
- Use absolute paths when necessary
- Consider error handling for critical operations

## Troubleshooting

### Terminal Shortcuts

**"Command not found" error:**
```bash
# Reload shortcuts
source ~/.zshrc

# Or restart terminal
```

**Function conflicts:**
- Check for duplicate function/alias names in `.zshrc_dev_shortcut`
- Remove conflicting definitions
- Use unique names

**Path issues:**
- Ensure project path is correct: `/Users/_PropAI/construct_ai`
- Check if you're in the right directory when running shortcuts

### VS Code Tasks

**Task not appearing:**
- Save `.vscode/tasks.json`
- Reload VS Code window: `Ctrl+Shift+P` → "Developer: Reload Window"

**Task failing:**
- Check task configuration syntax
- Verify command exists
- Check environment variables
- Review error output in terminal

**Background tasks not stopping:**
- Use the VS Code terminal panel to stop running tasks
- Check for zombie processes: `ps aux | grep node`

### Common Issues

**Permission denied:**
```bash
# Make scripts executable
chmod +x scripts/*.sh
```

**Port conflicts:**
```bash
# Kill processes on specific ports
lsof -ti:3060 | xargs kill -9
```

**Cache issues:**
```bash
# Clear all caches
npm run clean-cache
```

## Maintenance

### Regular Tasks
- Review and update shortcuts quarterly
- Remove unused shortcuts
- Test all shortcuts after major updates
- Update documentation when shortcuts change

### Version Control
- The `.zshrc_dev_shortcut` file is tracked in git
- Changes should be committed with descriptive messages
- Team members should pull latest changes

### Backup
- Shortcuts are backed up with the repository
- Personal `~/.zshrc` modifications are local
- Document any local customizations

## Quick Reference

### Terminal Commands
```bash
# Load shortcuts
source ~/.zshrc

# Start development server
devbuild

# Check available functions
declare -f | grep -E "^[a-zA-Z_][a-zA-Z0-9_]* \(\)"
```

### VS Code Commands
```
Ctrl+Shift+P → "Tasks: Run Task" → Select task
Ctrl+Shift+P → "Tasks: Run Build Task" → Default build task
```

---

**Last Updated:** November 2026
**Author:** ConstructAI Development Team
**Version:** 1.0.0