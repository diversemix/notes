## Daily Workflow

**Morning (5 min)**
1. `today` - Opens with carried-over tasks
2. Set Primary Focus
3. Review tasks

**During Work**
- Use `context` after interruptions
- Use `note-quick "text"` for captures
- Use `inbox` for longer thoughts

**End of Day (5 min)**
1. `today`
2. Mark completed tasks [x]
3. Add daily reflection
4. Delete irrelevant tasks
5. Close (incomplete tasks auto-carry to tomorrow)

## What Makes This Different from Logseq

| Feature | Logseq | This System |
|---------|--------|-------------|
| Format | Proprietary/Markdown | Plain Markdown |
| Editor | Electron app | Your Neovim setup |
| Task carry-over | Manual | Automatic |
| Speed | App startup lag | Instant (shell commands) |
| Customization | Limited | Complete (it's your code) |
| Graph view | Built-in | Manual (use tags/links) |
| Version control | Extra setup | Just git |
| Keyboard-first | Mostly | 100% |

## Recommended Next Steps

1. **Read INSTALLATION.md** - Get everything set up
2. **Print QUICK-REFERENCE.md** - Keep it visible while learning
3. **Read notes-workflow-guide.md** - Understand the workflows
4. **Start simple** - Just use `today` and `context` for the first week
5. **Add gradually** - Add wiki pages and projects as needed

## Advanced Setup (Optional)

### Add Telescope for Better Search
```lua
-- Add to your Neovim plugin manager
{
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' }
}
```

### Add fzf for Better Command Line Search
```bash
brew install fzf  # macOS
# or
apt install fzf   # Linux
```

### Auto-run Context on Directory Change
```bash
# Add to ~/.zshrc
cd() {
  builtin cd "$@" && [ -d ~/notes ] && context 2>/dev/null
}
```

### Git Integration
```bash
cd ~/notes
git init
echo ".DS_Store" > .gitignore
git add .
git commit -m "Initial notes setup"
```

## Customization Ideas

- Edit templates in `~/notes/templates/`
- Add custom shell functions to `notes-functions.sh`
- Customize Neovim keybindings in `notes-nvim.lua`
- Add custom Telescope pickers
- Create project-specific note directories
- Add automation with cron or shell hooks

## Philosophy

This system is built on three insights:

1. **Executive function challenges are working memory challenges**
   Solution: Externalize everything. Trust the system, not your brain.

2. **Friction kills habit formation**
   Solution: Commands are short. Templates are automatic. Everything is fast.

3. **Continuity is more important than perfect organization**
   Solution: Tasks carry automatically. Context is one command away. You can always find things with search.

## Support

- Check `INSTALLATION.md` for setup issues
- Check `QUICK-REFERENCE.md` for command syntax
- Check `notes-workflow-guide.md` for workflow questions
- Customize freely - it's your system!

## License

MIT - Use it, modify it, make it yours.

---

Built for engineers who need external memory, automatic continuity, and zero-friction note-taking.
