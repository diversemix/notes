#!/bin/bash
# Notes System Functions
# Add these to your ~/.zshrc or ~/.bashrc

export NOTES_DIR="$HOME/notes"

# Core daily note functions

today() {
    local date=$(date +%Y-%m-%d)
    local file="$NOTES_DIR/daily/$date.md"

    if [ ! -f "$file" ]; then
        # Create from template
        sed "s/{{DATE}}/$date/g" "$NOTES_DIR/templates/daily.md" > "$file"

        # Carry over incomplete tasks from yesterday
        local yesterday_date=$(date -d "yesterday" +%Y-%m-%d 2>/dev/null || date -v-1d +%Y-%m-%d 2>/dev/null)
        local yesterday_file="$NOTES_DIR/daily/$yesterday_date.md"

        if [ -f "$yesterday_file" ]; then
            # Extract incomplete tasks and add to carried over section
            local carried_tasks=$(grep "^- \[ \]" "$yesterday_file" || true)

            if [ -n "$carried_tasks" ]; then
                tmpfile=$(mktemp)
                tmpout=$(mktemp)
                echo "$carried_tasks" > "$tmpfile"
                # Insert carried tasks after the "## 📋 Carried Over" line
                sed "/^## 📋 Carried Over/r $tmpfile" "$file" > "$tmpout"
                mv "$tmpout" "$file"
                rm -f "$tmpfile"
                rm -f "$tmpout"
            fi
        fi
    fi

    nvim "$file"
}

yesterday() {
    local date=$(date -d "yesterday" +%Y-%m-%d 2>/dev/null || date -v-1d +%Y-%m-%d 2>/dev/null)
    local file="$NOTES_DIR/daily/$date.md"
    
    if [ -f "$file" ]; then
        nvim "$file"
    else
        echo "No note found for yesterday ($date)"
    fi
}

