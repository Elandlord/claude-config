#!/usr/bin/env bash
set -euo pipefail

LEARNED_DIR="$HOME/.claude/skills/learned"
mkdir -p "$LEARNED_DIR"

HOOK_INPUT=$(cat)
TRANSCRIPT_PATH=$(echo "$HOOK_INPUT" | jq -r '.transcript_path // ""')

[[ -z "$TRANSCRIPT_PATH" || ! -f "$TRANSCRIPT_PATH" ]] && exit 0

MSG_COUNT=$(jq -s 'length' "$TRANSCRIPT_PATH" 2>/dev/null || echo "0")
[[ "$MSG_COUNT" -lt 15 ]] && exit 0

CORRECTIONS=$(jq -s '
    [range(1; length) as $i |
     .[$i] |
     select(.role == "human") |
     .message.content |
     if type == "array" then
         [.[] | select(type == "object" and .type == "text") | .text] | join(" ")
     elif type == "string" then .
     else ""
     end |
     select(test("(no,|instead|wrong|actually|not like that|should be|fix this|thats not)"; "i"))] |
    if length > 0 then . else empty end
' "$TRANSCRIPT_PATH" 2>/dev/null || echo "")

if [[ -n "$CORRECTIONS" && "$CORRECTIONS" != "null" ]]; then
    TIMESTAMP=$(date '+%Y%m%d-%H%M%S')
    {
        echo "# Learned Pattern - $TIMESTAMP"
        echo ""
        echo "## User Corrections"
        echo "$CORRECTIONS" | jq -r '.[] | "- " + (.[0:200])' 2>/dev/null || true
    } > "$LEARNED_DIR/correction-${TIMESTAMP}.md"
fi

exit 0
