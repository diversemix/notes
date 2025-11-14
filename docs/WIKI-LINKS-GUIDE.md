# Wiki Links Guide

## How Links Work

The notes system supports two types of wiki links:

### 1. Simple Links (Wiki Root)
For pages in the main `wiki/` directory:

```markdown
[[my-page]]
```

This resolves to: `~/notes/wiki/my-page.md`

### 2. Path-Based Links (Subdirectories)
For pages in subdirectories like `projects/`, `areas/`, or `resources/`:

```markdown
[[wiki/projects/my-project]]
[[wiki/areas/backend-development]]
[[wiki/resources/fastapi-tips]]
```

These resolve relative to your notes directory:
- `[[wiki/projects/my-project]]` → `~/notes/wiki/projects/my-project.md`
- `[[wiki/areas/backend-development]]` → `~/notes/wiki/areas/backend-development.md`

### 3. Daily Notes Links
Link to specific daily notes:

```markdown
[[daily/2025-11-14]]
```

This resolves to: `~/notes/daily/2025-11-14.md`

## Using `<leader>nl` to Insert Links

When you use `<leader>nl` to insert a link:

1. Telescope shows all `.md` files in your notes directory
2. Select any file (even in subdirectories)
3. The link is inserted with the **full relative path**

**Example:**
- You select `wiki/projects/auth-refactor.md`
- Link inserted: `[[wiki/projects/auth-refactor]]`
- Pressing Enter on this link opens the correct file

## Creating New Links

### Option 1: Type the Link Manually

Just type the link with the path:

```markdown
I'm working on [[wiki/projects/new-feature]]
```

When you press Enter on it:
- If the file doesn't exist, it's created automatically
- Parent directories are created if needed
- Opens in Neovim for editing

### Option 2: Use Insert Link Command

Press `<leader>nl` and select from existing files.

## Link Patterns

### In Daily Notes
```markdown
# 2025-11-14

## 🎯 Primary Focus
Working on [[wiki/projects/user-authentication]]

## ✅ Today's Tasks
- [ ] Review [[wiki/resources/security-best-practices]]
- [ ] Update [[wiki/projects/api-redesign]]

## 🔗 Links
- [[wiki/projects/user-authentication]]
- [[wiki/areas/security]]
```

### In Project Files
```markdown
# User Authentication Project

## Overview
This project implements JWT-based auth as described in 
[[wiki/resources/jwt-implementation-guide]].

## Related Projects
- [[wiki/projects/api-redesign]]
- [[wiki/projects/database-migration]]

## Resources
- [[wiki/resources/fastapi-security]]
- [[wiki/resources/postgresql-rbac]]
```

### In Wiki Pages
```markdown
# FastAPI Security Best Practices

## Related
- Projects using this: [[wiki/projects/user-authentication]]
- See also: [[wiki/resources/jwt-implementation-guide]]
- Daily notes: [[daily/2025-11-08]]
```

## Following Links

