# User Guide

Understanding the system's philosophy and how it supports executive function.

## Executive Function Support Strategies

This system is designed to help with:

- **Context switching**: Quick commands to see what you're working on
- **Task continuity**: Automatic task carry-over between days
- **Reduced friction**: Templates and automation minimize decision fatigue
- **External memory**: Everything written down, nothing held in working memory

### How It Addresses Executive Function Challenges

#### Working Memory Overload

**Problem**: Trying to hold too much in your head leads to forgetting, anxiety, and mental fatigue.

**Solution**: The system externalizes everything:
- Tasks carry forward automatically
- `context` command shows current work state
- All information lives in files, not in your brain

#### Context Switching

**Problem**: After an interruption, it takes 15-23 minutes to fully re-engage with complex work.

**Solution**:
- `context` shows exactly what you were doing
- `nquick "Paused at: X"` creates breadcrumbs
- Today's note is always one command away

#### Task Initiation

**Problem**: Getting started is hard when facing overwhelming task lists or unclear next actions.

**Solution**:
- Primary Focus reduces decisions to ONE thing
- Tasks are concrete and actionable
- Templates remove the "blank page" problem

#### Follow-Through

**Problem**: Tasks get lost, forgotten, or slip through the cracks.

**Solution**:
- Automatic carry-over ensures nothing is forgotten
- You only manage today's tasks
- System handles continuity for you

## Core Principles

### 1. Write Everything Down Immediately

Your notes are your external memory. The moment something enters your mind:
- Quick thought? → `nquick "thought"`
- Longer idea? → `inbox`
- Task for later? → Add to today's note

**Why**: Trying to remember things causes cognitive load and anxiety.

### 2. Single Source of Truth

Today's daily note is where active work happens. Everything else is reference.

**Why**: Multiple lists create confusion and overhead. One place = one decision.

### 3. Automatic Continuity

Tasks carry forward automatically. You just mark what's done.

**Why**: Manual carry-over creates friction and often gets skipped.

### 4. Context On Demand

Run `context` whenever you need orientation. Make it muscle memory.

**Why**: Reduces the cognitive cost of "getting back into it" after breaks.

### 5. Low Friction

Commands are short. Templates handle structure. Everything is fast.

**Why**: Friction kills habit formation. The system must be easier than not using it.

### 6. Regular Checkpoints

Daily reflections and weekly reviews keep you calibrated without becoming burdensome.

**Why**: Reflection creates learning, but only if it's lightweight enough to do consistently.

## Task Management Philosophy

### The Three States of Tasks

1. **Inbox thoughts**: Quick captures, unprocessed
2. **Today's tasks**: What you're doing today (in daily note)
3. **Area tasks**: Tracked by project/area, pulled into daily as needed

### When to Use Each

**Inbox**: Brain dump, interruptions, "I'll think about this later"

**Today's tasks**: Concrete actions for today. Should be 3-7 items maximum.

**Area tasks**: Ongoing project next actions. Pull into daily notes as capacity allows.

### Handling Chronic Carry-Over

If a task appears in 3+ daily notes, it needs attention:

**Option 1: Break it down**
- Big tasks are overwhelming
- Make it smaller and more concrete
- "Map out auth components (30 min)" vs "Refactor auth"

**Option 2: Move it to an area**
- Some things aren't today-tasks
- Create/update an area file
- Track project progress there
- Pull specific actions into daily as needed

**Option 3: Delete it**
- If you haven't done it in a week, be honest
- Is it actually important?
- Decision to not do something is valid

**Why this matters**: Chronic carry-over creates guilt and reduces trust in the system.

## Information Architecture

### Wiki Pages

**Use for**: Knowledge, references, how-tos, learning notes

**Characteristics**:
- Timeless information
- You'll refer back to it
- Builds your knowledge base

**Examples**:
- `wiki vim-tips`
- `wiki python-async-patterns`
- `wiki meeting-notes-format`

