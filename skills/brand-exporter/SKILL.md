---
name: brand-exporter
description: Define, store, and export brand identities as reusable themes. Brands can be applied to any artifact (slides, docs, HTML, diagrams) and exported as theme-factory themes, CSS variables, Tailwind configs, or JSON tokens. Use when creating, managing, or applying brand identities.
---

# Brand Exporter

Define brand identities once, apply them everywhere. Brands are stored as portable definitions and can be exported to theme-factory themes, CSS variables, Tailwind configs, or any other format.

## Trigger

Use when:
- User wants to define or create a brand identity
- User wants to apply a brand to any artifact
- User says `/brand-exporter`
- User mentions a stored brand by name (e.g., "use Variant branding")
- User wants to export a brand to a specific format

## Stored Brands

Brand definitions live in `~/.claude/skills/brand-exporter/brands/`. Each brand is a markdown file with colors, typography, design principles, and layout rules.

### Available Brands

Check `brands/` for the current list. To see what's available:

> "Which brand should I apply? I have: [list brands from brands/ directory]"

## Workflow

### Creating a New Brand

#### Option A: From a URL

1. Fetch the website with WebFetch
2. Extract colors, fonts, design patterns from CSS/HTML
3. Ask the user to confirm/adjust
4. Save to `brands/[brand-name].md`
5. Export to theme-factory (optional)

#### Option B: From User Input

1. Ask for: brand name, colors (hex), fonts, design vibe
2. Generate a complete brand definition
3. Save to `brands/[brand-name].md`
4. Export to theme-factory (optional)

#### Option C: From a Brand Guide / PDF

1. Read the brand guide using the pdf skill
2. Extract all brand elements
3. Save to `brands/[brand-name].md`
4. Export to theme-factory (optional)

### Brand File Format

Every brand file follows this structure:

```markdown
---
name: Brand Name
domain: brand.com
type: saas|venture-capital|ecommerce|agency|personal|other
---

# Brand Name

## Colors
| Name | Hex | Role |
|------|-----|------|

## Typography
- **Headings**: Font (fallbacks)
- **Body**: Font (fallbacks)

## Scale
| Element | Size | Weight |

## Design Principles
1. ...

## Logo
- File/URL, placement, clear space

## Layout Patterns
- Cards, sections, hero, data

## Rules
- Hard constraints
```

### Applying a Brand

When applying a brand to an artifact:

1. Read the brand definition from `brands/`
2. Apply based on the artifact type:

| Artifact | How to Apply |
|----------|-------------|
| Slides / PPTX | Use `/pptx` with brand colors + fonts |
| HTML page | Generate CSS custom properties |
| Nuxt / Vue | Generate Tailwind config override |
| Document / DOCX | Use `/docx` with brand styling |
| Diagram | Apply color palette to nodes/edges |
| Email | Inline styles with brand colors |
| Charts | Map data series to brand colors |

3. Always verify WCAG AA contrast ratios

### Exporting a Brand

#### To Theme Factory

Generate a theme file in `~/.claude/skills/theme-factory/themes/[brand-name].md`:

```markdown
# Brand Name

[One-line description of the visual identity]

## Color Palette
- **[Color Name]**: `#hex` - [usage]

## Typography
- **Headers**: [Font]
- **Body Text**: [Font]

## Best Used For
[Contexts where this brand applies]
```

#### To CSS Custom Properties

```css
:root {
    --brand-primary: #hex;
    --brand-secondary: #hex;
    --brand-accent: #hex;
    --brand-bg: #hex;
    --brand-text: #hex;
    --brand-font-heading: 'Font', fallback;
    --brand-font-body: 'Font', fallback;
}
```

#### To Tailwind Config

```js
module.exports = {
    theme: {
        extend: {
            colors: {
                brand: {
                    primary: '#hex',
                    secondary: '#hex',
                    accent: '#hex',
                },
            },
            fontFamily: {
                heading: ['Font', 'fallback'],
                body: ['Font', 'fallback'],
            },
        },
    },
};
```

#### To JSON Token

```json
{
    "brand": "Brand Name",
    "colors": { "primary": "#hex", "secondary": "#hex" },
    "fonts": { "heading": "Font", "body": "Font" },
    "principles": ["principle 1", "principle 2"]
}
```

## Integration with Other Skills

- `/theme-factory` — Export brand as a reusable theme
- `/notebooklm-slides` — Apply brand to slide design styles
- `/frontend-design` — Apply brand to UI components
- `/pptx` — Apply brand to PowerPoint files
- `/brand-guidelines` — Anthropic's specific brand (coexists with this skill)
- `/visual-explainer` — Apply brand to technical explanation pages

## Rules

- Never guess colors — always read the brand file or ask the user
- Export to theme-factory when creating a new brand (unless user declines)
- Brand files are the single source of truth — don't hardcode brand values elsewhere
- When a brand is updated, offer to re-export to all formats
- Respect the brand's own rules (e.g., "never use X as a background")