# Wiki and project management
wiki() {
    local name="$1"
    if [ -z "$name" ]; then
        echo "Usage: wiki <page-name>"
        echo "Example: wiki python-testing"
        return 1
    fi

    # Convert to slug format
    local slug=$(echo "$name" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
    local file="$NOTES_DIR/wiki/$slug.md"

    if [ ! -f "$file" ]; then
        local title=$(echo "$name" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')
        local date=$(date +%Y-%m-%d)
        sed -e "s/{{TITLE}}/$title/g" -e "s/{{DATE}}/$date/g" "$NOTES_DIR/templates/wiki.md" > "$file"
    fi

    nvim "$file"
}


area() {
    local name="$1"
    if [ -z "$name" ]; then
        echo "Usage: area <area-name>"
        return 1
    fi

    local slug=$(echo "$name" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
    local file="$NOTES_DIR/wiki/areas/$slug.md"

    if [ ! -f "$file" ]; then
        local title=$(echo "$name" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')
        local date=$(date +%Y-%m-%d)
        sed -e "s/{{TITLE}}/$title/g" -e "s/{{DATE}}/$date/g" "$NOTES_DIR/templates/area.md" > "$file"
    fi

    nvim "$file"
}


resource() {
    local name="$1"
    if [ -z "$name" ]; then
        echo "Usage: resource <resource-name>"
        return 1
    fi

    local slug=$(echo "$name" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
    local file="$NOTES_DIR/wiki/resources/$slug.md"

    if [ ! -f "$file" ]; then
        local title=$(echo "$name" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')
        local date=$(date +%Y-%m-%d)
        sed -e "s/{{TITLE}}/$title/g" -e "s/{{DATE}}/$date/g" "$NOTES_DIR/templates/resource.md" > "$file"
    fi

    nvim "$file"
}


project() {
    local name="$1"
    if [ -z "$name" ]; then
        echo "Usage: project <project-name>"
        return 1
    fi

    local slug=$(echo "$name" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
    local file="$NOTES_DIR/wiki/projects/$slug.md"

    if [ ! -f "$file" ]; then
        local title=$(echo "$name" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')
        local date=$(date +%Y-%m-%d)
        sed -e "s/{{TITLE}}/$title/g" -e "s/{{DATE}}/$date/g" "$NOTES_DIR/templates/project.md" > "$file"
    fi

    nvim "$file"
}

# Quick capture to inbox
inbox() {
    nvim "$NOTES_DIR/inbox/inbox.md"
}

# Search functions
nfind() {
    if [ -z "$1" ]; then
        # Interactive search with fzf/telescope (if available)
        if command -v fzf &> /dev/null; then
            local file=$(find "$NOTES_DIR" -type f -name "*.md" | fzf --preview 'cat {}')
            [ -n "$file" ] && nvim "$file"
        else
            echo "Usage: nfind <search-term>"
            echo "Or install fzf for interactive search"
        fi
    else
        # Grep search
        grep -r -n "$1" "$NOTES_DIR" --include="*.md" --color=always | less -R
    fi
}

# Find notes by tag
ntags() {
    if [ -z "$1" ]; then
        echo "Usage: ntags <tag>"
        echo "Example: ntags project"
        return 1
    fi

    grep -r -l "#$1" "$NOTES_DIR" --include="*.md"
}

# List all tags in use
ntaglist() {
    grep -r -h "#[a-zA-Z0-9_-]\+" "$NOTES_DIR" --include="*.md" -o | sort | uniq -c | sort -rn
}

# Recent notes
nrecent() {
    local count=${1:-10}
    find "$NOTES_DIR" -type f -name "*.md" -printf "%T@ %p\n" | sort -rn | head -n "$count" | cut -d' ' -f2-
}

# View incomplete tasks across all notes
ntasks() {
    echo "=== Incomplete Tasks ==="
    grep -r "^- \[ \]" "$NOTES_DIR" --include="*.md" -H | sed "s|$NOTES_DIR/||g"
}

# View today's tasks specifically
tasks-today() {
    local date=$(date +%Y-%m-%d)
    local file="$NOTES_DIR/daily/$date.md"

    if [ -f "$file" ]; then
        echo "=== Tasks for $date ==="
        grep "^- \[ \]" "$file" || echo "No incomplete tasks!"
    else
        echo "No daily note for today yet. Run 'today' to create one."
    fi
}

# Manually carry specific tasks to today
carry-task() {
    local date=$(date +%Y-%m-%d)
    local file="$NOTES_DIR/daily/$date.md"

    if [ ! -f "$file" ]; then
        echo "Creating today's note first..."
        today
    fi

    if [ -z "$1" ]; then
        echo "Usage: carry-task '<task description>'"
        echo "Example: carry-task 'Review PR for authentication'"
        return 1
    fi

    # Add task to carried over section
    sed -i.bak "/^## 📋 Carried Over/a\\
- [ ] $1" "$file"
    rm "$file.bak"
    echo "Task added to today's carried over section"
}

# Weekly review - see all daily notes from the past week
nweek() {
    echo "=== Daily Notes from Past Week ==="
    for i in {0..6}; do
        local date=$(date -d "$i days ago" +%Y-%m-%d 2>/dev/null || date -v-${i}d +%Y-%m-%d 2>/dev/null)
        local file="$NOTES_DIR/daily/$date.md"
        if [ -f "$file" ]; then
            echo ""
            echo "--- $date ---"
            # Show primary focus and completed tasks
            sed -n '/^## 🎯 Primary Focus/,/^## /p' "$file" | head -n -1
            echo ""
            grep "^- \[x\]" "$file" 2>/dev/null && echo "" || echo "(no completed tasks)"
        fi
    done
}

# Helper for context switching - show what you were working on
context() {
    local date=$(date +%Y-%m-%d)
    local file="$NOTES_DIR/daily/$date.md"

    if [ -f "$file" ]; then
        echo "=== Today's Context ==="
        echo ""
        echo "📍 PRIMARY FOCUS:"
        sed -n '/^## 🎯 Primary Focus/,/^## /p' "$file" | grep -v "^#" | grep -v "^$" | head -n 5
        echo ""
        echo "📋 ACTIVE TASKS:"
        grep "^- \[ \]" "$file" | head -n 5 || echo "No incomplete tasks"
        echo ""
        echo "🔗 CURRENT LINKS:"
        sed -n '/^## 🔗 Links/,/^## /p' "$file" | grep -v "^#" | grep -v "^$" || echo "No links yet"
    else
        echo "No daily note for today. Run 'today' to create one."
    fi
}

# Quick note append without opening editor
nquick() {
    if [ -z "$1" ]; then
        echo "Usage: note-quick '<your note>'"
        return 1
    fi

    local date=$(date +%Y-%m-%d)
    local time=$(date +%H:%M)
    local file="$NOTES_DIR/daily/$date.md"

    if [ ! -f "$file" ]; then
        today
    fi

    # Append to notes section
    echo "- [$time] $1" >> "$file"
    echo "Note added to today's log"
}

# Aliases for convenience
alias n='nfind'
alias nt='ntasks'
alias tt='tasks-today'
alias nw='nweek'
alias cx='context'
alias nq='nquick'

echo "Notes functions loaded. Key commands:"
echo "       today         - Open today's daily note (auto-carries tasks)"
echo "       yesterday     - Open yesterday's note"
echo "       inbox         - Quick capture"
echo "       wiki <name>   - Create/open wiki page (specific topic)"
echo "       project <n>   - Create/open project (time bounded)"
echo "       area <n>      - Create/open area (time unbounded)"
echo "       resource <n>  - Create/open resource (reference material)"
echo "  (cx) context       - Show today's focus and active tasks"
echo "  (nt) ntasks        - View all incomplete tasks"
echo "  (nf) nfind <term>  - Search notes"
echo "  (nw) nweek         - Review past week"
echo "  (nq) nquick        - Append quick note to today's log"
echo
