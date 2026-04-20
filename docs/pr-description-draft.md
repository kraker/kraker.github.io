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
- **Layout overrides**: one file only.
  - `layouts/_partials/custom/head-end.html` — 3 lines. Adds `<link rel=alternate>` RSS feed discovery (Hextra doesn't emit this by default). Uses Hextra's documented `custom/head-end.html` extension hook, not a template override.
  - The migration intentionally stays on Hextra stock everywhere else — no 404 override, no footer partial override, no custom shortcodes. Decision 1 (FAQ + Resume placement) now resolves in the top nav rather than via a custom footer, which lets `layouts/_partials/custom/footer.html` stay on Hextra's empty default. Keeps maintenance surface near zero for this stage.
- **Content**:
  - `content/_index.md` — **draft rewrite aligned with brand spec v1.4** (`docs/branding/alexkraker_brand_spec_v1.md`). Frontmatter `draft: true`; `hugo server -D` shows it, `hugo --minify` (CI) excludes it. Hextra `hextra-home` layout: hero badge → Field Manual repo, headline "I publish the field references I wish existed." (verbatim from v1.4 §1 positioning), subtitle "Linux security engineer and Red Hat ecosystem practitioner." (v1.4 identity lead — v1.1's FOSS-first framing reverted), CTAs (Field Manual primary, Blog secondary), "What's here" covering the three pillars (field references, working notes, community — v1.4 renamed Pillar 3 from "FOSS stewardship" to "Community") + consulting availability, Recent posts via the shortcode. **⚠ Flip `draft: false` before merging** or `/` 404s on the live site.
  - `content/about/index.md` — **draft rewrite aligned with brand spec v1.4 and the v1.3 copy template** (`docs/branding/kraker_brand_copy_template_v1.md`). Frontmatter `draft: true`. First-person, practitioner voice per §4. Lede paragraph fits the template's 1.3 Medium bio slot (~80 words, identity + specialty + Field Manual + concrete day-to-day). Body paragraph extends into the 1.4 Long bio territory (what I ship, ProLUG signal, Linux Upskill Challenge). Explicit "For hire" block for consulting (template 3.5). Personal-life content (hobbies, dog) dropped per §9 "not a personal-life surface." **⚠ Flip `draft: false` before merging** or `/about/` 404s on the live site.
  - `content/projects/_index.md` — reorganized around RHCSA Field Manual + `kraker/rhcsa` as primary, Linux Upskill Challenge + PaperStreet as past.
  - `content/blog/_index.md` — `type: blog` + `cascade.type: blog`, so Hextra's blog layouts are used.
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
