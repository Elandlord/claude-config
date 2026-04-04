---
name: variant-brand
description: Applies Variant Fund's brand identity (red/black/white palette, minimalist aesthetic) to any artifact — slides, docs, reports, HTML pages, diagrams. Use when the user wants Variant branding applied to output.
---

# Variant Brand Guidelines

Apply Variant Fund's visual identity to any artifact.

## Trigger

Use when:
- User asks for Variant branding, styling, or design
- User says `/variant-brand`
- Output should match Variant's visual identity

## Brand Identity

### Colors

**Primary Palette:**
| Name | Hex | Usage |
|------|-----|-------|
| Variant Red | `#DD3737` | Primary accent, CTAs, highlights |
| Dark Red | `#571313` | Hover states, deep accents, section backgrounds |
| Black | `#000000` | Primary text, dark backgrounds |
| White | `#FFFFFF` | Backgrounds, text on dark |
| Cool Gray | `#ABB8C3` | Secondary text, borders, subtle elements |

**Usage Rules:**
- Red is the signature color — use it sparingly for maximum impact
- Default to black text on white backgrounds
- Use dark red for depth, not as a primary accent
- Cool gray for supporting elements only

### Typography

**Font Stack:**
- Headings: System sans-serif (SF Pro, Inter, or Helvetica Neue)
- Body: System sans-serif
- No serif fonts — the brand is modern and clean

**Scale:**
| Element | Size | Weight |
|---------|------|--------|
| Display / Hero | 42px+ | Bold |
| Section Heading | 36px | Bold |
| Subheading | 20px | Semibold |
| Body | 16px | Regular |
| Caption / Small | 13px | Regular |

### Design Principles

1. **Minimalist** — Generous whitespace, clean lines, no visual clutter
2. **Bold accents** — Red used surgically for emphasis, not decoration
3. **Modern** — Flat design, no gradients except subtle loading states
4. **Professional** — Venture capital aesthetic — confidence without flash
5. **Rounded CTAs** — Buttons use full border-radius (`9999px`), pill-shaped

### Logo

- File: `cropped-variant-logo-512.png` (512x512)
- Placement: top-left or centered on title slides
- Minimum clear space: 1x logo height on all sides
- Never stretch, rotate, or recolor the logo

### Layout Patterns

- **Cards**: Clean white cards with subtle shadow or border
- **Sections**: Alternate white and very light gray backgrounds
- **Hero**: Black background with white text and red accent
- **Data**: Simple tables and charts, red for key metrics

## Application

### Slides / Presentations
- Title slide: black background, white text, red accent line
- Content slides: white background, black text, red for emphasis
- Use the NotebookLM "Sharp-edged Minimalism" style as base, override with Variant colors

### HTML Pages
```css
:root {
    --variant-red: #DD3737;
    --variant-dark-red: #571313;
    --variant-black: #000000;
    --variant-white: #FFFFFF;
    --variant-gray: #ABB8C3;
}
```

### Documents
- Headings in black, bold
- Accent color (red) for horizontal rules, callout borders, key figures
- Body text in dark gray or black
- Minimal use of color — let whitespace do the work

### Charts & Diagrams
- Primary data series: Variant Red
- Secondary: Dark Red
- Tertiary: Cool Gray
- Background: White
- Grid lines: very light gray

## Rules

- Red is an accent, not a background color (exception: small badges/tags)
- Never use more than 3 colors in a single view
- Whitespace is a design element — don't fill every gap
- All text must meet WCAG AA contrast ratios
- When in doubt, go simpler
