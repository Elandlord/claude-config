#!/usr/bin/env bash
set -euo pipefail

SESSIONS_DIR="$HOME/.claude/sessions"
TODAY=$(date '+%Y-%m-%d')
SESSION_FILE="$SESSIONS_DIR/${TODAY}-session.md"

mkdir -p "$SESSIONS_DIR"

HOOK_INPUT=$(cat)
TRANSCRIPT_PATH=$(echo "$HOOK_INPUT" | jq -r '.transcript_path // ""')

if [[ -z "$TRANSCRIPT_PATH" || ! -f "$TRANSCRIPT_PATH" ]]; then
    exit 0
fi

TODOS=$(jq -s '
    [.[] | .message.content[]? | select(.type == "tool_use" and .name == "TodoWrite") | .input.todos] |
    last // empty
' "$TRANSCRIPT_PATH" 2>/dev/null || echo "")

EDITED_FILES=$(jq -s '
    [.[] | .message.content[]? | select(.type == "tool_use" and (.name == "Edit" or .name == "Write")) | .input.file_path] |
    unique | .[]
' "$TRANSCRIPT_PATH" 2>/dev/null || echo "")

BRANCH=$(git -C "$(echo "$HOOK_INPUT" | jq -r '.cwd // "."')" branch --show-current 2>/dev/null || echo "unknown")

{
    echo "## Pre-Compact Snapshot ($(date '+%H:%M:%S'))"
    echo ""
    echo "Branch: $BRANCH"
    echo ""
    if [[ -n "$TODOS" && "$TODOS" != "null" ]]; then
        echo "### Active Todos"
        echo "$TODOS" | jq -r '.[] | "- [\(.status)] \(.content)"' 2>/dev/null || true
        echo ""
    fi
    if [[ -n "$EDITED_FILES" ]]; then
        echo "### Files Modified"
        echo "$EDITED_FILES" | while IFS= read -r f; do [[ -n "$f" ]] && echo "- $f"; done
        echo ""
    fi
    echo "---"
    echo ""
} >> "$SESSION_FILE"

exit 0
