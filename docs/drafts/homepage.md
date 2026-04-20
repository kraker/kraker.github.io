---
title: "Draft: homepage rewrite"
date: 2026-04-20
status: draft — awaiting author review for personal-brand authenticity
---

Claude-drafted Hextra-style homepage — parked so the live `/` keeps serving your original risotto welcome while this is reviewed.

When ready:
1. Move the body below into `content/_index.md` (replacing the restored original)
2. Verify the Field Manual repo URL is current
3. Delete this file

The `recent-posts` shortcode used below is already in place at `layouts/_shortcodes/recent-posts.html` and keeps working regardless of whether this draft is live.

---

```markdown
---
title: Alex Kraker
layout: hextra-home
cascade:
  sidebar:
    hide: true
---

{{< hextra/hero-badge link="https://github.com/kraker/rhcsa-field-manual" >}}
  <span>Work in progress: The RHCSA Field Manual</span>
  {{< icon name="arrow-circle-right" attributes="height=14" >}}
{{< /hextra/hero-badge >}}

<div class="hx:mt-6 hx:mb-6">
{{< hextra/hero-headline >}}
  Linux infrastructure,&nbsp;<br class="hx:sm:block hx:hidden" />done carefully.
{{< /hextra/hero-headline >}}
</div>

<div class="hx:mb-12">
{{< hextra/hero-subtitle >}}
  Alex Kraker — Red Hat Enterprise Linux practitioner.&nbsp;<br class="hx:sm:block hx:hidden" />
  Notes, posts, and the in-progress RHCSA Field Manual.
{{< /hextra/hero-subtitle >}}
</div>

<div class="hx:mb-6">
{{< hextra/hero-button text="Read the blog" link="/blog" >}}
&nbsp;
{{< hextra/hero-button text="The RHCSA Field Manual →" link="https://github.com/kraker/rhcsa-field-manual" style="background-color: transparent; border: 1px solid currentColor;" >}}
</div>

## Recent posts

{{< recent-posts limit="5" >}}
```

## Areas to review

1. **Headline** — "Linux infrastructure, done carefully." is my invention. Swap for whatever phrasing fits your positioning.
2. **Subtitle** — "Red Hat Enterprise Linux practitioner" is a narrower self-description than the original site suggested ("Linux security engineer"). Adjust to reflect where you actually are now.
3. **Hero badge copy** — "Work in progress: The RHCSA Field Manual" is safe and factual; change the link target if the repo moves.
4. **Two CTA buttons** — currently Blog + Field Manual. Consider adding a third (e.g. Resume) if it helps the consulting pitch.
5. **Recent posts list** — pulls top 5 automatically. If you'd rather curate, replace with a manual list.
6. **Head-shot** — the original homepage had a 225×225 headshot. Hextra's `hextra-home` layout doesn't have a conventional slot for it. If you want it back, consider the `hextra/hero-container` shortcode or a small image in a sibling div.