**Separation of Concerns**: Break large topics into separate wiki pages by concern. See [Organizing by Concerns](#organizing-by-concerns) below.

### Projects

**Use for**: Time-bounded initiatives with specific objectives and end states

**Characteristics**:
- Has a clear objective and completion criteria
- Time-bounded (weeks to months)
- Multiple next actions that work toward an outcome
- Active tracking of progress

**Examples**:
- `project auth-refactor`
- `project api-v2-migration`
- `project learning-rust`

### Areas

**Use for**: Ongoing responsibilities with no end date

**Characteristics**:
- Time-unbounded (ongoing indefinitely)
- Standards to maintain rather than goals to achieve
- Continuous attention needed
- No clear "done" state

**Examples**:
- `area backend-development`
- `area team-mentoring`
- `area system-maintenance`

### Daily Notes

**Use for**: Everything happening today

**Characteristics**:
- Today's focus
- Today's tasks
- Today's thoughts and reflections
- Links to relevant wiki/area pages

**Don't use for**:
- Long-term information
- Things you'll need to find later
- Knowledge building

### Inbox

**Use for**: Quick captures that need processing later

**Process regularly**: Daily or every few days, move items to appropriate places.

## Linking Strategy

### When to Link

Create `[[links]]` when:
- You reference another note
- You want to build connections
- Future you needs to find related information

### Link Patterns

```markdown
# From daily notes
Today's note → [[projects/my-project]]     # Link to a project
Today's note → [[areas/backend-dev]]       # Link to an area
Today's note → [[wiki/restic]]             # Link to knowledge

# From projects/areas
Project note → [[wiki/deployment-guide]]   # Link to knowledge reference
Area note → [[wiki/best-practices]]        # Link to knowledge reference

# Between wiki pages
Wiki page → [[other-wiki-page]]            # Cross-reference knowledge
```

**Pattern: Use area notes as hubs.** Area notes map to all relevant information for an ongoing responsibility. See [Example Area as Hub](#example-area-as-hub) below.

### Backlinks

Use `<leader>nb` in Neovim to see what links to current page.

**Why it matters**: Backlinks reveal connections you might have forgotten.

## Organizing by Concerns

When creating notes, especially wiki pages, break large topics into **separate concerns** rather than creating one massive file. Each concern should address a distinct aspect of the topic.

### What is a "Concern"?

A concern is a distinct aspect, purpose, or perspective on a topic that can be understood independently. Good separation makes each page:
- **Focused**: Addresses one aspect clearly
- **Independently useful**: Can be read and understood on its own
- **Linkable**: Others can reference just what they need
- **Maintainable**: Updates don't require navigating unrelated content

### Example: Home Data Management

Instead of one large file containing everything, separate into focused concerns and create an **area note as a hub** to map them all:

**Separated concerns (wiki pages):**
```
[[wiki/home-data-inventory]]       ← CONCERN 1: What exists
[[wiki/network-topology]]          ← CONCERN 2: Where it lives
[[wiki/backup-strategy]]           ← CONCERN 3: How to protect
[[wiki/restic-guide]]              ← CONCERN 4: Tool reference
[[wiki/rclone-guide]]              ← CONCERN 5: Tool reference
[[wiki/home-data-photos]]          ← CONCERN 6: Special case
[[wiki/disaster-recovery-plan]]    ← CONCERN 7: Procedures
```

**Area note as hub** (`area home-backup`):
```markdown
# Home Backup

## Current State
Everything is backed up. Photos need optimization.

## Active Work
[[projects/backup-system-2025]] - Setting up automated system

## Documentation
- Strategy: [[wiki/backup-strategy]]
- What's backed up: [[wiki/home-data-inventory]]
- Network layout: [[wiki/network-topology]]
- Photos workflow: [[wiki/home-data-photos]]
- Recovery: [[wiki/disaster-recovery-plan]]

## Tools
- [[wiki/restic-guide]]
- [[wiki/rclone-guide]]

## Next Review
2025-12-01 - Quarterly backup verification

---
Created: 2025-01-15
Tags: #infrastructure #backup
```

The area note provides a **map** to all related information while each wiki page remains independently searchable and maintainable.

### How to Identify Separate Concerns

Ask yourself:

1. **Different audiences?** → Separate pages
   - Developers need different info than users

2. **Different purposes?** → Separate pages
   - What vs How vs Why are different concerns

3. **Different timescales?** → Separate pages
   - Current state vs historical context vs future plans

4. **Different types of information?** → Separate pages
   - Conceptual vs procedural vs reference
   - Inventory vs topology vs process

5. **Could someone need just this part?** → Separate page
   - If yes, make it independently accessible

### Example: Infrastructure Documentation

**Poor organization (one big file):**
```
wiki/infrastructure.md
  - Server inventory
  - Network diagram
  - Deployment process
  - Monitoring setup
  - Disaster recovery
  - Tool configs
  - Troubleshooting
```

**Good organization (separated concerns):**
```
[[wiki/infrastructure]]         ← Overview and links
[[wiki/server-inventory]]       ← What we have
[[wiki/network-topology]]       ← How it connects
[[wiki/deployment-process]]     ← How to deploy
[[wiki/monitoring-stack]]       ← How we observe
[[wiki/disaster-recovery]]      ← What to do in crisis
[[wiki/prometheus]]             ← Tool reference
[[wiki/troubleshooting-infra]]  ← Common issues
```

### Connecting Concerns

Use an overview page to link related concerns:

```markdown
# Infrastructure

Overview of our infrastructure setup.

## What We Have
- [[server-inventory]] - All servers and their purposes
- [[network-topology]] - Network layout and connections

## How We Work
- [[deployment-process]] - How to deploy applications
- [[monitoring-stack]] - How we track system health

## Emergency Procedures
- [[disaster-recovery]] - What to do when things break
- [[troubleshooting-infra]] - Common issues and fixes

## Tools
- [[prometheus]] - Monitoring tool
- [[terraform]] - Infrastructure as code
```

### When NOT to Separate

Don't create separate pages for:
- Very small amounts of information (< 100 words)
- Information that's only useful together
- Concerns that always change together
- Over-abstraction (don't create pages you'll never revisit)

**Rule of thumb**: If splitting creates more confusion than clarity, keep it together.

### Benefits of Separation

1. **Better search**: Find exactly what you need
2. **Easier sharing**: Link colleagues to just the relevant part
3. **Clearer updates**: Change deployment process without touching inventory
4. **Natural knowledge graph**: Connections emerge organically
5. **Reduced cognitive load**: Each page is focused and digestible

### Example Area as Hub

Area notes work best as **maps to related information**. They track the ongoing responsibility and link to all relevant knowledge:

```markdown
# Backend Development

## Current Focus
Improving API performance and reliability.

## Active Projects
- [[projects/api-v2-migration]] - Migrating to REST v2
- [[projects/database-optimization]] - Query performance improvements

## Standards & Knowledge
- [[wiki/backend-coding-standards]]
- [[wiki/api-design-principles]]
- [[wiki/database-schema]]
- [[wiki/deployment-process]]

## Tools & Infrastructure
- [[wiki/kubernetes-setup]]
- [[wiki/monitoring-stack]]
- [[wiki/ci-cd-pipeline]]

## Common Tasks
- [[wiki/deploying-backend-service]]
- [[wiki/troubleshooting-performance]]
- [[wiki/database-migrations]]

## Team Resources
- Team members: [Internal link]
- Oncall rotation: [Link]

## Next Review
2025-02-01 - Review active projects and priorities

---
Created: 2024-01-15
Tags: #area #backend #development
```

**Why this works:**
- Area provides context: "What is this responsibility about?"
- Links to active projects: "What am I working on right now?"
- Links to knowledge: "Where do I find information?"
- Standalone wiki pages remain independently searchable
- Daily notes link to `[[areas/backend-development]]` for quick access

## Dealing with Common Challenges

### "I open my daily note and feel overwhelmed"

**Cause**: Too many carried-over tasks, or tasks too vague.

**Fix**:
1. Pick ONE task for right now
2. Move others to area files
3. Make remaining tasks concrete (30-min chunks)
4. Consider deleting tasks you've been ignoring

### "I forget to check my notes"

**Cause**: Not yet a habit, or too much friction.

**Fix**:
1. Make `context` automatic (add to shell startup)
2. Keep terminal window open with notes
3. Set reminders for first week
4. Use `<leader>nt` in Neovim instead of shell command

### "I'm not sure what to work on next"

**Cause**: Unclear primary focus or too many options.

**Fix**:
1. Look at Primary Focus in today's note
2. That's always the answer
3. If unclear, update it right now
4. Everything else is secondary

### "I have tasks scattered everywhere"

**Cause**: Using multiple systems or not processing inbox.

**Fix**:
1. Daily note = today only
2. Area notes = project tracking
3. Process inbox daily
4. Don't use other todo systems alongside this

### "Too many wiki pages, can't find things"

**Cause**: Trying to remember location instead of using search.

**Fix**:
1. Use `nfind <term>` - trust search, not memory
2. Use tags: `ntags <tag>`
3. Use backlinks: `<leader>nb`
4. Archive old/irrelevant pages occasionally

## Building the Habit

### Week 1: Just the Basics

Focus on:
- `today` every morning
- `context` after breaks
- Mark tasks complete

Don't worry about:
- Perfect organization
- Wiki pages
- Complex linking

### Week 2-3: Add Capture

Add:
- `nquick` for quick thoughts
- `inbox` for longer captures
- `yesterday` to review previous day

### Week 4+: Full System

Add:
- Wiki pages for knowledge
- Area pages for projects
- Weekly reviews with `nweek`
- Linking between notes

## Remember

**Trust the system**: Tasks carry forward. You just need to mark what's done.

**Use context constantly**: After every break, interruption, or moment of "wait, what was I doing?"

**Primary Focus is sacred**: One thing that matters most. When in doubt, work on it.

**Write everything down**: Your brain is for thinking, not storing.

**Low friction wins**: Short commands, quick captures, templates. The easier it is, the more you'll use it.

---

**Next steps:**
- [Daily Workflows](daily-workflows.md) - Practical usage patterns
- [Reference](reference.md) - Command quick reference
- [Installation](installation.md) - Setup guide
