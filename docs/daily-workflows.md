# Daily Workflows

Practical workflows and patterns for using the notes system throughout your day.

## Morning Routine (5 minutes)

```bash
# 1. Open today's note (automatically carries over yesterday's incomplete tasks)
today

# 2. Review what was carried over and set primary focus
# Edit the "Primary Focus" section - choose ONE thing that matters most
```

**Why this works**: Starting with carried-over tasks removes the "where was I?" problem. Having a single primary focus reduces overwhelm.

## During Work Hours

### Starting Work or After a Break

```bash
# Quick context reminder without opening files
context
```

This shows:
- Your primary focus for the day
- Your active tasks
- Current links and references

**Why this works**: Eliminates the "what was I doing?" moment after interruptions.

### Quick Capture (When Something Comes Up)

```bash
# Add a note without opening editor
nquick "idea for improving the auth flow"

# For longer captures
inbox
```

**Why this works**: Capture thoughts immediately without losing focus. Process them later during a dedicated time.

### When Switching Tasks

1. Check off completed task: Open with `today`, toggle with `<leader>nx` in Neovim
2. Run `context` to see what's next
3. Leave a breadcrumb: `nquick "Paused at: writing tests for user auth"`

**Why this works**: Creates breadcrumbs for yourself. When you return, you know exactly where you left off.

## End of Day (5 minutes)

```bash
# 1. Review today
today

# 2. Check off completed tasks (mark [x])
# 3. Add anything to daily reflection
# 4. Remove tasks that are no longer relevant
# 5. Tomorrow's note will automatically carry over anything still incomplete
```

**Important**: Don't carry over tasks manually - it happens automatically when you run `today` tomorrow.

## Weekly Review (15 minutes)

### Sunday or Friday

```bash
# See the past week's work
nweek

# Review:
# - What patterns emerge?
# - What tasks keep getting carried over? (may need to break down or delegate)
# - What went well?
```

## Common Workflows

### Start a New Project

```bash
area my-new-project
# Fill in objective, next actions
# Link from today's note: [[areas/my-new-project]]
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

### Processing Inbox

Do this daily or every few days:

```bash
# 1. Open inbox
inbox

# 2. For each item, decide:
#    - Add to today's tasks if actionable now
#    - Move to wiki/area if it's reference material
#    - Delete if no longer relevant

# 3. Clear processed items from inbox
```

## Advanced Patterns

### Time-Blocking in Daily Notes

```markdown
## ✅ Today's Tasks
- [ ] 9:00-10:30 - Focus block: [[areas/auth-refactor]] tests
- [ ] 10:30-11:00 - Code review
- [ ] 14:00-16:00 - Focus block: [[areas/database-optimization]]
```

### Energy Tracking

Use the daily reflection to track energy:

```markdown
**Energy level:** 7/10
**What affected it:** Good sleep, morning walk
```

Over time, patterns emerge about when you're most productive.

### Friday Brain Dump

Every Friday, run `inbox` and dump everything on your mind:
- Things you want to learn
- Projects you're thinking about
- Ideas that keep popping up

Process during the weekend or Monday morning.

### Project "Current State" Section

In area files, maintain a "Current State" section at the top:

```markdown
## Current State
**Last worked on:** 2025-11-19
**Currently:** Writing integration tests for auth middleware
**Next up:** Add error handling tests
**Blocked by:** None
```

When you return to a project after days/weeks, this tells you exactly where you are.

## Handling Specific Scenarios

### Scenario: Multiple Urgent Things

1. Run `context` - stick with your primary focus
2. Add urgent items to today's tasks
3. Only switch if truly critical
4. Use `nquick` to capture other thoughts

### Scenario: Task Keeps Getting Carried Over (3+ days)

If a task appears in 3+ daily notes:

**Option 1: Break it down**
```bash
# Instead of: "- [ ] Refactor authentication system"
# Try: "- [ ] Map out auth system components (30 min)"
```

**Option 2: Move to an area**
```bash
area auth-refactor
# Add specific next actions to the area file
# Pull individual actions into daily notes as needed
```

**Option 3: Delete it**
If you haven't done it in a week, you probably don't need to.

### Scenario: Overwhelmed by Carried Tasks

This means tasks are too big or too numerous:

1. Open today's note
2. Pick ONE task to keep for today
3. Move others to area files or delete
4. Simplify remaining task if needed

### Scenario: Forgot to Check Notes

Make `context` automatic:

```bash
# Add to ~/.zprofile
cd() {
  builtin cd "$@" && [ -d ~/notes ] && context 2>/dev/null
}
```

### Scenario: Too Many Wiki Pages, Can't Find Things

1. Use search, not memory: `nfind <term>`
2. Use tags: `ntags <tag>`
3. Trust backlinks: `<leader>nb` in Neovim
4. Clean up occasionally: move old stuff to `archive/`

## Weekly Patterns

### Monday Morning

```bash
today                    # Fresh week, carried over from Friday
# Set weekly primary focus
# Review areas: which projects need attention this week?
```

### Friday Afternoon

```bash
today
# Complete reflection
# Brain dump to inbox
nweek                    # Review the week
```

## Integration Tips

### With Git

```bash
# At end of day or when significant work done
npush   # Pushes notes to remote

# When starting on new machine
npull   # Pulls latest notes
```

### With Time Management

The system complements time-blocking:

1. Time-block in calendar
2. Add those blocks to today's tasks
3. Use `context` to see current block
4. Check off as you complete

### With Project Management Tools

Use notes for personal context, external tools for team coordination:

- **Notes**: Your internal state, what you're thinking, breadcrumbs
- **External tools**: Team-visible tasks, deadlines, dependencies

Link between them: `- [ ] Review PR #234 (see [[areas/auth-refactor]])`

## Remember

- **Write everything down**: Your notes are your external memory
- **Use context often**: Especially after breaks or interruptions
- **Trust the system**: Tasks carry automatically, just mark them done
- **Primary Focus**: One thing. Always.
- **Low friction**: Commands are short by design. Use them constantly.

---

Print this and keep it visible until workflows become muscle memory.
