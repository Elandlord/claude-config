---
name: zettelkasten
description: Add notes to Eric's Zettelkasten vault, find and create wikilinks, search the local brain for context, and trigger reindexing. Use when the user wants to capture knowledge, create notes, link ideas, search their PKM, or anything related to their Obsidian vault / second brain / Zettelkasten.
---

# Zettelkasten Skill

You are managing Eric's personal Zettelkasten vault — a densely-linked Obsidian knowledge base following the Luhmann method.

## Vault Location

`/Users/ericlandheer/documents/Claude/Claude/`

## Local Brain API

A vector search server indexes the vault. Use it for context discovery.

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `http://mac-mini:3100/search` | POST | Semantic vector search (`{ query, limit? }`) |
| `http://mac-mini:3100/ask` | POST | LLM Q&A over vault (SSE stream) |
| `http://mac-mini:3100/index` | POST | Reindex vault (`{ force?: boolean }`) |
| `http://mac-mini:3100/status` | GET | Index health + model availability |

## Workflow

### Step 1: Understand the Intent

Classify what the user wants:

| Intent | Action |
|--------|--------|
| "Add a note about X" | Create a new zettel |
| "I learned that X" | Create a new zettel |
| "Save this for later" | Create a fleeting note in Inbox |
| "How does X connect to Y?" | Search local brain, then link or create |
| "What do I know about X?" | Search local brain, summarize |
| "Link X to Y" | Find both notes, add wikilinks |
| "Reindex my vault" | POST /index |

### Step 2: Search for Context (ALWAYS do this before creating notes)

Before creating any note, search the local brain for related content:

```bash
curl -s -X POST http://mac-mini:3100/search \
  -H 'Content-Type: application/json' \
  -d '{"query": "<topic>", "limit": 10}'
```

This returns existing notes with cosine similarity scores. Use these to:
1. Avoid creating duplicate notes
2. Find wikilink targets
3. Understand where the new note fits in the knowledge graph

If the local brain is unreachable, fall back to Grep/Glob on the vault directory.

### Step 3: Create the Note

#### Note Types and Destinations

| Type | Folder | When to Use |
|------|--------|-------------|
| `fleeting` | `0 Inbox/` | Quick capture, unprocessed thought |
| `literature` | `0 Inbox/` (then move to `3 Resources/`) | Summarizing an external source |
| `zettel` | `1 Zettelkasten/` | Atomic, permanent knowledge |
| `project` | `2 Projects/` | Active work context |
| `moc` | `Maps/` | Topic reaches 5+ notes |

#### Frontmatter Template

Every note MUST have this frontmatter:

```yaml
---
id: "YYYYMMDDHHmm"
title: "Descriptive Title"
aliases: []
tags: []
type: zettel
status: seedling
created: "YYYY-MM-DD"
updated: "YYYY-MM-DD"
source: ""
---
```

- `id`: Use current timestamp in `YYYYMMDDHHmm` format
- `title`: Descriptive, concise — this IS the filename (without .md)
- `type`: One of `fleeting`, `literature`, `zettel`, `project`, `moc`
- `status`: Start as `seedling`, upgrade to `growing` or `evergreen` over time
- `source`: URL, book reference, or conversation context (required for literature notes)

#### File Naming

- Filename = title: `Descriptive Title.md`
- No IDs in filenames
- Place in the correct folder based on type

#### Writing the Note

Use `bash cat >` heredocs to write files (required by vault write hook):

```bash
cat > "/Users/ericlandheer/documents/Claude/Claude/1 Zettelkasten/Note Title.md" << 'ZETTEL_EOF'
---
id: "202603271430"
title: "Note Title"
...
---

# Note Title

Content here.

---

## Related
- [[Existing Note]]
- [[Another Note]]
ZETTEL_EOF
```

#### Content Rules

1. **Atomic**: One idea per note. If it covers two ideas, split it.
2. **Own words**: Rewrite in Eric's voice — direct, concise, no filler.
3. **No orphans**: Every note MUST link to at least one other note via `[[wikilinks]]`.
4. **Link liberally**: Connect to concepts, people, projects mentioned in the note.

### Step 4: Create Wikilinks

#### Link Syntax

```markdown
[[Note Title]]                    # Standard link
[[Note Title|Display Text]]       # Aliased link
[[Note Title#Section Name]]       # Section link
[[Note Title#^block-id]]          # Block reference
```

#### Finding Link Targets

1. Use local brain search results from Step 2
2. Grep the vault for related terms:
   ```
   Grep pattern="keyword" path="/Users/ericlandheer/documents/Claude/Claude/1 Zettelkasten/"
   ```
3. Check relevant MOCs in `Maps/` for existing topic clusters

#### When to Create vs Link

- If a concept exists as a note: `[[link to it]]`
- If a concept SHOULD exist but doesn't: create a `[[wikilink]]` anyway (Obsidian shows it as unresolved — that's fine, it seeds future notes)
- If you're unsure: search first, then decide

### Step 5: Update MOCs (when relevant)

If the new note belongs to an existing topic cluster, add it to the relevant MOC:

1. Check `Maps/` for a matching MOC
2. Add a `[[wikilink]]` to the new note under the appropriate section
3. If no MOC exists and the topic has 5+ notes, consider creating one

### Step 6: Commit and Push to GitHub

The vault is a git repository. After creating or modifying notes, commit and push:

```bash
cd "/Users/ericlandheer/documents/Claude/Claude"
git add -A
git commit -m "Add note: <Note Title>"
git push
```

Use a descriptive commit message. For multiple notes, summarize: `"Add notes: X, Y, Z"`.

### Step 7: Trigger Reindex

After pushing, reindex the vault so the local brain picks up changes:

```bash
curl -s -X POST http://mac-mini:3100/index -H 'Content-Type: application/json' -d '{}'
```

## Quality Checklist (verify before finishing)

- [ ] Frontmatter complete with all required fields
- [ ] Note placed in correct folder
- [ ] At least one `[[wikilink]]` to an existing note
- [ ] Content is atomic (one idea)
- [ ] Written in Eric's voice (direct, concise)
- [ ] Relevant MOC updated (if applicable)
- [ ] Changes committed and pushed to GitHub
- [ ] Vault reindexed via POST /index

## Examples

### Creating a Zettel from a Conversation

User: "I just realized that NATS JetStream is basically a distributed commit log, similar to Kafka but with less operational overhead"

1. Search local brain: `{"query": "NATS JetStream Kafka commit log"}`
2. Find existing notes: `NATS Messaging.md`, `Cloud Events.md`, `PeterPrint Infrastructure.md`
3. Create note:

```
1 Zettelkasten/NATS JetStream as Distributed Commit Log.md
```

4. Link to: `[[NATS Messaging]]`, `[[PeterPrint Infrastructure]]`, `[[Cloud Events]]`
5. Update `[[Software Engineering MOC]]` if appropriate
6. Reindex

### Quick Capture (Fleeting)

User: "Remind me to look into Temporal.io for workflow orchestration"

1. Create in `0 Inbox/`:

```
0 Inbox/Look Into Temporal.io for Workflows.md
```

2. Type: `fleeting`, minimal frontmatter
3. Link to: `[[Software Engineering MOC]]` or relevant context
4. Reindex
