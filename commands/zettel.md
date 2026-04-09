---
allowed-tools: Read, Write, Glob, Grep, Bash, mcp__local-brain__search_notes, mcp__local-brain__vault_status
argument-hint: [topic or context to capture]
description: Create a Zettelkasten note from conversation context
---

Create an atomic Zettelkasten note in the Obsidian vault at `~/Documents/Claude/Claude/`.

## Input

The topic or context to capture: $ARGUMENTS

## Process

1. **Search existing notes** using the local-brain MCP and grep to check for related notes. Avoid duplicating existing knowledge — link to it instead.

2. **Generate a unique ID** using the format `YYYYMMDDHHMMSS` (current timestamp).

3. **Write the note** to `~/Documents/Claude/Claude/1 Zettelkasten/{title}.md` with this template:

```markdown
---
id: "{timestamp_id}"
title: "{title}"
aliases:
  - "{alias if applicable}"
tags:
  - {relevant_tags}
type: "zettelkasten"
status: "seedling"
created: "{YYYY-MM-DD}"
updated: "{YYYY-MM-DD}"
source: "conversation"
---

# {title}

{Atomic, single-concept content. Write in own words, not copy-paste. Keep it concise but complete enough to stand alone.}

## Related
- [[{related note 1}]]
- [[{related note 2}]]
```

4. **Find and update related notes** — if existing notes should link back to this new note, add a `[[wikilink]]` to them.

5. **Trigger reindex** — call the local-brain `/index` endpoint via bash: `curl -s -X POST http://mac-mini:3100/index`

## Rules
- One concept per note (atomic)
- Use wikilinks `[[Like This]]` for connections
- Tags are lowercase, hyphenated
- Title should be a clear noun phrase or concept name
- Status is always "seedling" for new notes
