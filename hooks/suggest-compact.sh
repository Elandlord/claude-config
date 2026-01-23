#!/usr/bin/env bash
set -euo pipefail

HOOK_INPUT=$(cat)
SESSION_ID=$(echo "$HOOK_INPUT" | jq -r '.session_id // "default"')
COUNTER_FILE="/tmp/claude-compact-counter-${SESSION_ID}"
COMPACT_THRESHOLD="${COMPACT_THRESHOLD:-50}"
REMINDER_INTERVAL=25

COUNT=0
[[ -f "$COUNTER_FILE" ]] && COUNT=$(cat "$COUNTER_FILE")
COUNT=$((COUNT + 1))
echo "$COUNT" > "$COUNTER_FILE"

if [[ "$COUNT" -eq "$COMPACT_THRESHOLD" ]]; then
    jq -n '{
        "hookSpecificOutput": {
            "hookEventName": "PreToolUse",
            "additionalContext": "50+ tool calls this session. Consider /compact at a logical transition point (after exploration, before implementation)."
        }
    }'
elif [[ "$COUNT" -gt "$COMPACT_THRESHOLD" ]]; then
    SINCE=$(( (COUNT - COMPACT_THRESHOLD) % REMINDER_INTERVAL ))
    if [[ "$SINCE" -eq 0 ]]; then
        jq -n --arg c "$COUNT" '{
            "hookSpecificOutput": {
                "hookEventName": "PreToolUse",
                "additionalContext": ($c + " tool calls. Context getting heavy — /compact recommended.")
            }
        }'
    fi
fi

exit 0
