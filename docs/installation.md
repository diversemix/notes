# Installation

This guide covers complete installation for users with kickstart.nvim. Since you already have Telescope and fzf installed, setup is straightforward.

## Quick Installation

### 1. Run the Setup Script

```bash
chmod +x notes-setup.sh
./notes-setup.sh
```

This creates `~/notes/` with the folder structure and templates.

### 2. Add Shell Functions

```bash
# For Zsh (most common)
cat notes-functions.sh >> ~/.zshrc

# Alternatively add a line to source notes-functions.sh

# Then source it
source ~/.zshrc
```

### 3. Add to Your Kickstart Config

```bash
# Copy the kickstart-optimized notes module
cp notes-nvim.lua ~/.config/nvim/lua/notes.lua
```

Then edit your `~/.config/nvim/init.lua` and add this line after your plugins are loaded (typically near the end of the file, after the Telescope configuration):

```lua
-- Notes system
require('notes').setup()
```

### 4. Restart Neovim

```bash
nvim
# You should see: "Notes system loaded. Use <leader>n[f/g/t/l/b/n/x/s/a] or :Notes* commands"
```

## What You Get with Kickstart Integration

Since you already have Telescope, fzf, and ripgrep, the notes system will use them automatically for:

- **Daily logs**: `<leader>nt` opens today's note, `<leader>ny` opens yesterday's
- **Fuzzy finding notes**: `<leader>nf` opens Telescope to find any note
- **Live grep**: `<leader>ng` searches through all your notes in real-time
- **Task overview**: `<leader>na` shows all incomplete tasks across all notes

## Keybindings

Your leader key is already set to Space in kickstart. Here are your notes keybindings:

| Key | Action | Description |
|-----|--------|-------------|
| `<Space>nt` | Open today | Open today's daily log |
| `<Space>ny` | Open yesterday | Open yesterday's (most recent) daily log |
| `<Space>nf` | Find notes | Telescope fuzzy finder for notes |
| `<Space>ng` | Grep notes | Live search through all notes |
| `<Space>nl` | Insert link | Pick a note and insert [[link]] |
| `<Space>nb` | Backlinks | Show what links to current note |
| `<Space>nn` | New note | Create a new wiki note |
| `<Space>nx` | Toggle checkbox | Toggle task [ ] ↔ [x] |
| `<Space>ns` | Show tasks | Tasks in current note (quickfix) |
| `<Space>na` | All tasks | All incomplete tasks (Telescope) |

In markdown files only:

| Key | Action |
|-----|--------|
| `<M-CR>` | Follow [[link]] under cursor (uses correct template) |
| `<Ctrl>]` | Also follows [[link]] (vim-style) |

## Shell Commands

**Essential commands to get started:**
```bash
today           # Open today's note
context         # Show what you're working on
notes-help      # Show all available commands (alias: nh)
```

**For the complete list of all commands**, see:
- [Essential Daily Commands](reference.md#essential-daily-commands)
- [Creating Notes](reference.md#creating-notes)
- [Finding Things](reference.md#finding-things)
- [Task Management](reference.md#task-management)
- [Reviewing](reference.md#reviewing)

## Customization

### Adjust Keybindings

If you want different keybindings, edit `~/.config/nvim/lua/notes.lua` in the `setup_keymaps` function. For example, to use `<leader>f` instead of `<leader>nf`:

```lua
vim.keymap.set('n', '<leader>fn', M.find_notes, vim.tbl_extend('force', opts, { desc = '[F]ind [N]otes' }))
```

### Change Notes Directory

In `~/.config/nvim/lua/notes.lua`:

```lua
M.config = {
  notes_dir = vim.fn.expand("~/my-notes"),  -- Change this
  wiki_dir = vim.fn.expand("~/my-notes/wiki"),
  daily_dir = vim.fn.expand("~/my-notes/daily"),
}
```

And in `~/.zshrc`:

```bash
export NOTES_DIR="$HOME/my-notes"  # Change this
```

### Spell Check Language

The notes system sets spell check to British English (`en_gb`). To change:

In `~/.config/nvim/lua/notes.lua`, find:

```lua
vim.opt_local.spelllang = "en_gb"
```

Change to:
- `"en_us"` for US English
- `"en_gb,en_us"` for both

## Telescope Tips for Notes

### Preview Notes in Telescope

Kickstart's Telescope is already configured to preview files. When you use `<Space>nf` or `<Space>ng`, you'll see previews automatically!

## Smart Daily Log Handling

The `yesterday` command finds your most recent daily log, making it perfect for handling holidays, weekends, and gaps:

**After a long weekend:**
```bash
yesterday   # Opens your last working day (e.g., Friday if it's Tuesday)
```

**After vacation:**
```bash
yesterday   # Opens the last day you made notes (before the break)
```

**The system intelligently handles gaps:**
- `yesterday` always finds the most recent daily log (excluding today)
- No more "No note found for yesterday" errors after time off
- Works perfectly with irregular schedules

## Testing the Installation

```bash
# Create your first note
today

# In Neovim, try these:
# Type: [[wiki/projects/test-project]]
# Press M-Enter on it (creates project with correct template)
# Press Ctrl+O to go back
# Try: <Space>nt (opens today's note)
# Try: <Space>ny (opens yesterday's note)
# Try: <Space>nf (shows Telescope file finder)
# Try: <Space>ng (shows Telescope grep)
```

## Troubleshooting

### Notes keybindings don't work

```vim
# In Neovim
:messages
# Look for errors

# Check if notes loaded
:lua print(vim.inspect(require('notes').config))
```

### Yesterday doesn't work on Monday

```bash
# Check if the improved function is loaded
type yesterday
# Should show the function with weekend logic

# If not, make sure you sourced ~/.zshrc
source ~/.zshrc
```

### Telescope not previewing markdown

Kickstart should handle this, but if not:
```lua
-- In your kickstart config, ensure:
require('telescope').setup {
  defaults = {
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
  }
}
```

## Next Steps

1. Start with `today` and get comfortable with daily notes
2. Use `context` frequently (make it muscle memory)
3. After a week, add wiki pages with `wiki <topic>`
4. Explore Telescope search with `<Space>ng`
5. Read the [User Guide](user-guide.md) for executive function strategies

Your kickstart.nvim setup already has all the powerful search capabilities - the notes system just integrates with them seamlessly!
