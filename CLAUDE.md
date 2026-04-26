# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Personal site at [alexkraker.com](https://alexkraker.com) (repo name retained as `kraker.github.io`; GitHub Pages serves the custom domain via `static/CNAME`), built with [Hugo](https://gohugo.io) using the [Hextra](https://github.com/imfing/hextra) theme (pulled via Hugo Modules — see `go.mod`) and deployed to GitHub Pages via `.github/workflows/hugo.yaml` on every push to `main`.

## Conventions

**Default to project-local dependency management.** Tools that need a specific version, or that contributors and CI both need to share (linters, formatters, language toolchains, hook runners), belong pinned in the project — via `pyproject.toml` + `uv.lock`, `go.mod`, `package.json`, etc. — not installed globally on a developer's machine. `uv.lock`, `go.sum`, and equivalent lockfiles are tracked. Exceptions: ubiquitous OS-level tools (git, curl, gcc, dnf).

Concretely for this repo: Python-side dev tools (Vale via wrapper, pymarkdown, prek) live in `pyproject.toml` and are invoked via `uv run <tool>`. Hugo + Hextra are managed via `go.mod`. Don't add `vale`, `pymarkdown`, etc. to your shell PATH globally and call them directly — that hides version drift between local and CI.

## Commands

- `hugo server -D` — local dev server with drafts shown
- `hugo --gc --minify` — production build into `public/` (matches the CI build)
- `hugo new content/blog/<slug>.md` — scaffold a new post using `archetypes/default.md` (TOML front matter; starts with `draft = true`)
- `hugo mod get -u` — refresh the Hextra module to its latest available version
- `uv sync` — install/refresh Python-side dev tools (Vale, pymarkdown, prek) into `.venv/`
- `uv run vale content/` — lint prose (spelling, repetition, house style) across all content
- `uv run pymarkdown scan content/` — lint Markdown structure (heading levels, list prefixes, etc.)
- `uv run prek install` — install pre-commit hooks (one-time per clone)
- `uv run prek run --all-files` — run all hooks against the whole repo (baseline check)

CI installs **Hugo 0.160.1 extended** (see `.github/workflows/hugo.yaml`); `hugo.yaml` sets `min: "0.146.0"`. Match locally to avoid build drift.

## Prose linting (Vale)

`.vale.ini` configures [Vale](https://vale.sh) for `*.md` files. Intentionally minimal — just Vale's built-ins plus the project's house style:

- **Vale built-ins** (`BasedOnStyles = Vale`) — `Vale.Spelling`, `Vale.Repetition`, `Vale.Terms` (accept list), `Vale.Avoid` (reject list). Spelling uses Vale's bundled `errata-ai/en_US-web` dictionary (no Hunspell setup needed). Add `write-good`, `proselint`, etc. via `Packages = ...` later if the built-ins feel too sparse.
- **Kraker** custom style — `styles/Kraker/`, tracked. Three starter rules: `MarketingFluff` (bans buzzwords like "end-to-end"), `Wordiness` (substitutes shorter alternatives), `BrandConsistency` (enforces "GitHub", "Red Hat", etc.). Add new YAML rules here as the house style develops.
- **Vocabulary** — `styles/config/vocabularies/Kraker/accept.txt` (tracked). Add proper nouns and tech terms as Vale flags them. A sibling `reject.txt` would feed `Vale.Avoid`.

Invoke as `uv run vale ...`, never bare `vale` — the binary is a project dep installed into `.venv/` by the [`vale` PyPI wrapper](https://pypi.org/project/vale/), pinned via `uv.lock`.

## Markdown linting (pymarkdown)

[`pymarkdownlnt`](https://github.com/jackdewinter/pymarkdown) enforces Markdown structure rules (CommonMark + the standard MD0xx ruleset). Configured in `pyproject.toml` under `[tool.pymarkdown]`:

- `extensions.front-matter.enabled = true` so YAML/TOML front matter doesn't trigger missing-H1 errors.
- Disabled by default for this repo: `line-length` (MD013), `no-inline-html` (MD033 — Hugo shortcodes), `first-line-heading` (MD041 — front matter handles this), `no-bare-urls` (MD034), `no-duplicate-heading` (MD024).

Tighten or relax in `[tool.pymarkdown]` as the house style develops. Run as `uv run pymarkdown scan <path>`.

## Pre-commit hooks (prek) and publishing gates

[`prek`](https://github.com/j178/prek) is a Rust-based drop-in for pre-commit; same `.pre-commit-config.yaml` format. Hooks defined as `repo: local` so they invoke the uv-managed binaries (no separate hook-managed envs). On commit, Vale and pymarkdown run on staged Markdown files only.

- `uv run prek install` — wire the git hook on first clone
- `uv run prek run --all-files` — baseline check across the whole repo
- Hooks block the commit if Vale `Vale.Spelling`/`Vale.Terms` errors or any pymarkdown rule fires.

CI mirrors the same checks in `.github/workflows/hugo.yaml` as a `lint` job that runs before `build`. **Currently advisory** (`continue-on-error: true`) because the existing content has ~120 known errors; flip to blocking once the backlog is cleaned. The deploy job already depends on `build`, so once `lint` becomes blocking the chain is `lint → build → deploy`.

## Cloning

The theme is a Hugo Module, not a submodule — a plain `git clone` is sufficient. The first `hugo` build resolves modules automatically; `hugo mod get -u` refreshes the Hextra version pinned in `go.mod`.

## Content layout

- `content/blog/` — posts. Sections use either a single `<slug>.md` or a `<slug>/index.md` bundle when assets live alongside the post.
- `content/{about,projects}/` and `content/uses.md` — top-level pages wired into the nav via `menu.main` in `hugo.yaml` (Uses is `draft: true` until filled). `content/{contact,resume}/` and `content/faq.md` exist but are intentionally not in the nav.
- Front matter is mixed TOML (`+++`) and YAML (`---`) — follow whichever the surrounding files use. New posts from the archetype default to TOML with `draft = true`.
- `static/` is copied verbatim to the site root; `assets/` feeds Hugo's asset pipeline; `layouts/_partials/custom/` holds site-specific partial overrides.

## Image handling

`hugo.yaml` configures the imaging pipeline (quality 82, Lanczos, strips GPS EXIF). For one-off source-file optimization before committing (large uploads, etc.), run `magick` directly — e.g., `magick in.jpg -resize 400x400 -strip -quality 85 out.jpg`. Copy the original to `image-backups/<path>/` first so it's recoverable if the resize result isn't right.

## Deferred work

`TODO.md` at the repo root is the running list of parked work and positioning decisions (homepage hero, nav, newsletter plans, employment-related framing). Read it before changing the hero copy, the nav, the About page, or any copy that implies availability for consulting/client work.
