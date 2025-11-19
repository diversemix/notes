# Quickstart Guide

Get up and running with the notes system in 5 minutes.

## Installation (2 minutes)

```bash
# 1. Run setup script
chmod +x notes-setup.sh
./notes-setup.sh

# 2. Add shell functions
cat notes-functions.sh >> ~/.zprofile
source ~/.zprofile

# 3. Add Neovim integration
cp notes-nvim.lua ~/.config/nvim/lua/notes.lua
```

Add to `~/.config/nvim/init.lua`:
```lua
require('notes').setup()
```

Restart Neovim.

## Your First Note (1 minute)

```bash
# Open today's note
today
```

In Neovim, you'll see a template with:
- Primary Focus section
- Today's Tasks section
- Notes section
- Daily Reflection section

Try this:
1. Set your Primary Focus: "Learn the notes system"
2. Add a task: `- [ ] Test wiki links`
3. Save and close (`:wq`)

## Try the Core Commands (2 minutes)

### Create a wiki page

```bash
wiki test-page
```

Add some content, then save and close.

### Check your context

```bash
context
```

This shows what you're working on right now.

### Quick capture

```bash
nquick "Remember to review pull requests"
```

This adds a note to today without opening the editor.

### Search your notes

```bash
nfind test
```

Uses fzf to find notes interactively.

## Try Neovim Features (Optional)

Open today's note again:
```bash
today
```

### Create and follow links

1. Type: `See [[areas/test-project]]`
2. Press M-Enter on the link (creates area with correct template)
3. Press `Ctrl+O` to go back

### Toggle tasks

1. Put cursor on a task line: `- [ ] Test wiki links`
2. Press `<Space>nx` (toggles checkbox)

### Find notes with Telescope

In Neovim:
- Press `<Space>nf` - Find any note
- Press `<Space>ng` - Search through all notes

## Daily Workflow

### Morning (5 min)
```bash
today                   # Opens with yesterday's incomplete tasks carried over
# Set your Primary Focus
# Review tasks
```

### During Work
```bash
context                 # When you need to remember what you're doing
nquick "quick thought"  # Quick capture
```

### End of Day (5 min)
```bash
today
# Mark completed tasks: [ ] → [x]
# Add daily reflection
# Delete irrelevant tasks
# Close (incomplete tasks auto-carry to tomorrow)
```

## Essential Commands

```bash
today           # Open today's note
context         # Show what you're working on
wiki <name>     # Create/open wiki page
notes-help      # Show all commands (alias: nh)
```

**See [Quick Reference](reference.md) for the complete command list.**

## Essential Keybindings (in Neovim)

| Key | Action |
|-----|--------|
| `<M-CR>` | Follow [[link]] (uses correct template) |
| `<Space>nt` | Open today's daily log |
| `<Space>nf` | Find notes (Telescope) |
| `<Space>nx` | Toggle task checkbox |

**See [Neovim Keybindings](reference.md#neovim-keybindings) for the complete list.**

## Next Steps

1. **Use it for a week**: Just `today` and `context` commands
2. **Learn the philosophy**: [User Guide](user-guide.md) for executive function strategies
3. **Master workflows**: [Daily Workflows](daily-workflows.md) for practical patterns
4. **Quick reference**: [Reference](reference.md) for command lookup

## Quick Tips

- **Primary Focus**: Always set it. When in doubt, work on it.
- **Context Command**: Make it muscle memory. Type it often.
- **Tasks Carry Automatically**: Just mark what's done, system handles the rest.
- **Write Everything Down**: Your notes are your external memory.

---

That's it! You're ready to use the system. The rest is just learning the additional features at your own pace.
