# Quick Reference

A comprehensive reference for all commands, keybindings, and workflows.

## Essential Daily Commands

```bash
today           # Open today's note (auto-carries tasks)
yesterday       # Open most recent daily log (handles holidays/gaps)
context         # Show what you're working on RIGHT NOW
inbox           # Quick capture for ideas/tasks
notes-help      # Show all available commands (alias: nh)
```

## Creating Notes

```bash
wiki <name>     # Create/open wiki page
                # Example: wiki fastapi-patterns

project <name>  # Create/open project
                # Example: project auth-refactor

area <name>     # Create/open area
                # Example: area backend-development

resource <name> # Create/open resource
                # Example: resource jwt-guide
```

## Finding Things

```bash
nfind           # Interactive search (with fzf)
nfind <term>    # Search for term in all notes

ntags <tag>     # Find notes with specific tag
                # Example: ntags project

ntasks          # Show ALL incomplete tasks
tasks-today     # Show just today's tasks
```

## Task Management

### In Shell

```bash
nquick "task description"       # Add note to today without opening editor
carry-task "task description"   # Manually add task to today's carried-over section
```

### In Neovim

On a task line:
```
<leader>nx      # Toggle checkbox [ ] ↔ [x]
```

## Reviewing

```bash
nweek           # See past week's daily notes
yesterday       # Open most recent daily log (handles holidays/gaps)
nrecent         # Show 10 most recently modified notes with relative time
nrecent 20      # Show 20 most recently modified notes
                # Example output: "daily/2025-11-16.md    5m ago"
```

## Neovim Keybindings

### Navigation

| Key | Action | Description |
|-----|--------|-------------|
| `<M-CR>` | Follow link | Follow [[link]] under cursor (uses correct template) |
| `<Ctrl>]` | Follow link | Also follows [[link]] (vim-style) |
| `<Ctrl>O` | Go back | Return to previous location |

### Notes Commands

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>nt` | Open today | Open today's daily log |
| `<leader>ny` | Open yesterday | Open yesterday's (most recent) daily log |
| `<leader>nf` | Find notes | Telescope fuzzy finder for notes |
| `<leader>ng` | Grep notes | Live search through all notes |
| `<leader>nl` | Insert link | Pick a note and insert [[link]] |
| `<leader>nb` | Backlinks | Show what links to current note |
| `<leader>nn` | New note | Create a new wiki note |
| `<leader>nx` | Toggle checkbox | Toggle task [ ] ↔ [x] |
| `<leader>ns` | Show tasks | Tasks in current note (quickfix) |
| `<leader>na` | All tasks | All incomplete tasks (Telescope) |

### Ex Commands

```vim
:NotesToday     # Open today's daily log
:NotesYesterday # Open yesterday's daily log
:NotesFind      # Find notes
:NotesGrep      # Grep through notes
:NotesTag       # Find notes by tag
:NotesBacklinks # Show backlinks
:NotesNew       # Create new note
:NotesTasks     # Show tasks in current note
:NotesAllTasks  # Show all incomplete tasks
```

## Link Syntax

```markdown
[[page-name]]                # Link to wiki/page-name.md
[[wiki/projects/name]]       # Link to wiki/projects/name.md
[[wiki/areas/name]]          # Link to wiki/areas/name.md
[[wiki/resources/name]]      # Link to wiki/resources/name.md
[[daily/2025-11-14]]         # Link to daily/2025-11-14.md

#tag                         # Tag
- [ ] task                   # Uncompleted task
- [x] task                   # Completed task
```

## Typical Daily Flow

### Morning (5 min)

```bash
today                   # Opens today's note with carried-over tasks
# Set your Primary Focus (edit the note)
# Review carried-over tasks
```

### During Work

```bash
context                 # When you need to remember what you're doing
nquick "note"          # Quick capture
inbox                   # Longer captures
```

### When Interrupted

```bash
nquick "Paused at: [what you were doing]"
# Handle interruption
context                 # Resume work
```

### End of Day (5 min)

```bash
today                   # Open today's note
# Mark completed tasks: [ ] → [x]
# Add daily reflection
# Delete irrelevant tasks
# Leave incomplete tasks (they auto-carry to tomorrow)
```

## Emergency: "Where was I?"

```bash
context                 # Always start here
today                   # See today's work
nrecent                 # Check recent files
```

## Common Workflows

### Start a New Project

```bash
project my-new-project
# Fill in objective, next actions
# Link from today's note: [[wiki/projects/my-new-project]]
```

### Research a Topic

```bash
wiki topic-name
# Take notes, add links
# Tag with #research or #learning
```

### Weekly Review

```bash
nweek                   # See the week
# Review patterns
# Update projects
# Plan next week in today's note
```

## File Locations

```
~/notes/
├── daily/              # Your daily notes (YYYY-MM-DD.md)
├── wiki/               # Your wiki pages
│   ├── projects/       # Active projects
│   ├── areas/          # Ongoing responsibilities
│   └── resources/      # Reference material
├── inbox/              # Quick captures
└── templates/          # Edit to customize
```

## Template Variables

When creating notes, these variables are replaced:

- `{{TITLE}}` - Note title (from filename)
- `{{DATE}}` - Current date (YYYY-MM-DD)

## Pro Tips

1. **Primary Focus**: Always set it. When in doubt, work on it.

2. **Context Command**: Make it muscle memory. Type it often.

3. **Inbox Processing**: Process inbox → daily tasks or wiki pages regularly

4. **Links Over Folders**: Use [[links]] and #tags instead of complex folders

5. **One Daily Note**: All daily work goes in one place (today's note)

6. **Tasks That Linger**: 3+ carries = break down, delegate, or delete

7. **End of Day**: Don't stress. Just check off what's done. System handles the rest.

## Troubleshooting Quick Fixes

### Command not found

```bash
source ~/.zshrc         # or ~/.bashrc
```

### See what functions are loaded

```bash
type today              # Should show the function
```

### Neovim keybindings not working

```vim
# In Neovim
:messages               # Check for errors

# Check if notes loaded
:lua print(vim.inspect(require('notes').config))
```

### Tasks not carrying over

Make sure format is: `- [ ] task` (with space in brackets)

### Show usage for commands

```bash
# Most commands show usage without args
wiki
project
nfind
```

## Shell Aliases

Built-in aliases (automatically available):

```bash
n="nfind"           # Search notes
nt="ntasks"         # View all incomplete tasks
tt="tasks-today"    # Today's tasks
nw="nweek"          # Review past week
cx="context"        # Show current context
nq="nquick"         # Quick note
nr="nrecent"        # Recently modified notes
nh="notes-help"     # Show help
```

## Environment Variables

Customize by setting in your shell profile:

```bash
export NOTES_DIR="$HOME/notes"          # Notes directory location
export EDITOR="nvim"                     # Editor for opening notes
```

## Remember

- **Write everything down**: Your notes are your external memory
- **Use context often**: Especially after breaks or interruptions
- **Trust the system**: Tasks carry automatically, just mark them done
- **Primary Focus**: One thing. Always.
- **Low friction**: Commands are short by design. Use them.

---

Print this and keep it visible until commands become muscle memory.
