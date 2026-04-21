---
title: "PR description: Migrate to Hextra theme + redesign non-blog content"
date: 2026-04-20
---

Local-only working copy. The body below is used as the PR description when opening the draft PR.

---

## Summary

Migrates `kraker.github.io` from the risotto theme to **Hextra v0.12.2** (installed as a Hugo module). Redesigns the homepage, About, Projects, FAQ, and Contact pages against the personal brand spec (`docs/branding/alexkraker_brand_spec_v1.md`). Adds a new `/study-guides/` landing page. Preserves every existing blog post URL unchanged.

Opened as **draft** — the author plans to rewrite portions of the Claude-drafted copy in their own voice before merging.

## What's in this PR

### Theme + infrastructure

- **Hextra module**: `github.com/imfing/hextra` at v0.12.2. Replaces the risotto git submodule. `.gitmodules` and `themes/risotto/` removed; `go.mod` + `go.sum` added.
- **Hugo version**: CI pinned `0.142.0 → 0.160.1` extended (past Hextra's 0.146.0 floor).
- **Workflow**: `actions/setup-go@v5` added (Hugo modules run on Go's module system). New `hugo mod get` step. `submodules: recursive` and the Dart Sass / Node no-ops dropped.
- **`hugo.yaml`**: rewritten against Hextra's reference config. Dark mode default + toggle, wide page width, FlexSearch, image pipeline and cache preserved from risotto.
- **`i18n/en.yaml`**: copyright override ("Copyright © 2026 Alex Kraker"). Hextra's footer reads this via `T "copyright"`, not the `hugo.yaml` top-level `copyright:` field.

### Content

- **`content/_index.md` (homepage)**: Hextra `hextra-home` layout. Hero badge → `/study-guides`, headline "Alex Kraker", subtitle "Linux security engineer. Red Hat ecosystem practitioner.", one "Read the blog" CTA, feature-grid of two cards (RHCSA study guide, Work with me).
- **`content/about/index.md`**: two-paragraph bio + "Work with me" block + trailing "Also: Projects · Notes · FAQ" row linking secondary pages.
- **`content/projects/_index.md`**: four-category list (Shipping, In progress, Community, Past).
- **`content/study-guides.md`** (new): brief landing page for the RHCSA + RHCE open-source study guides.
- **`content/contact/index.md`**: reach-out methods (email, LinkedIn, GitHub) + "What lands" / "What I won't reply to" blocks. Public email is `contact@alexkraker.com` (PurelyMail alias; user-side creation required).
- **`content/faq.md`**: personal Q&A trailing section (favorite color / movie / TV) pruned; technical Q&A kept verbatim.
- **`content/resume/index.md`**: unchanged.
- **`content/blog/*`**: unchanged. Every URL in `docs/migration-inventory.md` still renders identically. `content/blog/_index.md` adds `type: blog` + `cascade: { type: blog, comments: true }` so Hextra's blog layouts apply and Giscus only enables on blog posts.

### Nav

Top nav (trimmed from original 11 items to 8):
- **Blog · Study Guides · About · Contact** + icons: Search · RSS · GitHub · LinkedIn

Dropped from nav, still reachable by direct URL (linked from About body):
- Notes (external), Projects, FAQ, Resume

### Integrations

- **Giscus comments (live)**: blog posts only. Global `params.comments.enable: false`; blog posts inherit `comments: true` via cascade. Repo + IDs populated in `hugo.yaml` after giscus.app registration.
- **RSS feeds**: `/index.xml`, `/blog/index.xml`, per-section and per-tag feeds auto-generated. `layouts/_partials/custom/head-end.html` adds `<link rel=alternate>` discovery on every page.
- **GoatCounter analytics**: config block documented in `hugo.yaml`, commented out until the account is live.
- **Newsletter (Buttondown)**: deferred.

### Custom code surface

Four items beyond Hextra stock:

| Path | Purpose |
|---|---|
| `layouts/_partials/custom/head-end.html` | 3 lines — RSS feed discovery links |
| `assets/css/custom.css` | 1 rule — drop the forced `<main>` min-height so the footer can rise to meet short pages (notably the homepage) |
| `i18n/en.yaml` | 1 key — copyright override |
| `static/favicon*` + `site.webmanifest` | Favicon set, generated once from SVG via ImageMagick |

Everything else (layouts, partials, shortcodes, menu rendering, search, comments, footer, dark/light toggle) is Hextra default.

## URL-level diff vs. current live site

**Expected delta: one new URL**, no existing URLs broken.

- New: `/study-guides/`
- Unchanged: `/`, `/about/`, `/blog/`, `/blog/*` (every post), `/projects/`, `/resume/`, `/faq/`, `/contact/`, `/index.xml`, `/blog/index.xml`, `/notes/` (external redirect preserved)
- Draft (excluded from build): `/blog/second-brain-in-vim/` — pre-migration draft post, left as it was

`docs/migration-inventory.md` has the pre-migration URL inventory to spot-check against.

## What's iterating after this PR opens

The author (Alex) plans to rewrite the Claude-drafted copy on these surfaces in their own voice:

- Homepage hero + feature-card subtitles
- About bio paragraphs
- Projects descriptions
- Contact page "What lands" / "What I won't reply to" framing

The structure is settled; the language isn't.

## Test plan

Verified non-browser (see session history for command output):

- [x] `hugo --gc --minify` builds clean (48+ pages, zero errors/warnings)
- [x] All blog post URLs + RSS feeds render identically to pre-migration
- [x] Internal link check passes
- [x] Giscus renders only on blog posts; excluded from `/`, `/about/`, `/projects/`, `/contact/`, etc.
- [x] No references to `Merrick` (consulting partner) or the old `alex@alexkraker.com` in public pages — `grep` clean

To verify in the deploy preview / local browser:

- [ ] Dark mode default on first load (incognito)
- [ ] Theme toggle cycles light / dark / system; Giscus iframe follows
- [ ] Mobile (375px): hamburger works, no horizontal scroll
- [ ] Search box returns hits from real posts; Ctrl+K opens it
- [ ] Comment widget loads on a blog post (sign-in button visible); does not appear on other pages
- [ ] `/404.html` renders Hextra's default 404
- [ ] Contact page `contact@alexkraker.com` mailto works (after PurelyMail alias is created)

## Rollback

Branch starts from tag `pre-hextra-backup` pointing at `main@11c5c64`.

```
git checkout main
git reset --hard pre-hextra-backup
git push --force-with-lease origin main
```

Local-only until pushed. If you want the safety net on `origin` before any `--force-with-lease` scenario, push the tag alongside the branch:

```
git push origin pre-hextra-backup
```

## Out of scope (follow-ups — tracked here so they don't get lost)

- Flip `content/blog/second-brain-in-vim.md` from draft to published when the post is ready — or delete if it's abandoned
- PurelyMail: create the `contact@alexkraker.com` alias forwarding to the primary inbox
- Enable GoatCounter analytics (register the `kraker` subdomain, uncomment the config block)
- Buttondown (or alternative) newsletter setup
- Tag existing blog posts (every post's `tags:` frontmatter is empty or absent)
- Field Manual web companion at `/rhcsa/`, per-post OG image generation, `llms.txt`
- Create social accounts: **Substack**, **Mastodon**, **Bluesky**. Once accounts exist, surface from `/contact/` and (if desired) as icons in the top-nav icon row. Hextra ships a `mastodon` icon in its built-in set; Substack and Bluesky would need SVGs added via `assets/` or inline in a custom partial.
- Contact form / serverless form handler if the `contact@` alias proves insufficient against spam over time (current expectation: PurelyMail spam filter is enough)
- Brand color customization (`--primary-hue` tuning per brand spec §5; currently on Hextra defaults per Option C "defer")
