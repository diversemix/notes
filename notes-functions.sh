#!/bin/bash
# Notes System Functions
# Add these to your ~/.zshrc or ~/.bashrc

export NOTES_DIR="$HOME/notes"

# Core daily note functions

# Create today's daily note file (without opening editor)
# This is used by both the bash 'today' function and the Neovim integration
create-today() {
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

    echo "$file"
}

today() {
    local file=$(create-today)
    nvim "$file"
}

# Find yesterday's (most recent) daily note file (without opening editor)
# This is used by both the bash 'yesterday' function and the Neovim integration
find-yesterday() {
    local today_date=$(date +%Y-%m-%d)
    local today_file="$NOTES_DIR/daily/$today_date.md"

    # Find the most recent daily log file (excluding today)
    local recent_file=$(ls -t "$NOTES_DIR/daily/"*.md 2>/dev/null | grep -v "$today_file" | head -n 1)

    if [ -n "$recent_file" ]; then
        echo "$recent_file"
    fi
}

yesterday() {
    local file=$(find-yesterday)

    if [ -n "$file" ]; then
        nvim "$file"
    else
        echo "No previous daily notes found"
    fi
}

# Wiki and project management

# Create a wiki page file (without opening editor)
# This is used by both the bash 'wiki' function and the Neovim integration
create-wiki() {
    local name="$1"
    if [ -z "$name" ]; then
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

    echo "$file"
}

wiki() {
    local name="$1"
    if [ -z "$name" ]; then
        echo "Usage: wiki <page-name>"
        echo "Example: wiki python-testing"
        return 1
    fi

    local file=$(create-wiki "$name")
    nvim "$file"
}

# Create a project file (without opening editor)
# This is used by both the bash 'project' function and the Neovim integration
create-project() {
    local name="$1"
    if [ -z "$name" ]; then
        return 1
    fi

    local slug=$(echo "$name" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
    local file="$NOTES_DIR/wiki/projects/$slug.md"

    if [ ! -f "$file" ]; then
        local title=$(echo "$name" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')
        local date=$(date +%Y-%m-%d)
        sed -e "s/{{TITLE}}/$title/g" -e "s/{{DATE}}/$date/g" "$NOTES_DIR/templates/project.md" > "$file"
    fi

    echo "$file"
}

project() {
    local name="$1"
    if [ -z "$name" ]; then
        echo "Usage: project <project-name>"
        return 1
    fi

    local file=$(create-project "$name")
    nvim "$file"
}

# Create an area file (without opening editor)
# This is used by both the bash 'area' function and the Neovim integration
create-area() {
    local name="$1"
    if [ -z "$name" ]; then
        return 1
    fi

    local slug=$(echo "$name" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
    local file="$NOTES_DIR/wiki/areas/$slug.md"

    if [ ! -f "$file" ]; then
        local title=$(echo "$name" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')
        local date=$(date +%Y-%m-%d)
        sed -e "s/{{TITLE}}/$title/g" -e "s/{{DATE}}/$date/g" "$NOTES_DIR/templates/area.md" > "$file"
    fi

    echo "$file"
}

area() {
    local name="$1"
    if [ -z "$name" ]; then
        echo "Usage: area <area-name>"
        return 1
    fi

    local file=$(create-area "$name")
    nvim "$file"
}

# Create a resource file (without opening editor)
# This is used by both the bash 'resource' function and the Neovim integration
create-resource() {
    local name="$1"
    if [ -z "$name" ]; then
        return 1
    fi

    local slug=$(echo "$name" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
    local file="$NOTES_DIR/wiki/resources/$slug.md"

    if [ ! -f "$file" ]; then
        local title=$(echo "$name" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')
        local date=$(date +%Y-%m-%d)
        sed -e "s/{{TITLE}}/$title/g" -e "s/{{DATE}}/$date/g" "$NOTES_DIR/templates/resource.md" > "$file"
    fi

    echo "$file"
}

resource() {
    local name="$1"
    if [ -z "$name" ]; then
        echo "Usage: resource <resource-name>"
        return 1
    fi

    local file=$(create-resource "$name")
    nvim "$file"
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
        grep -r -n "$1" "$NOTES_DIR" --include="*.md" --color=always 
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

# Helper function to convert seconds to relative time
_relative_time() {
    local seconds=$1
    local minutes=$((seconds / 60))
    local hours=$((seconds / 3600))
    local days=$((seconds / 86400))
    local weeks=$((seconds / 604800))
    local months=$((seconds / 2592000))

    if [ $seconds -lt 60 ]; then
        echo "${seconds}s ago"
    elif [ $minutes -lt 60 ]; then
        echo "${minutes}m ago"
    elif [ $hours -lt 24 ]; then
        echo "${hours}h ago"
    elif [ $days -lt 7 ]; then
        echo "${days}d ago"
    elif [ $weeks -lt 4 ]; then
        echo "${weeks}w ago"
    else
        echo "${months}mo ago"
    fi
}

# Recent notes with relative time
nrecent() {
    local count=${1:-10}
    local now=$(date +%s)

    find "$NOTES_DIR" -type f -name "*.md" | while read -r file; do
        # Get modification time (portable across Linux/macOS)
        local mtime=$(stat -f %m "$file" 2>/dev/null || stat -c %Y "$file" 2>/dev/null)
        local diff=$((now - mtime))
        local reltime=$(_relative_time $diff)
        echo "$mtime|$file|$reltime"
    done | sort -rn | head -n "$count" | while IFS='|' read -r mtime file reltime; do
        # Strip notes dir prefix for cleaner display
        local display_path=${file#$NOTES_DIR/}
        printf "%-60s %s\n" "$display_path" "$reltime"
    done
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

# Quick capture to inbox
inbox() {
    # If there is no inbox file then copy one from template
    local file="$NOTES_DIR/inbox/inbox.md"

    if [ ! -f "$file" ]; then
        cp "$NOTES_DIR/templates/inbox.md" "$file"
    fi

    local date=$(date '+%a, %d %b')
    local time=$(date +%H:%M)

    # Append to notes section
    echo -n "- $date [$time] " >> "$file"

    if [ -z "$1" ]; then
        nvim +"normal! GA" +startinsert! "$NOTES_DIR/inbox/inbox.md"
    else
        echo "$1" >> "$file"
        echo "Note added to inbox"
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

notes-help() {
    echo "       today         - Open today's daily note (auto-carries tasks)"
    echo "       yesterday     - Open most recent daily log (handles gaps)"
    echo "       inbox         - Quick capture"
    echo "       wiki <name>   - Create/open wiki page (specific topic)"
    echo "       project <n>   - Create/open project (time bounded)"
    echo "       area <n>      - Create/open area (time unbounded)"
    echo "       resource <n>  - Create/open resource (reference material)"
    echo "  (cx) context       - Show today's focus and active tasks"
    echo "  (nt) ntasks        - View all incomplete tasks"
    echo "  (nf) nfind <term>  - Search notes"
    echo "  (nr) nrecent [n]   - Show recently modified notes (default 10)"
    echo "  (nw) nweek         - Review past week"
    echo "  (nq) nquick        - Append quick note to today's log"
    echo
}

# Aliases for convenience
alias n='nfind'
alias nt='ntasks'
alias tt='tasks-today'
alias nw='nweek'
alias cx='context'
alias nq='nquick'
alias nr='nrecent'
alias nh='notes-help'
