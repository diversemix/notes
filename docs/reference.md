# Quick Reference

Command and keybinding reference for the notes system.

## Shell Commands

### Daily Notes

```bash
today               # Open today's note (auto-carries tasks)
yesterday           # Open most recent daily log
context             # Show current focus and active tasks
notes-help          # Show all commands (alias: nh)
```

### Creating Notes

```bash
wiki <name>         # Create/open wiki page
                    # Example: wiki fastapi-patterns

area <name>         # Create/open area
                    # Example: area backend-development
```

### Quick Capture

```bash
inbox               # Open inbox for longer captures
inbox "message"     # Add message to inbox without opening

nquick "note"       # Append note to today without opening editor
                    # Example: nquick "Review PR #234"
```

### Search and Navigation

```bash
nfind               # Interactive file search (fzf)
nfind <term>        # Search filenames for term

nsearch <term>      # Search within all notes (alias: ns)

nrecent             # Show 10 most recently modified notes
nrecent <n>         # Show n most recently modified notes

ntags <tag>         # Find notes with tag (alias: nbt)
                    # Example: ntags project

ntaglist            # List all tags with frequency (alias: ntl)
```

### Task Management

```bash
ntasks              # Show all incomplete tasks (alias: nt)
tasks-today         # Show just today's tasks (alias: tt)
carry-task "task"   # Manually add task to today's carried section
```

### Review

```bash
nweek               # Show past week's daily notes (alias: nw)
yesterday           # Open most recent daily log
```

### Git Integration

```bash
npush               # Add, commit, and push notes (alias: np)
npull               # Pull latest notes (alias: nl)
```

## Neovim Keybindings

### Navigation

| Key | Action |
|-----|--------|
| `<M-CR>` | Follow [[link]] under cursor |
| `<C-]>` | Follow [[link]] (vim-style) |
| `<C-O>` | Go back to previous location |

### Note Operations

| Key | Action |
|-----|--------|
| `<leader>nt` | Open today's daily log |
| `<leader>ny` | Open yesterday's daily log |
| `<leader>ni` | Open inbox |
| `<leader>nf` | Find notes (Telescope) |
| `<leader>ng` | Grep through notes (Telescope) |
| `<leader>nl` | Insert link to another note |
| `<leader>nb` | Show backlinks to current note |
| `<leader>nn` | Create new wiki note |

### Task Operations

| Key | Action |
|-----|--------|
| `<leader>nx` | Toggle checkbox `[ ]` ↔ `[x]` |
| `<leader>ns` | Show tasks in current note (quickfix) |
| `<leader>na` | Show all incomplete tasks (Telescope) |

### Ex Commands

```vim
:NotesToday         # Open today's daily log
:NotesYesterday     # Open yesterday's daily log
:NotesInbox         # Open inbox
:NotesFind          # Find notes
:NotesGrep          # Grep through notes
:NotesTag           # Find notes by tag
:NotesBacklinks     # Show backlinks
:NotesNew           # Create new note
:NotesTasks         # Show tasks in current note
:NotesAllTasks      # Show all incomplete tasks
```

## Link Syntax

```markdown
[[page-name]]           # Link to wiki/page-name.md
[[areas/name]]          # Link to areas/name.md
[[daily/2025-11-14]]    # Link to daily/2025-11-14.md

#tag                    # Tag
- [ ] task              # Uncompleted task
- [x] task              # Completed task
```

## Directory Structure

```
~/notes/
├── daily/              # Daily notes (YYYY-MM-DD.md)
├── wiki/               # Wiki pages for topics/references
├── areas/              # Ongoing responsibilities and projects
├── inbox/              # Quick captures
├── templates/          # Edit to customize
├── archive/            # Old/completed content
└── incoming/           # Temporary holding area
```

## Template Variables

Used in files under `~/notes/templates/`:

- `{{TITLE}}` - Note title (from filename)
- `{{DATE}}` - Current date (YYYY-MM-DD)

## Shell Aliases

```bash
nf="nfind"              # Search notes
nt="ntasks"             # View all incomplete tasks
tt="tasks-today"        # Today's tasks
nw="nweek"              # Review past week
cx="context"            # Show current context
nq="nquick"             # Quick note
nr="nrecent"            # Recently modified notes
nh="notes-help"         # Show help
ns="nsearch"            # Search within notes
np="npush"              # Push notes to git
nl="npull"              # Pull notes from git
nbt="ntags"             # Find notes by tag
ntl="ntaglist"          # List tag frequency
```

## Environment Variables

```bash
export NOTES_DIR="$HOME/notes"      # Notes directory location
export BAT_THEME="Catppuccin Mocha" # Preview theme for bat
```

## Task Format

Tasks must use this exact format for carry-over:

```markdown
- [ ] Task description       # Incomplete (carries forward)
- [x] Task description       # Complete (doesn't carry)
```

**Important**: Space inside brackets is required.

## Troubleshooting

### Commands not found

```bash
source ~/.zprofile          # or ~/.bash_profile
type today                  # Should show the function
```

### Neovim keybindings not working

```vim
:messages                   # Check for errors
:lua print(vim.inspect(require('notes').config))  # Check if loaded
```

### Tasks not carrying over

Verify format: `- [ ] task` (with space in brackets)

### Show command usage

```bash
wiki                        # Most commands show usage without args
```

---

**See also:**
- [Daily Workflows](daily-workflows.md) - Practical usage patterns
- [User Guide](user-guide.md) - Executive function strategies
- [Installation](installation.md) - Setup instructions
