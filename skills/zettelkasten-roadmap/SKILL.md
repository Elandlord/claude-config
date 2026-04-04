---
name: zettelkasten-roadmap
description: Generate a boot.dev-style learning roadmap based on gaps in the Zettelkasten vault. Analyzes existing knowledge, identifies weak areas, and creates structured learning paths with exercises and quizzes.
---

# Zettelkasten Learning Roadmap

Analyze Eric's Zettelkasten vault to find knowledge gaps, then generate structured learning paths with exercises — like boot.dev but personalized to what he already knows.

## Trigger

Use when:
- User asks for a learning roadmap, study plan, or "what should I learn next"
- User says `/zettelkasten-roadmap`
- User wants to identify gaps in their knowledge

## Workflow

### Step 1: Pick a Domain

Ask the user which domain to analyze, or let them choose from detected topics:

> "Which area do you want a learning roadmap for? I can scan your vault to suggest domains, or you can pick one."

If the user picks a domain, proceed. If they want suggestions, scan the vault.

### Step 2: Audit Existing Knowledge

Search the Zettelkasten vault and local brain for what the user already knows:

```bash
curl -s -X POST http://mac-mini:3100/search \
  -H 'Content-Type: application/json' \
  -d '{"query": "<domain>", "limit": 30}'
```

Also scan MOCs in `Maps/` for topic clusters:

```bash
grep -r "[[" "/Users/ericlandheer/documents/Claude/Claude/Maps/" --include="*.md"
```

Build a knowledge inventory:
- **Strong areas**: Topics with multiple interlinked notes, evergreen status
- **Seedling areas**: Topics with 1-2 notes, seedling status, few links
- **Gaps**: Topics referenced in wikilinks but with no backing note (unresolved links)
- **Blind spots**: Standard subtopics in the domain that have zero coverage

### Step 3: Generate the Roadmap

Present a structured learning path organized into levels:

```
## Learning Roadmap: [Domain]

### Level 1: Foundations (you're here)
✅ [Topic] — strong (5 notes, evergreen)
✅ [Topic] — solid (3 notes, growing)
🌱 [Topic] — started (1 note, seedling) → Exercise below
❌ [Topic] — missing → Exercise below

### Level 2: Intermediate
🌱 [Topic] — partial coverage
❌ [Topic] — gap
❌ [Topic] — gap

### Level 3: Advanced
❌ [Topic] — not covered
❌ [Topic] — not covered

### Level 4: Expert
❌ [Topic] — not covered
```

### Step 4: Generate Exercises

For each gap or seedling, create a concrete exercise:

#### Quiz Questions
Test existing knowledge and push edges:
```
Q: [Question about the topic]
Hint: Check your note on [[Related Topic]]
```

#### Research Tasks
Point to specific resources:
```
Task: Read [specific resource] and create a zettel answering: [focused question]
Suggested links: [[Existing Note 1]], [[Existing Note 2]]
```

#### Connection Challenges
Strengthen the knowledge graph:
```
Challenge: Your notes on [[A]] and [[B]] both touch on [concept] but aren't linked.
Write a bridge note explaining how they connect.
```

#### Build Exercises
Hands-on application:
```
Build: Create a small [thing] that demonstrates [concept].
Document what you learn as a zettel.
```

### Step 5: Track Progress

Offer to create a project note in `2 Projects/` tracking the roadmap:

```yaml
---
id: "YYYYMMDDHHmm"
title: "Learning Roadmap: [Domain]"
type: project
status: active
---
```

With checkboxes for each exercise, linking to created notes as they're completed.

## Rules

- Base the roadmap on ACTUAL vault content, not assumptions. Always search first.
- Exercises should reference existing notes where possible — strengthen the graph.
- Don't make the roadmap exhaustive. Focus on the highest-value gaps.
- Suggest concrete resources (books, docs, tutorials) where relevant.
- The roadmap is a living document — offer to update it as the user progresses.
- Difficulty should genuinely escalate. Level 1 should feel achievable, Level 4 should feel ambitious.
- Keep exercises atomic — one concept per exercise, completable in one session.
