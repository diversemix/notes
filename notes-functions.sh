#!/bin/bash
# Notes System Functions
# Add these to your ~/.zprofile or ~/.bash_profile to enable notes management functions

export NOTES_DIR="$HOME/notes"
export BAT_THEME=TwoDark

# Core daily note functions

npush() {
    npull || return 1
    pushd "$NOTES_DIR" > /dev/null
    git add .
    git commit -m "Notes update: $(date +%Y-%m-%d\ %H:%M) from: $(hostname)" || echo "No changes to commit"
    git push
    popd > /dev/null
}

npull() {
    pushd "$NOTES_DIR" > /dev/null
    git pull
    popd > /dev/null
}

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
    local recent_file=$(ls -1t "$NOTES_DIR/daily/"*.md 2>/dev/null | sort -nr | grep -v "$today_file" | head -n 1)

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

# Create an area file (without opening editor)
# This is used by both the bash 'area' function and the Neovim integration
create-area() {
    local name="$1"
    if [ -z "$name" ]; then
        return 1
    fi

    local slug=$(echo "$name" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
    local file="$NOTES_DIR/areas/$slug.md"

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

# Note Fast Find
nff() {
    if [ -z "$1" ]; then
        echo "Usage: nff <search-path>"
        return 1
    fi
    rg --no-heading --line-number --color=always --glob '!incoming/' --glob '!archive/' "" "$1" | \
      grep -v ':[[:space:]]*$' | \
      fzf --ansi --delimiter ':' \
      --preview 'bat --color=always {1} --highlight-line {2} ' \
      --preview-window '+{2}/2' | \
      cut -d':' -f1,2 | \
      xargs -I {} sh -c 'nvim +$(echo {} | cut -d: -f2) $(echo {} | cut -d: -f1)'
}

nsearch() {
    nff $NOTES_DIR
}

# Search functions
nfind() {
    local location="$NOTES_DIR"
    if [ -z "$1" ]; then
        # Interactive search with fzf/telescope (if available)
        if command -v fzf &> /dev/null; then
            local file=$(find "$location" -type f -name "*.md" | fzf --preview 'cat {}')
            [ -n "$file" ] && nvim "$file"
        else
            echo "Usage: nfind <search-term>"
            echo "Or install fzf for interactive search"
        fi
    else
        # Grep search
        grep -r -n "$1" "$location" --include="*.md" --color=always 
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
        if [[ "$OSTYPE" == "darwin"* ]]; then
            local mtime=$(stat -f %m "$file")
        else
            local mtime=$(stat -c %Y "$file")
        fi
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
    echo "=== Incomplete Tasks in Areas ==="
    grep -r "^- \[ \]" "$NOTES_DIR/areas/" --include="*.md" -H | sed "s|$NOTES_DIR/||g"
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
    echo
    echo "📝 Notes Commands ---------------------------------------------------"
    echo
    echo "    today         - Open today's daily note (auto-carries tasks)"
    echo "    yesterday     - Open most recent daily log (handles gaps)"
    echo "    inbox <msg>   - Quick capture of message for later"
    echo "    wiki <name>   - Create/open wiki page (specific topic)"
    echo "    area <n>      - Create/open area (time unbounded)"
    echo
    echo " ⚡"
    echo "  (nq) nquick        - Append quick note to today's log"
    echo
    echo " 🔍"
    echo "  (cx) context       - Show today's focus and active tasks"
    echo "  (nf) nfind <term>  - Search notes by filename"
    echo "  (nr) nrecent [n]   - Show recently modified notes (default 10)"
    echo "  (ns) nsearch <term>- Search within notes"
    echo "  (nt) ntasks        - View all incomplete tasks"
    echo "  (nw) nweek         - Review past week"
    echo
    echo " 🏷️"
    echo "  (nbt) ntags <tag>  - Find notes by tag"
    echo "  (ntl) ntaglist     - List tag frequency"
    echo
    echo " "
    echo "  (nl) npull         - Pull notes from git repository"
    echo "  (np) npush         - Push notes to git repository"
    echo
    echo "❓ (nh) nhelp        - Prints this page"
    echo "____________________________________________________________________"
    echo
}

# Aliases for convenience
alias nt='ntasks'
alias nf='nfind'
alias tt='tasks-today'
alias nw='nweek'
alias cx='context'
alias nq='nquick'
alias nr='nrecent'
alias nh='notes-help'
alias ns='nsearch'
alias np='npush'
alias nl='npull'
alias nbt='ntags'
alias ntl='ntaglist'

