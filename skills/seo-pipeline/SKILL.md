---
name: seo-pipeline
description: Full SEO pipeline — audit a website, fix issues in the codebase, set up keyword research cron, generate content ideas, and create content from those ideas. Use when the user wants SEO work, site audits, keyword research, or content generation.
---

# SEO Pipeline

End-to-end SEO workflow from audit to content production.

## Trigger

Use when:
- User asks for an SEO audit, site optimization, or `/seo-pipeline`
- User wants keyword research or content ideas
- User wants to fix SEO issues in their codebase

## Phase 1: SEO Audit

### Step 1: Gather Context

Before auditing, understand the site:

> "What's the URL to audit? What's the business goal and target audience?"

Check for a product marketing context file: `.agents/product-marketing-context.md`. If it exists, use it.

### Step 2: Run the Audit

Audit in priority order using WebFetch, curl, and browser tools:

#### 1. Crawlability & Indexation
- Fetch and analyze `robots.txt`
- Check XML sitemap existence and validity
- Verify canonical tags
- Check for noindex/nofollow directives
- Test URL structure (clean, descriptive, no parameters)

#### 2. Technical Foundations
- Core Web Vitals targets: LCP < 2.5s, INP < 200ms, CLS < 0.1
- Mobile-friendliness (viewport meta, responsive)
- HTTPS enforcement
- Redirect chains (max 1 hop)
- 404 pages
- Page speed (check for render-blocking resources, image optimization)

#### 3. On-Page Optimization
- Title tags: 50-60 characters, keyword-rich, unique per page
- Meta descriptions: 150-160 characters, compelling, unique
- H1 structure: one per page, includes target keyword
- Image alt text: descriptive, includes keywords where natural
- Internal linking: logical hierarchy, no orphan pages
- Content depth vs. thin content

#### 4. Content Quality
- E-E-A-T signals (Experience, Expertise, Authoritativeness, Trustworthiness)
- Content freshness
- Duplicate content issues
- Keyword cannibalization

#### 5. Authority & Links
- Backlink profile overview (if tools available)
- Internal link distribution
- Broken links

**Note**: Structured data / schema markup cannot be detected via fetch — it's injected via JavaScript. Flag this for manual verification using Google Rich Results Test or browser DevTools.

### Step 3: Generate the Report

Output a structured report:

```markdown
# SEO Audit Report: [Site Name]
**Date**: [date]
**URL**: [url]

## Executive Summary
[2-3 sentences on overall SEO health and top priorities]

## Critical Issues (fix immediately)
| Issue | Page(s) | Impact | Fix |
|-------|---------|--------|-----|

## High Priority (fix this week)
| Issue | Page(s) | Impact | Fix |

## Medium Priority (fix this month)
| Issue | Page(s) | Impact | Fix |

## Low Priority (nice to have)
| Issue | Page(s) | Impact | Fix |

## Score Card
| Category | Score | Notes |
|----------|-------|-------|
| Crawlability | /10 | |
| Technical | /10 | |
| On-Page | /10 | |
| Content | /10 | |
| Authority | /10 | |
| **Overall** | **/50** | |
```

## Phase 2: Fix Issues

After the audit, offer to fix issues directly in the codebase.

### Step 1: Identify Fixable Issues

From the audit report, categorize:

| Fixable in Code | Requires External Action |
|-----------------|-------------------------|
| Meta tags, titles, descriptions | Backlink building |
| Image alt text | Content creation |
| robots.txt, sitemap | Google Search Console setup |
| Schema markup | Third-party tool config |
| Canonical tags | |
| Redirect rules | |
| Performance (lazy loading, compression) | |

### Step 2: Fix

For each code-fixable issue:
1. Locate the relevant file in the codebase
2. Apply the fix
3. Verify with lsp_diagnostics
4. Mark as done in the report

Present a summary of what was fixed and what still needs manual action.

## Phase 3: Keyword Research (Cron)

Set up recurring keyword research using the `schedule` skill.

### What the Cron Does

Daily at a configured time:
1. Fetch search trends for the target niche using available APIs/tools
2. Analyze competitor rankings for target keywords
3. Identify new keyword opportunities (long-tail, question-based, trending)
4. Store results in a structured file: `seo/keyword-research/[date].md`

### Output Format

```markdown
# Keyword Research — [Date]

## Trending Keywords
| Keyword | Volume | Difficulty | Intent | Opportunity |
|---------|--------|------------|--------|-------------|

## New Opportunities
| Keyword | Why | Suggested Content Type |

## Competitor Movements
| Competitor | Keyword | Change | Our Position |
```

### Setup

Use `/schedule` to create the cron:
- Name: `seo-keyword-research`
- Schedule: daily at 6:00 AM
- Working directory: the project root
- Prompt: "Run keyword research for [niche]. Save to seo/keyword-research/[date].md"

## Phase 4: Content Ideas

Ingest keyword research and generate content ideas.

### Step 1: Read Recent Research

Read the latest keyword research files from `seo/keyword-research/`.

### Step 2: Generate Ideas

For each high-opportunity keyword, generate:

```markdown
# Content Ideas — [Date]

## From Keyword Research

### [Keyword]
- **Content type**: [blog post / landing page / FAQ / comparison / guide]
- **Title options**: 3 title variations
- **Outline**: H2 structure with key points
- **Target word count**: [range]
- **Internal link targets**: pages to link from/to
- **CTA**: what action the reader should take
```

### Step 3: Prioritize

Score ideas by: search volume x low competition x business relevance.

## Phase 5: Content Production (Cron)

Set up a cron that picks up approved content ideas and drafts content.

### What the Cron Does

1. Read `seo/content-ideas/` for approved ideas (marked with `status: approved`)
2. Draft the content following the outline
3. Apply on-page SEO best practices (title, meta, headings, internal links)
4. Save to `seo/drafts/[slug].md`
5. Mark the idea as `status: drafted`

### Content Quality Rules

- Write for humans first, search engines second
- No keyword stuffing
- Natural language, conversational tone
- Include E-E-A-T signals where possible
- Minimum 1,500 words for pillar content, 800 for supporting content
- Include a meta description suggestion
- Suggest 2-3 internal links

### Setup

Use `/schedule` to create the cron:
- Name: `seo-content-drafter`
- Schedule: daily at 8:00 AM (after keyword research)
- Prompt: "Draft content from approved ideas in seo/content-ideas/. Save to seo/drafts/"

## Rules

- The audit report is the foundation — always start there
- Never stuff keywords unnaturally
- Prioritize user experience over SEO tricks
- All fixes must be verified (build passes, no broken pages)
- Content drafts are drafts — the user reviews and approves before publishing
- Respect the site's existing voice and tone
