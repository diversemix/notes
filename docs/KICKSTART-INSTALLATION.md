# Notes System Installation for Kickstart.nvim Users

Since you're already using kickstart.nvim, you have Telescope and fzf installed! This makes setup even simpler.

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

- **Fuzzy finding notes**: `<leader>nf` opens Telescope to find any note
- **Live grep**: `<leader>ng` searches through all your notes in real-time
- **Tag searching**: `<leader>nt` finds notes by tag using Telescope
- **Task overview**: `<leader>na` shows all incomplete tasks across all notes

## Keybindings (with Kickstart)

Your leader key is already set to Space in kickstart. Here are your notes keybindings:

| Key | Action | Description |
|-----|--------|-------------|
| `<Space>nf` | Find notes | Telescope fuzzy finder for notes |
| `<Space>ng` | Grep notes | Live search through all notes |
| `<Space>nt` | Find by tag | Search notes by #tag |
| `<Space>nl` | Insert link | Pick a note and insert [[link]] |
| `<Space>nb` | Backlinks | Show what links to current note |
| `<Space>nn` | New note | Create a new wiki note |
| `<Space>nx` | Toggle checkbox | Toggle task [ ] ↔ [x] |
| `<Space>ns` | Show tasks | Tasks in current note (quickfix) |
| `<Space>na` | All tasks | All incomplete tasks (Telescope) |

In markdown files only:
| Key | Action |
|-----|--------|
| `<Enter>` | Follow [[link]] under cursor |
| `<Ctrl>]` | Also follows [[link]] (vim-style) |

## Shell Commands

```bash
# Daily notes
today           # Open today (auto-carries tasks from last workday)
yesterday       # Open yesterday (or Friday if it's Monday)

# If it's Monday, 'yesterday' opens Friday's note
# If it's Sunday, 'yesterday' opens Friday's note

# Creation
wiki <name>     # Create/open wiki page
project <name>  # Create/open project

# Quick capture
inbox           # Open inbox for captures
note-quick "text"  # Quick note to today without opening editor

# Search and review
nfind [term]    # Search notes (with fzf if no term)
ntags <tag>     # Find notes with tag
ntasks          # All incomplete tasks
tasks-today     # Just today's tasks
context         # Show current work context
nweek           # Review past week
```

## Customization for Kickstart

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

### Custom Telescope Picker for Today's Note

Add this to your `~/.config/nvim/lua/notes.lua`:

```lua
-- Quick open today's note
M.open_today = function()
  local date = os.date("%Y-%m-%d")
  local file = M.config.daily_dir .. "/" .. date .. ".md"
  vim.cmd("edit " .. file)
end

-- Add to keymaps:
vim.keymap.set('n', '<leader>nd', M.open_today, vim.tbl_extend('force', opts, { desc = '[N]otes To[D]ay' }))
```

### Preview Notes in Telescope

Kickstart's Telescope is already configured to preview files. When you use `<Space>nf` or `<Space>ng`, you'll see previews automatically!

## Weekend Handling Details

The improved `yesterday` and `today` functions handle weekends intelligently:

**Monday morning:**
```bash
today       # Carries tasks from Friday (not Sunday)
yesterday   # Opens Friday's note (not Sunday)
```

**Friday evening:**
```bash
today       # Normal Friday note
# Over the weekend, incomplete tasks wait
# Monday: they'll carry over automatically
```

**If you accidentally run commands on weekends:**
```bash
# Saturday or Sunday
yesterday   # Opens Friday's note (safe)
```

## Testing the Installation

```bash
# Create your first note
today

# In Neovim, try these:
# Type: [[test-page]]
# Press Enter on it (creates and opens the page)
# Press Ctrl+O to go back
# Try: <Space>nf (should show Telescope file finder)
# Try: <Space>ng (should show Telescope grep)
```

## Troubleshooting

**Notes keybindings don't work:**
```vim
# In Neovim
:messages
# Look for errors

# Check if notes loaded
:lua print(vim.inspect(require('notes').config))
```

**Yesterday doesn't work on Monday:**
```bash
# Check if the improved function is loaded
type yesterday
# Should show the function with weekend logic

# If not, make sure you sourced ~/.zshrc
source ~/.zshrc
```

**Telescope not previewing markdown:**
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
5. Read the workflow guide for executive function strategies

Your kickstart.nvim setup already has all the powerful search capabilities - the notes system just integrates with them seamlessly!
