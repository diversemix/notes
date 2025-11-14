# Notes System - Complete Package

A Neovim and shell-based note-taking system designed for engineers with executive function challenges. This system provides automatic task continuity, low-friction capture, and context-on-demand to reduce cognitive load.

## What You Get

### 1. Organized Structure
- **Daily notes** with automatic task carry-over
- **Wiki pages** for knowledge and reference
- **Projects** for tracking larger initiatives
- **Inbox** for quick captures
- **Templates** for consistency

### 2. Shell Commands
Fast, memorable commands for common operations:
- `today` - Your daily note (auto-carries incomplete tasks)
- `context` - What you're working on RIGHT NOW
- `wiki <n>` - Create/open wiki pages
- `project <n>` - Track projects
- `nfind <term>` - Search everything
- `ntasks` - See all incomplete tasks

### 3. Neovim Integration
- Follow `[[wiki-links]]` with Enter
- Find backlinks to current page
- Toggle task checkboxes
- Telescope integration for fuzzy finding
- Quick navigation between notes

### 4. Executive Function Support
- **Automatic task carry-over**: Never lose track of what you were doing
- **Context command**: Instant reminder of current work
- **Low friction**: Short commands, templates handle structure
- **External memory**: Write everything down, remember nothing
- **Breadcrumb support**: Leave notes for future you

## Files Included

| File | Purpose |
|------|---------|
| `notes-setup.sh` | Creates directory structure and templates |
| `notes-functions.sh` | Shell functions and aliases to add to .zshrc/.bashrc |
| `notes-nvim.lua` | Neovim plugin for link following and searching |
| `notes-workflow-guide.md` | Detailed workflow strategies |

## Quick Start

### 1. Install
```bash
chmod +x notes-setup.sh
./notes-setup.sh
cat notes-functions.sh >> ~/.zshrc  # or ~/.bashrc
source ~/.zshrc
```

### 2. Configure Neovim
```bash
mkdir -p ~/.config/nvim/lua
cp notes-nvim.lua ~/.config/nvim/lua/notes.lua
```

Add to `~/.config/nvim/init.lua`:
```lua
require('notes').setup()
```

### 3. Start Using
```bash
today     # Create your first daily note
```

## Key Principles

1. **Write Everything Down**: Your notes are your external memory
2. **Single Source of Truth**: Today's note is where active work happens
3. **Automatic Continuity**: Tasks carry forward without manual work
4. **Context On Demand**: Run `context` to remember what you're doing
5. **Low Friction**: Commands are short, templates handle structure

## Why This System Works for Executive Function Challenges

### Problem: Struggling to remember where you left off
**Solution**: Automatic task carry-over. Every morning, yesterday's incomplete tasks are already in today's note.

### Problem: Context switching breaks focus
**Solution**: `context` command shows your current work without opening files. `note-quick` lets you leave breadcrumbs.

### Problem: Overwhelmed by too many tasks
**Solution**: Daily notes focus on TODAY only. One Primary Focus per day. Everything else is secondary.

### Problem: Analysis paralysis when deciding what to work on
**Solution**: Look at Primary Focus. That's always the answer.

### Problem: Tasks scattered across multiple systems
**Solution**: One daily note per day. Wiki pages for reference. That's it.

### Problem: Forgetting to check notes
**Solution**: Make `context` part of your terminal prompt or add it to your shell startup. Make it automatic.

