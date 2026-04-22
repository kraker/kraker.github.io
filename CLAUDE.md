# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Personal site at [kraker.github.io](https://kraker.github.io), built with [Hugo](https://gohugo.io) using the [Hextra](https://github.com/imfing/hextra) theme (pulled via Hugo Modules — see `go.mod`) and deployed to GitHub Pages via `.github/workflows/hugo.yaml` on every push to `main`.

## Commands

- `hugo server -D` — local dev server with drafts shown
- `hugo --gc --minify` — production build into `public/` (matches the CI build)
- `hugo new content/blog/<slug>.md` — scaffold a new post using `archetypes/default.md` (TOML front matter; starts with `draft = true`)
- `hugo mod get -u` — refresh the Hextra module to its latest available version
- `./scripts/optimize-images.sh` — resize/strip JPEG/PNG in `content/`, backing up originals to `image-backups/` (requires ImageMagick's `magick`)

CI installs **Hugo 0.160.1 extended** (see `.github/workflows/hugo.yaml`); `hugo.yaml` sets `min: "0.146.0"`. Match locally to avoid build drift.

## Cloning

The theme is a Hugo Module, not a submodule — a plain `git clone` is sufficient. The first `hugo` build resolves modules automatically; `hugo mod get -u` refreshes the Hextra version pinned in `go.mod`.

## Content layout

- `content/blog/` — posts. Sections use either a single `<slug>.md` or a `<slug>/index.md` bundle when assets live alongside the post.
- `content/{about,projects}/` and `content/uses.md` — top-level pages wired into the nav via `menu.main` in `hugo.yaml` (Uses is `draft: true` until filled). `content/{contact,resume}/` and `content/faq.md` exist but are intentionally not in the nav.
- Front matter is mixed TOML (`+++`) and YAML (`---`) — follow whichever the surrounding files use. New posts from the archetype default to TOML with `draft = true`.
- `static/` is copied verbatim to the site root; `assets/` feeds Hugo's asset pipeline; `layouts/_partials/custom/` holds site-specific partial overrides.

## Image handling

`hugo.yaml` configures the imaging pipeline (quality 82, Lanczos, strips GPS EXIF). The `optimize-images.sh` script is a separate, destructive pre-processing step that rewrites source files in `content/` in place — always keep `image-backups/` around until you've confirmed results.

## Deferred work

`TODO.md` at the repo root is the running list of parked work and positioning decisions (homepage hero, nav, newsletter plans, employment-related framing). Read it before changing the hero copy, the nav, the About page, or any copy that implies availability for consulting/client work.
