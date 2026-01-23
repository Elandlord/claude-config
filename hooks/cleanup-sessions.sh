#!/usr/bin/env bash
set -euo pipefail

SESSIONS_DIR="$HOME/.claude/sessions"
LEARNED_DIR="$HOME/.claude/skills/learned"
MAX_AGE_DAYS=7

[[ -d "$SESSIONS_DIR" ]] && find "$SESSIONS_DIR" -name "*.md" -mtime +$MAX_AGE_DAYS -delete 2>/dev/null || true
[[ -d "$LEARNED_DIR" ]] && find "$LEARNED_DIR" -name "*.md" -mtime +30 -delete 2>/dev/null || true
