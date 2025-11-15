# Notes - Neovim Note-Taking for Executive Function

A kickstart.nvim-based note-taking system with Logseq-like functionality, designed specifically for people who struggle with executive function. Get automatic task continuity, context-on-demand, and zero-friction capture.

## Features

- **Automatic task carry-over** - Yesterday's incomplete tasks appear in today's note automatically
- **Context command** - Instant reminder of what you're working on, without opening files
- **Wiki-style links** - Connect notes with `[[links]]`, follow them with Enter
- **Fast shell commands** - `today`, `context`, `wiki`, `nfind` - all instant
- **Telescope integration** - Fuzzy find and grep through all your notes
- **Executive function support** - Designed to reduce cognitive load and context-switching pain

## Quick Start

```bash
# 1. Run setup
chmod +x notes-setup.sh
./notes-setup.sh

# 2. Add shell functions
cat notes-functions.sh >> ~/.zshrc
source ~/.zshrc

# 3. Add Neovim integration
cp notes-nvim.lua ~/.config/nvim/lua/notes.lua
```

Add to `~/.config/nvim/init.lua`:
```lua
require('notes').setup()
```

## Essential Commands

```bash
today           # Open today's note (auto-carries incomplete tasks)
context         # Show what you're working on RIGHT NOW
wiki <name>     # Create/open wiki page
nfind [term]    # Search all notes
ntasks          # Show all incomplete tasks
```

## Documentation

Full documentation is available in the `docs/` folder:

- **[Installation Guide](docs/installation.md)** - Complete setup for kickstart.nvim users
- **[Quickstart](docs/quickstart.md)** - Get started in 5 minutes
- **[User Guide](docs/user-guide.md)** - Workflows and executive function strategies
- **[Wiki Links](docs/wiki-links.md)** - How to use wiki-style links effectively
- **[Reference](docs/reference.md)** - Complete command and keybinding reference

## What Makes This Different

| Feature | Logseq | This System |
|---------|--------|-------------|
| Format | Proprietary/Markdown | Plain Markdown |
| Editor | Electron app | Your Neovim setup |
| Task carry-over | Manual | Automatic |
| Speed | App startup lag | Instant (shell commands) |
| Context switching | Must open app | One-command `context` |
| Customization | Limited | Complete control |
| Version control | Extra setup | Just git |

## Why Executive Function?

This system helps with:

- **Context switching** - Quick `context` command shows what you're doing
- **Task continuity** - Automatic carry-over between days
- **Reduced friction** - Templates and short commands minimize decision fatigue
- **External memory** - Write everything down, remember nothing

## Example Workflow

**Morning:**
```bash
today           # Auto-carries yesterday's incomplete tasks
# Set Primary Focus, review tasks
```

**During day:**
```bash
context         # After interruptions: "what was I doing?"
nquick "idea"   # Quick capture without opening editor
```

**End of day:**
```bash
today
# Check off completed tasks
# Delete irrelevant ones
# Close (incomplete tasks auto-carry to tomorrow)
```

## Requirements

- Neovim with kickstart.nvim (or Telescope + fzf)
- Bash or Zsh shell
- ripgrep (for searching)

## Project Structure

```
~/notes/
├── daily/              # Daily notes (YYYY-MM-DD.md)
├── wiki/
│   ├── projects/       # Active projects
│   ├── areas/          # Ongoing responsibilities
│   └── resources/      # Reference material
├── inbox/              # Quick captures
└── templates/          # Customizable templates
```

## Contributing

Contributions welcome! This is a simple system designed to be customized. Feel free to fork and adapt to your needs.

## License

MIT - Use it, modify it, make it yours.

## Support

- Read the [Installation Guide](docs/installation.md) for setup help
- Check the [Reference](docs/reference.md) for command syntax
- Review the [User Guide](docs/user-guide.md) for workflow questions

---

**GitHub Repository**: [diversemix/notes](https://github.com/diversemix/notes)

Built for engineers who need external memory, automatic continuity, and zero-friction note-taking.