### In Normal Mode
- **Press Enter** on a `[[link]]` to follow it
- **Press Ctrl+]** also follows links (vim-style)
- **Press Ctrl+O** to go back (vim's jump list)

### Link Navigation Tips

Create a "hub" pattern for related information:

```markdown
# User Authentication (Hub)

## Active Work
- [[wiki/projects/auth-refactor]] - Current refactoring effort
- [[daily/2025-11-14]] - Today's auth work

## Reference
- [[wiki/resources/jwt-best-practices]]
- [[wiki/resources/oauth2-flow]]

## Related Areas
- [[wiki/areas/security]]
- [[wiki/areas/api-development]]
```

## Backlinks

To see what pages link to your current page:

```vim
<leader>nb
```

This opens Telescope showing all files that contain a link to the current page.

## Link Organization Strategy

### Use Paths for Structure

```
wiki/
├── projects/          # Active projects
│   ├── auth-refactor.md
│   └── api-v2.md
├── areas/             # Ongoing responsibilities
│   ├── backend.md
│   └── security.md
└── resources/         # Reference material
    ├── fastapi-patterns.md
    └── sql-optimization.md
```

### Link Between Categories

**From Daily Note:**
```markdown
Working on [[wiki/projects/auth-refactor]]
Need to review [[wiki/resources/jwt-security]]
```

**From Project:**
```markdown
# Auth Refactor Project
Area: [[wiki/areas/security]]
Resources: [[wiki/resources/jwt-security]], [[wiki/resources/fastapi-middleware]]
```

**From Resource:**
```markdown
# JWT Security Guide
Used in: [[wiki/projects/auth-refactor]], [[wiki/projects/api-v2]]
Related: [[wiki/resources/oauth2-flow]]
```

## Common Link Patterns

### Project Template with Links
```markdown
# {{TITLE}}

## Status
**Current Phase:** Planning
**Priority:** High
**Area:** [[wiki/areas/AREA-NAME]]

## Objective

## Next Actions
- [ ] 

## Context
See: [[wiki/resources/REFERENCE]]

## Related
- Projects: [[wiki/projects/OTHER-PROJECT]]
- Daily work: [[daily/YYYY-MM-DD]]

---
Created: {{DATE}}
Tags: #project
```

### Daily Note with Project Links
```markdown
# 2025-11-14

## 🎯 Primary Focus
[[wiki/projects/auth-refactor]] - Complete JWT implementation

## ✅ Today's Tasks
- [ ] Read [[wiki/resources/jwt-best-practices]]
- [ ] Update [[wiki/projects/auth-refactor]] with findings
- [ ] Review [[wiki/areas/security]] checklist

## 🔗 Links
- [[wiki/projects/auth-refactor]]
```

## Tips

### 1. Use Consistent Naming
- Lowercase, dash-separated: `user-authentication`, not `User Authentication`
- This matches the automatic slug generation

### 2. Link Early, Link Often
Don't wait to create perfect structure. Create links as you work:
```markdown
Investigating [[wiki/resources/sqlalchemy-patterns]]
(link doesn't exist yet - will be created when needed)
```

### 3. Use Telescope for Discovery
- `<leader>nf` - Find any note quickly
- `<leader>ng` - Search content across all notes
- `<leader>nb` - Find what links here

### 4. Daily → Project → Resource Flow
Typical pattern:
1. Work in daily note: `[[wiki/projects/my-project]]`
2. Project references: `[[wiki/resources/how-to-guide]]`
3. Resource links back: "Used in [[wiki/projects/my-project]]"

### 5. Check Broken Links
If a link doesn't work:
- Check the path is correct (includes `wiki/projects/` not just the name)
- Press Enter to create it if it's missing
- Use `<leader>nl` to verify the correct path

## Troubleshooting

**Link doesn't open:**
- Check the path: `[[wiki/projects/name]]` not `[[projects/name]]`
- Make sure there's no typo in the filename
- The file might be in a different directory - use `<leader>nf` to find it

**Wrong file opens:**
- You might have two files with similar names in different directories
- Use full paths to be explicit: `[[wiki/projects/auth]]` vs `[[wiki/areas/auth]]`

**Link created in wrong location:**
- If you manually type `[[new-page]]`, it goes to `wiki/`
- For subdirectories, include the path: `[[wiki/projects/new-page]]`

## Quick Reference

```markdown
# Link Syntax
[[page-name]]                    # wiki/page-name.md
[[wiki/projects/name]]           # wiki/projects/name.md
[[wiki/areas/name]]              # wiki/areas/name.md
[[wiki/resources/name]]          # wiki/resources/name.md
[[daily/2025-11-14]]             # daily/2025-11-14.md

# Commands
<leader>nl                       # Insert link (Telescope picker)
<leader>nb                       # Show backlinks
<Enter>                          # Follow link under cursor
<Ctrl+]>                         # Also follows link
<Ctrl+O>                         # Go back (vim jumplist)
```
