#!/bin/bash
# Notes System Setup Script
# This creates the folder structure and templates for your note-taking system

NOTES_DIR="$HOME/notes"

# Create directory structure
mkdir -p "$NOTES_DIR"/{daily,wiki,templates,inbox,archive}
mkdir -p "$NOTES_DIR/wiki"/{projects,areas,resources}

echo "Created notes directory structure at $NOTES_DIR"

# Create daily note template
cat > "$NOTES_DIR/templates/daily.md" << 'EOF'
# {{DATE}}
<!-- Add thoughts during the day here to be sorted later -->

## 🎯 Primary Focus
<!-- What's the ONE thing that matters most today? -->

## 📋 Carried Over
<!-- Tasks from previous days - automatically populated -->

## ✅ Today's Tasks
- [ ] 

## 📝 Notes & Discoveries

## 🔗 Links
<!-- Pages/projects worked on today -->

## 📊 Daily Reflection
**What went well:**

**What to improve:**

**Energy level:** /10

---
Tags: #daily
EOF

# Create wiki page template
cat > "$NOTES_DIR/templates/wiki.md" << 'EOF'
# {{TITLE}}

## Overview

## Details

## Related
<!-- Links to related pages -->

## Tasks
- [ ] 

---
Created: {{DATE}}
Tags: 
EOF

# Create project template
cat > "$NOTES_DIR/templates/project.md" << 'EOF'
# {{TITLE}}

## Status
**Current Phase:** 
**Priority:** 
**Due Date:** 

## Objective

## Next Actions
- [ ] 

## Context
<!-- Background, why this matters, key decisions -->

## Resources
<!-- Links to related wiki pages, documents, etc. -->

## Log
### {{DATE}}


---
Created: {{DATE}}
Tags: #project
EOF


# Create area template
cat > "$NOTES_DIR/templates/area.md" << 'EOF'
# {{TITLE}}

## Purpose

## Learning Actions
- [ ] 

## Context
<!-- Background, why this matters, key decisions -->

## Resources
<!-- Links to related wiki pages, documents, etc. -->

## Log
### {{DATE}}


---
Created: {{DATE}}
Tags: #area
EOF

# Create resource template
cat > "$NOTES_DIR/templates/resource.md" << 'EOF'
# {{TITLE}}

## Notes

## Links
- ()[]
- ()[]
- ()[]

## Context
<!-- Background, why this matters, key decisions -->

## Resources
<!-- Links to related wiki pages, documents, etc. -->

## Log
### {{DATE}}


---
Created: {{DATE}}
Tags: #resource
EOF

# Create inbox template for quick captures
cat > "$NOTES_DIR/templates/inbox.md" << 'EOF'
# Inbox

EOF

echo "Created templates"

# Create initial inbox file
cp "$NOTES_DIR/templates/inbox.md" "$NOTES_DIR/inbox/inbox.md"

# Create a README
cat > "$NOTES_DIR/README.md" << 'EOF'
# Notes System

## Directory Structure

- `daily/` - Daily notes with tasks and reflections
- `wiki/` - General knowledge, reference material
  - `projects/` - Active projects with objectives and tasks
  - `areas/` - Ongoing areas of responsibility
  - `resources/` - Reference material, how-tos, docs
- `inbox/` - Quick capture location for unprocessed thoughts
- `templates/` - Templates for different note types
- `archive/` - Completed projects and old notes

## Quick Commands

- `today` - Open today's daily note
- `yesterday` - Open yesterday's daily note
- `wiki <name>` - Create or open a wiki page
- `project <name>` - Create or open a project
- `inbox` - Quick capture to inbox
- `nfind` - Search all notes
- `ntags` - Find notes by tag

## Workflow

1. Start each day with `today` - review carried over tasks
2. Use `inbox` for quick captures throughout the day
3. Process inbox items into daily tasks or wiki pages
4. At end of day, move incomplete tasks to next day using `carry-tasks`
EOF

echo "Setup complete! Notes directory created at $NOTES_DIR"
echo ""
echo "Next steps:"
echo "1. Add the functions from notes-functions.sh to your ~/.zshrc or ~/.bashrc"
echo "2. Add the Neovim configuration from notes-nvim.lua to your config"
echo "3. Run 'source ~/.zshrc' (or ~/.bashrc) to load the functions"
