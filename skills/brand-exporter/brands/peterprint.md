---
name: PeterPrint
domain: peterprint.nl
type: ecommerce
---

# PeterPrint

Contemporary Dutch online printing company. Typography-forward, minimalist, paper-inspired aesthetic.

## Colors

### Core

| Name | Hex | Tailwind Key | Role |
|------|-----|-------------|------|
| Black | `#000000` | `primary` | Primary buttons, text, headings |
| White | `#FFFFFF` | `secondary` | Secondary buttons, text on dark |
| Paper | `#F6F4F4` | `paper` | Background, container fill |
| Paper Light | `#DFDFDF` | `paper-light` | Alternative background |
| Border | `#B1ABAA` | `border` | Default borders, separators |
| Border Light | `#C4C3BF` | `border-light` | Subtle borders |

### Accent Palette

| Name | Hex | Tailwind Key | Role |
|------|-----|-------------|------|
| Fading Night | `#2974D6` | `fading-night` | Focus states, links, highlights |
| Deep Blush | `#E45D94` | `deep-blush` | Pink accent |
| Persian Green | `#01A797` | `persian-green` | Teal accent |
| Padua | `#A5E4BD` | `padua` | Success, paid status |
| Japonica | `#DC7470` | `japonica` | Error, open status |
| Sunny Side | `#FDD372` | `sunny-side` | Warning, pending status |
| First Rain | `#B6DEED` | `first-rain` | Info, alternative |
| Pink Touch | `#FFB8C5` | `pink-touch` | Soft pink accent |
| Misty Blush | `#DECCC9` | `misty-blush` | Muted warm neutral |

### Extended

| Name | Hex | Tailwind Key | Role |
|------|-----|-------------|------|
| Deluge | `#7965B2` | `deluge` | Purple accent |
| Ferra | `#8B6B65` | `ferra` | Warm brown |
| Matisse | `#1D4F91` | `matisse` | Deep blue |
| Berry Red | `#C7384B` | `berry-red` / `badge` | Badges, notifications |
| Primary Lightest | `#333333` | `primary-lightest` | Softer text |
| Primary Lighter | `#242424` | `primary-lighter` | Slightly softer text |

## Typography

- **Headings**: NeuePower (weight 700) — always `lowercase` via `text-transform: lowercase`
- **Body / UI**: PeterSans (weights: 400, 475, 550, 625) — primary sans-serif
- **Fallback**: `sans-serif`

### Scale

| Element | Size | Desktop Size |
|---------|------|-------------|
| Hero (h1) | 3.5rem (56px) | 5rem (80px) |
| Section (h2) | 2.75rem (44px) | 3.5rem (56px) |
| Subsection (h3) | 1.875rem (30px) | 2.75rem (44px) |
| Large text | 1.3125rem (21px) | — |
| Body | 1rem (16px) | — |
| Small / Caption | 0.75rem (12px) | — |

### Font Weights

| Name | Value | Usage |
|------|-------|-------|
| Normal | 400 | Body text |
| Medium | 475 | Emphasis |
| Semibold | 550 | Subheadings, labels |
| Bold | 625 | Headings, CTAs |

## Design Principles

1. **Paper-inspired** — Off-white (`#F6F4F4`) backgrounds evoke printed paper, with optional paper texture
2. **Typography-forward** — NeuePower lowercase headings are the signature; they define the brand
3. **Black & white core** — Primary buttons are black, secondary are white; color is for accents and status
4. **Subtle depth** — Multi-layered box shadows (`depth-1`, `depth-2`, `depth-3`) instead of hard borders
5. **Rounded but restrained** — `0.375rem` to `0.5rem` border radius; not pill-shaped
6. **Smooth transitions** — 250ms default, cubic-bezier easing

## Logo

- Brand name rendered in NeuePower lowercase
- Placement: top-left in navigation
- On paper/white backgrounds

## Layout Patterns

- **Backgrounds**: Paper (`#F6F4F4`) as default, white for cards/containers
- **Cards**: White with `shadow-default` (depth-2), rounded corners
- **Buttons**: Black fill (primary), white fill with border (secondary), both with shadow
- **Status indicators**: Padua (success/paid), Sunny Side (pending), Japonica (error/open), First Rain (info)
- **Grid**: Container centered, 1rem padding, responsive spacing scale

## Shadows

| Level | Shadow | Use |
|-------|--------|-----|
| depth-1 | `0 1px 0 0 rgba(0,0,0,0.08), 0 1px 2px 0 rgba(0,0,0,0.04)` | Subtle cards, buttons |
| depth-2 | `0 1px 0 0 rgba(0,0,0,0.12), 0 0 1px 0 rgba(0,0,0,0.24), -8px -8px 32px -16px rgba(0,0,0,0.06), 8px 8px 32px -16px rgba(0,0,0,0.06)` | Default cards |
| depth-3 | `0 1px 0 0 rgba(0,0,0,0.12), 0 0 1px 0 rgba(0,0,0,0.24), -16px -16px 48px -24px rgba(0,0,0,0.24), 16px 16px 48px -24px rgba(0,0,0,0.24)` | Modals, elevated |

## Rules

- NeuePower headings are ALWAYS lowercase — this is non-negotiable
- Paper background is the default, not white
- Black and white are the primary UI colors; the accent palette is for status, highlights, and decoration
- Shadows provide depth hierarchy — use depth-1/2/3 consistently
- No bold, saturated background fills on large areas — keep it paper-like
- Status colors are semantic: padua=success, sunny-side=pending, japonica=error, first-rain=info

## Tailwind Config Reference

Source: `themes/PeterPrint/PeterPrint/web/tailwind/tailwind.browser-jit-config.js`
