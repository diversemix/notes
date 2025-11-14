# Notes System Quick Reference

## Essential Daily Commands

```bash
today           # Open today's note (auto-carries tasks)
context         # Show what you're working on RIGHT NOW
inbox           # Quick capture for ideas/tasks
```

## Creating Notes

```bash
wiki <name>     # Create/open wiki page
                # Example: wiki fastapi-patterns

project <name>  # Create/open project
                # Example: project auth-refactor
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

```bash
# In shell:
note-quick "task description"    # Add task to today without opening editor
carry-task "task description"    # Manually add task to today's carried-over section

# In Neovim (on a task line):
<leader>nx      # Toggle checkbox [ ] ↔ [x]
```

## Reviewing

```bash
nweek           # See past week's daily notes
yesterday       # Open yesterday's note
nrecent         # Show 10 most recently modified notes
nrecent 20      # Show 20 most recently modified notes
```

## Neovim Keybindings

| Key | Action |
|-----|--------|
| `<CR>` | Follow [[link]] under cursor |
| `<leader>nf` | Find notes |
| `<leader>ng` | Grep all notes |
| `<leader>nl` | Insert link |
| `<leader>nb` | Show backlinks |
| `<leader>nx` | Toggle checkbox |

## Link Syntax

```markdown
[[page-name]]           # Link to wiki page
#tag                    # Tag
- [ ] task              # Uncompleted task
- [x] task              # Completed task
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
note-quick "note"       # Quick capture
inbox                   # Longer captures
```

### When Interrupted
```bash
note-quick "Paused at: [what you were doing]"
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
# Link from today's note: [[my-new-project]]
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

## Pro Tips

1. **Primary Focus**: Always set it. When in doubt, work on it.

2. **Context Command**: Make it muscle memory. Type it often.

3. **Inbox Processing**: Process inbox → daily tasks or wiki pages regularly

4. **Links Over Folders**: Use [[links]] and #tags instead of complex folders

5. **One Daily Note**: All daily work goes in one place (today's note)

6. **Tasks That Linger**: 3+ carries = break down, delegate, or delete

7. **End of Day**: Don't stress. Just check off what's done. System handles the rest.

## Troubleshooting Quick Fixes

```bash
# Command not found
source ~/.zshrc         # or ~/.bashrc

# See what functions are loaded
type today              # Should show the function

# Neovim keybindings not working
:messages               # Check for errors in Neovim

# Tasks not carrying over
# Make sure format is: - [ ] task (with space in brackets)
```

## File Locations

```
~/notes/daily/          # Your daily notes
~/notes/wiki/           # Your wiki pages
~/notes/inbox/          # Quick captures
~/notes/templates/      # Edit to customize
```

## Getting Help

```bash
# Most commands show usage without args
wiki
project
nfind

# In Neovim
:NotesFind
:NotesGrep
```

## Remember

- **Write everything down**: Your notes are your external memory
- **Use context often**: Especially after breaks or interruptions
- **Trust the system**: Tasks carry automatically, just mark them done
- **Primary Focus**: One thing. Always.
- **Low friction**: Commands are short by design. Use them.

---

Print this and keep it visible until commands become muscle memory.
