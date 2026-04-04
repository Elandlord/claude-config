---
name: notebooklm-slides
description: Create beautiful, design-forward slide decks using NotebookLM-inspired presentation styles. Supports multiple visual themes from editorial to pop art to minimalist. Use when the user wants slides, presentations, or decks with high design quality.
---

# NotebookLM Slides

Transform content into polished, presentation-ready slide decks with intentional design. Based on the curated prompt collection from awesome-notebookLM-prompts.

## Trigger

Use when:
- User wants to create slides, a deck, or a presentation
- User says `/notebooklm-slides`
- User mentions NotebookLM, Kael, or presentation design

## Workflow

### Step 1: Understand the Content

> "What content should this deck cover? Do you have source material (notes, docs, transcripts) or should I work from a topic?"

Accept any input: markdown files, URLs, pasted text, topic descriptions.

### Step 2: Choose a Design Style

Present available styles and let the user pick:

**Editorial & Business**
- **Modern Newspaper** — Swiss-inspired asymmetrical layouts, extreme typography hierarchy, monochrome photography with selective color accents
- **Sharp-edged Minimalism** — Grid-based, whitespace-heavy, luxury feel
- **Yellow x Black Editorial** — Fashion magazine aesthetic, dynamic serif fonts, high contrast
- **Black x Orange Creative Agency** — White backgrounds with blood orange (`#E85D30`) accents

**Pop & Youth**
- **Manga/Comic** — Information as visual narrative, panel layouts, enhanced memory retention
- **Magazine Cutout** — Cutout photography, asymmetric text boxes, matte pink backgrounds
- **Pink Street-style** — Deformed illustrations, soft squishy photo shapes
- **Digital/Neo/Pop** — Organic amoeba shapes, bright neon palettes

**Professional & Premium**
- **Studio/Mockup** — High-res Apple device mockups, electric purple + acid yellow accents
- **Sports/Athletic** — Bolt lime + neon orange, italic diagonal-cut layouts
- **Tech/Art/Neon** — Constructivist aesthetics, monochrome cutouts with neon geometry

**Artistic & Avant-Garde**
- **Classic/Pop** — Classical marble sculptures + modern pop objects, high saturation
- **Watercolor** — Royal blue and red wet aesthetic effects
- **Anti-Gravity/Artifact** — Minimal white canvas, soft gradient accents implying motion

**Specialized**
- **Deformed Flat Persona** — Slightly distorted figures, thick outlines, gentle palettes
- **Mincho x Handwritten** — Fashion photography, serif fonts mixed with casual handwriting

> "Which style fits your content? Or describe the vibe you're going for and I'll recommend one."

### Step 3: Structure the Deck

Apply the "1 slide = 1 message" principle:

1. Parse the source material into atomic messages
2. Create a slide outline:
   ```
   Slide 1: [Title slide — hook/headline]
   Slide 2: [Problem/context]
   Slide 3: [Key insight 1]
   ...
   Slide N: [CTA / closing]
   ```
3. Present the outline for approval before designing

### Step 4: Design the Slides

For each slide, apply the chosen style's design principles:

**Universal rules across all styles:**
- Extreme typography hierarchy (headline-to-body ratio 10:1+)
- Negative space discipline — let content breathe
- One message per slide, no exceptions
- Monochrome photography with selective color accents (where photos are used)
- Respect the user's language — never translate unless asked

**Per-style application:**
- Apply the specific color palette, typography, and layout rules of the chosen style
- Use the `/pptx` skill for .pptx output or `/frontend-design` for HTML slides
- For images: describe what should appear, use placeholder or AI-generated visuals

### Step 5: Citation Check

Before delivering, verify:
- All facts and figures have sources
- No hallucinated references
- Statistics are attributed
- Quotes are accurate

### Step 6: Deliver

Output options:
- `.pptx` file (use the pptx skill)
- HTML slides (self-contained, presentable in browser)
- Markdown outline (for further editing)

## Integration with Other Skills

- Use `/pptx` for PowerPoint generation
- Use `/frontend-design` for HTML slide decks
- Use `/visual-explainer` for technical explanation slides
- Use `/variant-brand` or `/brand-guidelines` to apply specific branding
- Use `/theme-factory` for custom theme application

## Rules

- Never create ugly, generic slides. Every slide should look intentional.
- 1 slide = 1 message. Always.
- Typography hierarchy is non-negotiable — headlines must dominate.
- Ask about style before designing. Don't assume.
- If the user provides source material, respect it — don't invent content.
- Slides should work without a presenter — they should tell the story on their own.
