#!/usr/bin/env bash
set -euo pipefail

SESSIONS_DIR="$HOME/.claude/sessions"
TODAY=$(date '+%Y-%m-%d')
SESSION_FILE="$SESSIONS_DIR/${TODAY}-session.md"

mkdir -p "$SESSIONS_DIR"

HOOK_INPUT=$(cat)
SESSION_ID=$(echo "$HOOK_INPUT" | jq -r '.session_id // "unknown"')
TRANSCRIPT_PATH=$(echo "$HOOK_INPUT" | jq -r '.transcript_path // ""')

[[ -z "$TRANSCRIPT_PATH" || ! -f "$TRANSCRIPT_PATH" ]] && exit 0

TODOS=$(jq -s '
    [.[] | .message.content[]? | select(.type == "tool_use" and .name == "TodoWrite") | .input.todos] |
    last // empty
' "$TRANSCRIPT_PATH" 2>/dev/null || echo "")

EDITED_FILES=$(jq -s '
    [.[] | .message.content[]? | select(.type == "tool_use" and (.name == "Edit" or .name == "Write")) | .input.file_path] |
    unique | join(", ")
' "$TRANSCRIPT_PATH" 2>/dev/null || echo "none")

BRANCH=$(git -C "$(echo "$HOOK_INPUT" | jq -r '.cwd // "."')" branch --show-current 2>/dev/null || echo "unknown")

{
    echo "## Session End ($(date '+%H:%M:%S'))"
    echo ""
    echo "Branch: $BRANCH"
    echo ""
    if [[ -n "$TODOS" && "$TODOS" != "null" ]]; then
        echo "### Final Todo State"
        echo "$TODOS" | jq -r '.[] | "- [\(.status)] \(.content)"' 2>/dev/null || true
        echo ""
    fi
    echo "### Context to Restore"
    echo "Files: $EDITED_FILES"
    echo ""
    echo "---"
    echo ""
} >> "$SESSION_FILE"

rm -f "/tmp/claude-compact-counter-${SESSION_ID}" 2>/dev/null || true

exit 0
