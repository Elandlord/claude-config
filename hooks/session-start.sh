#!/usr/bin/env bash
set -euo pipefail

SESSIONS_DIR="$HOME/.claude/sessions"
TODAY=$(date '+%Y-%m-%d')
SESSION_FILE="$SESSIONS_DIR/${TODAY}-session.md"

if [[ ! -f "$SESSION_FILE" ]]; then
    exit 0
fi

CONTEXT=$(tail -40 "$SESSION_FILE")

jq -n --arg ctx "$CONTEXT" '{
    "hookSpecificOutput": {
        "hookEventName": "SessionStart",
        "additionalContext": $ctx
    }
}'

exit 0
