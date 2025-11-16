# User Guide

This guide covers daily workflows and executive function support strategies.

## Executive Function Support Strategies

This system is designed to help with:

- **Context switching**: Quick commands to see what you're working on
- **Task continuity**: Automatic task carry-over between days
- **Reduced friction**: Templates and automation minimize decision fatigue
- **External memory**: Everything written down, nothing held in working memory

## Daily Workflow

### Morning Routine (5 minutes)

```bash
# 1. Open today's note (automatically carries over yesterday's incomplete tasks)
today

# 2. Review what was carried over and set primary focus
# Edit the "Primary Focus" section - choose ONE thing that matters most
```

**Why this helps**: Starting with carried-over tasks removes the "where was I?" problem. Having a single primary focus reduces overwhelm.

### During the Day

#### When starting work or after a break

```bash
# Quick context reminder without opening files
context
```

This shows:
- Your primary focus for the day
- Your active tasks
- What you're currently working on

**Why this helps**: Eliminates the "what was I doing?" moment after interruptions. You don't need to search through notes or hold context in memory.

#### Quick capture (when something comes up)

```bash
# Add a note without opening editor
nquick "idea for improving the auth flow"
```

**Why this helps**: Capture thoughts immediately without losing focus. Process them later during a dedicated time.

#### When switching tasks

1. Check off completed task in today's note: Open with `today` and toggle with `<leader>nx` in Neovim (or manually change `[ ]` to `[x]`)
2. Run `context` to see what's next
3. Add a quick note about what you were doing: `nquick "Paused at: writing tests for user auth"`

**Why this helps**: Creates breadcrumbs for yourself. When you return, you know exactly where you left off.

### End of Day (5 minutes)

```bash
# 1. Review today
today

# 2. Check off completed tasks (mark [x])
# 3. Add anything to daily reflection
# 4. Remove tasks that are no longer relevant
# 5. Tomorrow's note will automatically carry over anything still incomplete
```

**Important**: Don't carry over tasks manually - it happens automatically when you run `today` tomorrow.

### Weekly Review (15 minutes, Sunday/Friday)

```bash
# See the past week's work
nweek

# Review:
# - What patterns emerge?
# - What tasks keep getting carried over? (may need to break down or delegate)
# - What went well?
```

## Task Management Strategy

### The Three States of Tasks

1. **Daily Thoughts**: Recorded at the top of daily notes
2. **Today's Tasks** (in daily note): What you're doing today
3. **Project Tasks** (in project files): Tracked by project, pulled into daily as needed

### Handling Tasks That Keep Getting Carried Over

If a task appears in 3+ daily notes:

```bash
# Option 1: Break it down
# Instead of: "- [ ] Refactor authentication system"
# Try: "- [ ] Map out auth system components (30 min)"

# Option 2: Move to a project
project auth-refactor
# Then add specific next actions to the project file
# Pull individual actions into daily notes as needed

# Option 3: Delete it
# If you haven't done it in a week, you probably don't need to
```

**Why this helps**: Chronic carry-over creates guilt and clutter. Address it systematically.

## Link and Wiki Strategy

### When to Create a Wiki Page

Create a wiki page when you have:
- Reference information you'll need again
- Complex topics that need structure
- Knowledge worth keeping separate from daily notes

```bash
# Create or open a wiki page
wiki fastapi-testing-patterns
```

### Linking Strategy

In any note, create links with `[[page-name]]`:
- In Neovim: Press M-Enter on a link to follow it (creates the page with correct template)
- Use path-based links for specific types: `[[wiki/projects/name]]`, `[[wiki/areas/name]]`, etc.
- Or use `<leader>nl` to search and insert a link

**Why this helps**: Your notes become an interconnected knowledge base. When you're working on something, you can quickly jump to related information. The system automatically uses the right template based on the path.

### Finding Information Later

```bash
# Search by content
nfind "database migration"

# Search by tag
ntags project

# Find what links to current page
# (in Neovim: <leader>nb)
```

## Context Switching Support

### Scenario: You're working and get interrupted

1. Before handling interruption:
   ```bash
   nquick "Paused: implementing user validation, next: add email check"
   ```

2. Handle the interruption

3. When returning:
   ```bash
   context  # See what you were doing
   today    # Jump back to your note to see the pause note
   ```

### Scenario: You have good focus but forget what's next

Run `context` regularly. Set up a terminal alias or keybinding to make it one keystroke.

Consider a simple reminder:
```bash
# Add to your shell profile
# Shows context every time you change to project directory
cd() {
  builtin cd "$@" && [ -d ~/notes ] && context 2>/dev/null
}
```

### Scenario: End of day, brain is tired

Don't worry about perfect task management. Just:

1. Run `today`
2. Check off what you did
3. Delete what's irrelevant
4. Close it

Tomorrow's note will handle the rest automatically.

## Advanced Tips

### 1. Time-blocking in Daily Notes

```markdown
## ✅ Today's Tasks
- [ ] 9:00-10:30 - Focus block: [[auth-refactor]] tests
- [ ] 10:30-11:00 - Code review
- [ ] 14:00-16:00 - Focus block: [[database-optimization]]
```

### 2. Energy Tracking

Use the daily reflection to track energy:
```markdown
**Energy level:** 7/10
**What affected it:** Good sleep, morning walk
```

Over time, patterns emerge about when you're most productive.

### 3. Friday Brain Dump

Every Friday, run `inbox` and dump everything on your mind:
- Things you want to learn
- Projects you're thinking about
- Ideas that keep popping up

Process during the weekend or Monday morning.

### 4. Project "Current State" Section

In project files, maintain a "Current State" section at the top:
```markdown
## Current State
**Last worked on:** 2025-11-08
**Currently:** Writing integration tests for auth middleware
**Next up:** Add error handling tests
**Blocked by:** None
```

When you return to a project after days/weeks, this tells you exactly where you are.

## Key Principles

1. **Write everything down immediately**: Your notes are your external memory
2. **Single source of truth**: Today's daily note is where active work happens
3. **Low friction**: Commands are short, templates handle structure
4. **Automatic continuity**: Tasks carry over without manual work
5. **Context on demand**: Run `context` whenever you need orientation
6. **Regular checkpoints**: Daily reflections and weekly reviews keep you calibrated

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

### When Interrupted

```bash
nquick "Paused at: [what you were doing]"
# Handle interruption
context  # Resume work
```

### Emergency: "Where was I?"

```bash
context   # Always start here
today     # See today's work
nrecent   # Check recent files
```

## Troubleshooting Common Issues

### "I open my daily note and feel overwhelmed by carried-over tasks"

This means tasks are too big or too numerous. Archive to a project file or delete.

### "I forget to check my notes"

Make `context` part of your terminal setup. Run it automatically when you start work.

### "I'm not sure what to work on next"

Look at your Primary Focus. That's always the answer. Everything else is secondary.

### "I have tasks in multiple places"

Daily note is for today only. Projects are for reference. Move tasks between them as needed.

### "Too many wiki pages, can't find things"

Use tags liberally and search with `nfind`. Trust the search, not your memory.

## Advanced Customization

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

### Custom Templates

Edit templates in `~/notes/templates/` to match your workflow.

---

The system works best when you trust it and use it consistently. Start simple with just `today` and `context`, then add more features as they become useful.
