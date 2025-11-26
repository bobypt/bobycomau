# Content Workflow (Not Published)

This folder is excluded from Jekyll builds. Use it to manage ideas, outlines, and process.

## Article lifecycle

1. Capture ideas in `notes/*.md` as bullet lists or rough outlines.
2. When an idea is ready, create or update the matching file in `_ai/` (e.g. `_ai/1_1_basics.md`).
3. In the article front matter:
   - Set `series`, `sequence`, `tags`, and `status: draft`.
   - Optionally add `short_summary` for use in the AI index page.
4. When you publish:
   - Change `status: draft` → `status: published`.
   - Run the Jekyll build (`./start.sh`) to regenerate `_site`.

## Front matter fields for AI posts

Recommended fields:

```yaml
title: "AI Basics"
layout: default
permalink: /ai/basics
series: "Agentic AI Foundations"
sequence: 1.1
tags: [ai, agents, foundations]
status: draft        # or published
short_summary: "High-level overview of what AI and agents actually are."
canonical_url: "https://boby.com.au/ai/basics"
linkedin_post_url: ""   # fill after you publish on LinkedIn
```

Only `title`, `layout`, and `permalink` are strictly required for the site to work; the rest help you organize content and power listings.

## LinkedIn post planning

LinkedIn content is managed via the `_linkedin` collection (configured with `output: false`, so it never publishes).

- Each file represents **one LinkedIn post plan**.
- Example: `_linkedin/2025-01-01-ai-basics-summary.md`

Recommended front matter for LinkedIn posts:

```yaml
title: "3 things most people miss about AI basics"
related_ai_post: "/ai/basics"   # permalink of the main article
status: draft                   # draft | scheduled | posted
scheduled_for: 2025-01-01
hashtags: ["#AgenticAI", "#LLM", "#AIEngineering"]
target_audience: "cloud engineers, ML engineers, tech leads"
```

In the body of the file, keep:

- Hook ideas (first 1–2 sentences).
- Main bullet points for the post.
- Variants (e.g. shorter version for testing).

## Typical weekly flow

1. Draft an article outline in `notes/`.
2. Flesh it out and move it into `_ai/` with `status: draft`.
3. Create 3–5 `_linkedin/*.md` drafts linked via `related_ai_post`.
4. When you publish the article:
   - Set `status: published` on the `_ai` file.
   - For each LinkedIn draft you actually post, update its `status` to `posted` and (optionally) add the real LinkedIn URL in a `linkedin_url` field.

This keeps articles, their promotion plan, and posting history all version-controlled in this repo without leaking into the public site.


