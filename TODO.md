# TODO

Running list of deferred work for [alexkraker.com](https://alexkraker.com). Scope: anything bigger than a single-session fix that we've chosen to park for later. Conventions:

- Group by topic (`## Heading`), not by date.
- Each item has a short rationale so future-me (or Claude) knows why it's worth doing.
- Mark items `Done — YYYY-MM-DD` inline when finished, then prune on the next pass.
- Things we actively rejected go under `## Not doing` with a one-line reason so we don't re-litigate.

---

## Newsletter / subscriber capture

Goal: let readers subscribe for new blog posts and Field Manual updates. Deferred until after the Hextra migration stabilizes.

### Open decision: Substack vs. Buttondown

Pick one before implementing. Both are free to start and export subscribers as CSV (portable).

#### Option A — Substack (as embedded signup widget)

Hugo stays canonical. Substack handles list + delivery. Send short "new post" announce emails from Substack that link back to the Hugo post.

- Pros: zero config (paste embed snippet); Substack's recommendation network for discovery; better editor if we ever want longer-form newsletter-only content.
- Cons: no native RSS-to-email (send manually or duplicate content); no tags/segments on free tier, so can't cleanly split "Blog" vs. "Field Manual" subscribers; iframe embed doesn't inherit theme styling (dark mode, fonts); Substack branding on confirmation/unsubscribe; ongoing nudges toward paid tiers + Notes.

#### Option B — Buttondown (recommended for auto-delivery)

Hugo stays canonical. Buttondown auto-emails subscribers whenever `/blog/index.xml` updates. Field Manual updates go to a tagged segment of the same list.

- Pros: native RSS-to-email → zero manual work per post; tag-based segmentation on free/cheap tiers → one form with "Blog" vs. "Field Manual" checkboxes; plain HTML embed inherits our CSS; no third-party branding on confirmations.
- Cons: slightly more setup (RSS config, tags, form styling); smaller discovery surface than Substack; free tier caps around ~100 subscribers.

**Hybrid worth considering:** Substack for Field Manual (slower cadence, longer-form, benefits from discovery) + Buttondown/plain RSS for Blog (high cadence, auto-delivery). Only worth it if the two audiences genuinely diverge.

### Implementation checklist (once option chosen)

- [ ] Create account on chosen platform; verify sending domain if applicable.
- [ ] Build a Hugo shortcode `{{< subscribe >}}` that renders the embed/form.
- [ ] Place the shortcode on `/contact/` and link from Field Manual landing page.
- [ ] If Buttondown: connect RSS feed (`/blog/index.xml`), configure auto-send template, set up tags.
- [ ] If Substack: write first announce template; decide duplicate-content vs. link-back policy.
- [ ] Add a small "Subscribe" affordance somewhere on the homepage (not just `/contact/`).
- [ ] Test signup → confirmation → first email end-to-end with a real address.
- [ ] Document the workflow in CLAUDE.md so future-me remembers how to send.

---

## Positioning

**Decision (2026-04-21):** homepage hero framed as **personal brand / author-first**, not a services or consulting pitch. Site builds authority through writing + artifacts (RHCSA/RHCE guides, blog); hireability compounds as a side effect, not as a CTA. Driven by the active Peraton CoI constraint — the site must capture interest without signaling availability for client work.

### Applied in this branch

- Hero subtitle: `Your infrastructure secured end-to-end from the ground up.` → `Field notes from hardening RHEL at scale.` Staged as a first-pass reframe; **expect author rewrite** before merge (see `feedback_personal_voice_review` memory).
- Hero button: `Get in touch` (mailto) → `Read the blog` (→ `/blog`). A `read` CTA is unambiguously non-commercial; contact still reachable via the email icon in nav.
- `Work with me` feature-card remains commented out in `content/_index.md`. Leave it that way while at Peraton.

### On hold until Peraton exit

When Merrick Synergy partnership closes and formal notice is given at Peraton (or employment otherwise changes), the following become available:

- [ ] CTA upgrade path: swap `Read the blog` for a role/engagement-specific CTA (`Work with me`, `Hire me`, `Start a conversation`, etc.) — pick based on whether FT or consulting is primary at that time.
- [ ] Uncomment or recreate the `Work with me` feature-card on the homepage.
- [ ] Consider a dedicated `/services/` or `/hire/` page with engagement shapes and rates.
- [ ] Re-visit subtitle: with CoI gone, a reader-outcome line ("Hardened RHEL fleets that ship as fast as they audit.", etc.) is back on the table.

### Voice notes (durable)

- Personal-voice copy (bio, hero, taglines) is author-revised only — draft on a branch, never merge Claude-drafted copy without rewrite. Enforced via `feedback_personal_voice_review` memory.
- Subtitle needs to narrow the headline without restating it; avoid totality stacks like "end-to-end from the ground up."

---

## Nav & site structure

### Resume / CV

- **2026-04-21: decided not to add Resume to top nav.** Current resume is out of date, and surfacing it clashes with the personal-brand / consulting-pivot framing (signals "hireable" which the site shouldn't say while at Peraton).
- [ ] Rewrite CV and publish to its own project repo (timing TBD).
- [ ] Once rewritten and post-Peraton, re-evaluate whether to link from About or add a nav entry.

### Social icons — Mastodon / Bluesky

- [ ] Start posting on Mastodon and/or Bluesky as blog article cadence picks up.
- [ ] Add icon entries under `menu.main` in `hugo.yaml` once accounts are active (`icon: mastodon`, `icon: bluesky` — both ship in the Hextra icon set).

### `/uses` page

- **2026-04-21: scaffolded `content/uses.md`** with empty section headers (`draft: true`). Nav entry added at weight 4, between Blog and Search.
- [ ] Fill sections in author voice.
- [ ] Flip `draft: false` when ready.
- [ ] Optional: submit to [awesome-uses](https://github.com/wesbos/awesome-uses) so the site lands in the [uses.tech](https://uses.tech) directory.

---

## M & Mo Honey Co — placement

Alex is part owner of [M & Mo Honey Co](https://mandmohoneyco.com/) (Tulsa-based honey company) and does biz dev for it. Intentionally **left off the Projects page** — would dilute the technical-portfolio signal the page is meant to carry.

Open decisions:

- [ ] Add a one-line mention on the About page under a personal/hobbies-adjacent section? Or leave off the site entirely?
- [ ] **CoI check:** confirm whether part-ownership + biz-dev on an outside business needs Peraton disclosure under the current agreement. Applies regardless of whether it's mentioned on the site.

---

## Not doing (for now)

- **Blog roll / recent-posts shortcode on the homepage** — tried and reverted twice. Sticks with manually curated `{{< card >}}` entries for featured posts. (See commits `2014308` → `fae1b4b`.)
- **Self-hosted email (Listmonk, Mailcoach)** — overkill; running a mailer is not the job.
- **GitHub "Watch releases" for Field Manual** — would require splitting into its own repo and assumes readers have GitHub accounts.
