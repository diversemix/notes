#!/bin/bash
# Notes System Setup Script
# This creates the folder structure and templates for your note-taking system

NOTES_DIR="$HOME/notes"

# Create directory structure
mkdir -p "$NOTES_DIR"/{daily,wiki,templates,inbox,archive,incoming,areas}

echo "Created notes directory structure at $NOTES_DIR"

# Create inbox template for quick captures
cat > "$NOTES_DIR/templates/inbox.md" << 'EOF'
# Inbox
<!-- Capture any off-topic intrusive thoughts here to process later -->

EOF

# Create daily note template
cat > "$NOTES_DIR/templates/daily.md" << 'EOF'
# {{DATE}}
<!-- Add thoughts during the day here to be sorted later -->

## 🎯 Primary Focus
<!-- What's the ONE thing that matters most today? -->

## ✅ Today's Tasks
<!-- Don't for get to check your inbox -->
- [ ] 

## 📋 Carried Over
<!-- Tasks from previous days - automatically populated -->

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
<!-- General knowledge, reference material, should be written to be public -->
## Overview

## Details

## Related
<!-- Links to related pages -->

---
Created: {{DATE}}
Tags: 
EOF


# Create area template
cat > "$NOTES_DIR/templates/area.md" << 'EOF'
# {{TITLE}}

## Purpose
<!-- Why you care about this area and what the end goal is -->

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

echo "Created templates"

# Create initial inbox file
cp "$NOTES_DIR/templates/inbox.md" "$NOTES_DIR/inbox/inbox.md"

# Create a README
cat > "$NOTES_DIR/README.md" << 'EOF'
# Notes System

[Complete Documentation](https://diversemixnotes.readthedocs.io/en/latest)

## Directory Structure

- `inbox/` - Quick capture location for unprocessed thoughts
- 'incoming/` - Temporary holding for new notes to be sorted
- `daily/` - Daily notes with tasks and reflections
- `wiki/` - General knowledge, reference material
- `areas/` - Ongoing areas of responsibility
- `templates/` - Templates for different note types
- `archive/` - Completed projects and old notes

EOF

echo "Setup complete! Notes directory created at $NOTES_DIR"
echo ""
echo "Next steps:"
echo "1. Add the functions from notes-functions.sh to your ~/.zprofile or ~/.bash_profile"
echo "2. Add the Neovim configuration from notes-nvim.lua to your config"
echo "3. Restart your terminal or source your profile"
echo
echo "TIP: You may want to add your notes to git and use git-crypt for encryption!"
echo 
