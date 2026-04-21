---
title: "Draft PR description: Migrate to Hextra theme"
date: 2026-04-20
---

This is a local-only artifact. When ready to push, use the body below as the PR description.

---

## Summary

Migrate `kraker.github.io` from the risotto theme to **Hextra v0.12.2**, installed as a Hugo module. Dark mode is the default, blog is the primary content type, and all pre-migration URLs are preserved.

Positioning shift toward Red Hat Consulting + *The RHCSA Field Manual*. Homepage and About copy are first-pass drafts — iterate before merge.

## What changed

- **Theme**: risotto submodule → Hextra Hugo module (`github.com/imfing/hextra` at v0.12.2). `.gitmodules` and `themes/risotto` removed.
- **Hugo**: CI version bumped `0.142.0 → 0.160.1` extended (well past Hextra's `≥0.146.0` floor).
- **Workflow**: added `actions/setup-go@v5` (Hugo modules run on Go's module system), added a `hugo mod get` step, dropped `submodules: recursive`, dropped the Dart Sass / Node.js no-ops.
- **`hugo.yaml`** rewritten against Hextra's reference config: module import, `params.theme.default=dark` + toggle, `params.page.width=wide`, FlexSearch on `content`, OG/Twitter defaults, image pipeline + cache preserved.
- **Layout overrides**: two small files.
  - `layouts/_partials/custom/head-end.html` — 3 lines. Adds `<link rel=alternate>` RSS feed discovery (Hextra doesn't emit this by default). Uses Hextra's documented `custom/head-end.html` extension hook, not a template override.
  - `layouts/_shortcodes/recent-posts.html` — 12 lines. Renders the N most recent blog posts as a small-caps "Latest posts" list on the homepage. Needed because Hextra ships no recent-posts equivalent and we don't want the homepage to be just a hero with nothing under it.
  - Everything else is Hextra stock. No 404 override, no custom footer partial, no other shortcodes.
- **Content**:
  - `content/_index.md` — **clean-slate homepage draft** (after six iterations cycling through Claude's voice). Frontmatter `draft: true`. Shape: Hextra `hextra-home` layout + three hero shortcodes (`hero-headline`, `hero-subtitle`, one `hero-button` → /blog) + a `{{< recent-posts limit="5" >}}` shortcode rendering the five most recent blog posts with dates. No feature-grids, no cards, no secondary CTAs. LinkedIn / email reach via the top-nav icons. **⚠ Flip `draft: false` before merging** or `/` 404s on the live site.
  - `content/about/index.md` — **clean-slate About draft**. Frontmatter `draft: true`. Two prose paragraphs (identity + day-to-day work; what I publish with one-sentence Field Manual mention) + `## Work with me` block (employment-forward, LinkedIn + email, no partner-channel mention). Same identity line as homepage subtitle — reader sees one person across surfaces. **⚠ Flip `draft: false` before merging** or `/about/` 404s on the live site.
  - `content/projects/_index.md` — **clean-slate Projects draft**. Frontmatter `draft: true`. Four-category list: Shipping (RHCSA + RHCE study guides), In progress (Field Manual), Community (Linux Upskill Challenge, ProLUG), Past (PaperStreet). Uses Hextra default layout so `##` headings render with prose chrome.
  - `content/faq.md` — pruned the personal Q&A trailing section (favorite color / movie / TV); kept all technical Q&A verbatim. Per brand spec §9 "not a personal-life surface."
  - `content/blog/_index.md` — `type: blog` + `cascade.type: blog`, so Hextra's blog layouts are used.
  - `content/resume/index.md`, `content/contact/index.md` — unchanged. Resume stays reachable at `/resume/` but is out of the top nav. Contact stays orphan at `/contact/`.
- **Assets**:
  - `static/favicon.svg` + `favicon-dark.svg` — monospace "ak" monogram, OS-color-scheme-aware.
  - `static/favicon-16x16.png`, `favicon-32x32.png`, `apple-touch-icon.png`, `favicon.ico` — generated from the SVG via ImageMagick.
  - `static/site.webmanifest` — minimal PWA manifest so Hextra's head request doesn't 404.
- **Housekeeping**:
  - `.gitignore` gains `image-backups/` (output of `scripts/optimize-images.sh`) and `.claude/` (local Claude Code settings).
  - `docs/migration-inventory.md` — the Phase 0 artifact; use it to spot-check URL preservation in review.

## URL-level diff vs. live

Expected delta after draft flags are flipped: **zero**. Inventory cross-check against the live slugs is in `docs/migration-inventory.md` — every pre-migration URL still renders in the new build (**provided `draft: true` on `/` and `/about/` is flipped to `false` first** — otherwise those two URLs 404 in production):

- `/about/`, `/blog/`, `/faq/`, `/projects/`, `/resume/`
- `/blog/grit/`, `/blog/kvdo/`, `/blog/learn-ansible/`, `/blog/learn-devops/`, `/blog/learn-python-qr/`, `/blog/linux-sysadmin/`, `/blog/rhel-vagrant/`, `/blog/second-brain/`, `/blog/technical-learning/`
- `/index.xml`, `/blog/index.xml`, per-tag and per-category RSS
- `/notes/` is untouched — it's a separate GitHub Pages project site (`kraker/notes`), only surfaced here as an absolute URL in the top-nav menu.

Draft post `/blog/second-brain-in-vim/` is still excluded (`draft: true`).

The legacy stale slugs `/blog/devops-learning-resources/` and `/blog/faq/` that showed up in prior `public/` outputs were risotto cruft — they aren't regenerated by the clean build.

## What's staged but not live yet

Items wired up with placeholders that need your input to go live:

- **Giscus comments** — `params.comments.enable: false` in `hugo.yaml` + empty `repoId` / `categoryId`. Register at [giscus.app](https://giscus.app/), paste the four values, flip `enable` to `true`. Cascade can be added later to restrict comments to blog posts only.
- **GoatCounter analytics** — the `params.analytics.goatCounter` block is commented out (Hextra errors on an empty `code`). When the `kraker.goatcounter.com` account is live, uncomment it with the code.
- **Newsletter / Buttondown** — footer "Subscribe" is an `href="#"` placeholder per the plan's "out of scope for this PR" note.

## Test plan

Things only a browser can confirm — please check these after the deploy preview comes up (or `hugo server` locally):

- [ ] First-load theme is dark (incognito)
- [ ] Theme toggle cycles light / dark / system
- [ ] Mobile (375px): hamburger works, no horizontal scroll, hero readable
- [ ] Search box (top nav) returns hits from real posts; keyboard shortcut works
- [ ] `/404.html` renders with links back to Home / Blog / About
- [ ] `/notes/` still resolves to the separate notes site
- [ ] RSS feeds open in a browser and in a feed reader
- [ ] Code blocks (bash / yaml in `/blog/kvdo/`, `/blog/learn-ansible/`) look legible in both light and dark

Verified non-browser:

- `hugo --gc --minify` builds clean (46 pages, zero warnings)
- `hugo server` responds 200 on `/`, `/blog/`, `/blog/grit/`, `/about/`, 404 on a nonexistent URL
- All RSS feeds are valid XML; 9 items in `/index.xml` and `/blog/index.xml`
- Internal link check: 25 unique links across 20 HTML files, **all resolve**
- Homepage HTML: 39.6KB (plan ceiling: 200KB transferred)
- Hextra `chroma` classes emit on code blocks

## Rollback

```
git checkout main
git reset --hard pre-hextra-backup
git push --force-with-lease origin main
```

Tag is local-only right now; push it before the force-push if you want the safety net on origin:

```
git push origin pre-hextra-backup
```

## Out of scope (follow-ups)

- Iterating on homepage + About copy (decision 2 deferred to a later pass per your call)
- Newsletter setup (Buttondown)
- Enabling Giscus (needs giscus.app registration)
- Enabling GoatCounter (needs account)
- Tags on existing posts (you opted to leave untouched this round)
- Field Manual `/rhcsa/` web companion, per-post OG image generation, `llms.txt`
