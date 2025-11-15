# Notes - Neovim Note-Taking for Executive Function

A Neovim and shell-based note-taking system designed for engineers with executive function challenges. Get automatic task continuity, low-friction capture, and context-on-demand to reduce cognitive load.

## What You Get

### Organized Structure
- **Daily notes** with automatic task carry-over
- **Wiki pages** for knowledge and reference
- **Projects** for tracking larger initiatives
- **Inbox** for quick captures
- **Templates** for consistency

### Shell Commands
Fast, memorable commands for common operations:

- `today` - Your daily note (auto-carries incomplete tasks)
- `context` - What you're working on RIGHT NOW
- `wiki <name>` - Create/open wiki pages
- `project <name>` - Track projects
- `nfind <term>` - Search everything
- `ntasks` - See all incomplete tasks

### Neovim Integration
- Follow `[[wiki-links]]` with Enter
- Find backlinks to current page
- Toggle task checkboxes
- Telescope integration for fuzzy finding
- Quick navigation between notes

### Executive Function Support
- **Automatic task carry-over**: Never lose track of what you were doing
- **Context command**: Instant reminder of current work
- **Low friction**: Short commands, templates handle structure
- **External memory**: Write everything down, remember nothing
- **Breadcrumb support**: Leave notes for future you

## Why This System Works

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

## What Makes This Different from Logseq

| Feature | Logseq | This System |
|---------|--------|-------------|
| Format | Proprietary/Markdown | Plain Markdown |
| Editor | Electron app | Your Neovim setup |
| Task carry-over | Manual | Automatic |
| Speed | App startup lag | Instant (shell commands) |
| Context switching | Must open app | One-command `context` |
| Customization | Limited | Complete (it's your code) |
| Version control | Extra setup | Just git |
| Keyboard-first | Mostly | 100% |

## Key Principles

1. **Write Everything Down**: Your notes are your external memory
2. **Single Source of Truth**: Today's note is where active work happens
3. **Automatic Continuity**: Tasks carry forward without manual work
4. **Context On Demand**: Run `context` to remember what you're doing
5. **Low Friction**: Commands are short, templates handle structure

## Getting Started

Ready to set up your note-taking system?

1. **[Installation](installation.md)** - Complete setup guide for kickstart.nvim users
2. **[Quickstart](quickstart.md)** - Get up and running in 5 minutes
3. **[User Guide](user-guide.md)** - Learn the workflows and strategies
4. **[Reference](reference.md)** - Command and keybinding quick reference

## Philosophy

This system is built on three insights:

1. **Executive function challenges are working memory challenges**
   Solution: Externalize everything. Trust the system, not your brain.

2. **Friction kills habit formation**
   Solution: Commands are short. Templates are automatic. Everything is fast.

3. **Continuity is more important than perfect organization**
   Solution: Tasks carry automatically. Context is one command away. You can always find things with search.

---

Built for engineers who need external memory, automatic continuity, and zero-friction note-taking.
