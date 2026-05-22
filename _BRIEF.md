# Design-Style Demo — Shared Build Brief

You are building ONE page in a 50-part gallery. Every page re-skins the SAME
interactive component showcase in a different design style. Your job: rebuild
the whole showcase, fully functional, restyled completely in your assigned style.

## Reference (read this first, in full)
`/Users/garymeyer/dev/neumorphic-showcase/index.html`
It is the canonical functional spec: every component, every section, and all the
JavaScript behaviour you must reproduce lives there. Study it, then re-skin it.
Do NOT copy its neumorphic look — only its structure and interactions.

## Output
A single self-contained file at:
`/Users/garymeyer/dev/design-styles-demo/styles/<slug>.html`
- All CSS and JS embedded inline. No external files except Google Fonts.
- Must work by double-clicking the file (use a `file://` friendly build).

## Sections & components — include ALL of them, all interactive
1. **Sticky nav** — brand mark + name, 2-3 nav links, a clearly visible
   "← All styles" link pointing to `../index.html` (REQUIRED), optional theme toggle.
2. **Hero** — eyebrow tag, large headline, subtitle, two CTA buttons, a row of
   3 stat pills.
3. **Component bento grid**
   - Music player: album art, track title/artist, like/heart toggle, play/pause,
     prev/next, a seekable progress bar with time readout, an equalizer that
     animates while playing.
   - Preferences card: 3 toggle switches.
   - Volume dial: a circular knob you drag (and arrow-key) 0-100, with a value
     readout and an arc/indicator.
   - Brightness slider: a range slider with a live % readout.
   - Inputs card: a search field + a 3-option segmented control with a sliding
     indicator.
   - Activity card: a circular progress ring that animates when scrolled into
     view + stat chips + buttons (include one disabled).
4. **"More controls" section**
   - Accent / colour picker: swatches that re-theme the page's accent live.
   - Stepper: − / value / + quantity control.
   - Star rating: 5 stars, hover preview + click to set.
   - Custom dropdown select: opens a menu, selectable, closes on outside-click / Esc.
   - PIN input: 4 single-digit cells, auto-advance, backspace-to-previous.
   - Toggle button group: 4 independently-toggling buttons.
   - Accordion: 3 FAQ items, smooth expand/collapse.
   - Overlays card: buttons that trigger a modal dialog and a toast.
5. **Modal dialog** — backdrop, open/close, Esc + backdrop-click dismiss, focus handling.
6. **Toast notifications** — slide in, auto-dismiss.
7. **Principles / about section** — 3 cards or similar.
8. **Footer.**

## Interactivity — every one of these must work
play/pause + progress + equalizer · dial drag + keyboard · slider · switches ·
segmented control · scroll-revealed ring animation · accent picker re-theming ·
stepper · star rating · accordion · custom select · PIN · toggle group · modal ·
toasts · on-load and scroll entrance animations.

## Styling — commit fully to the assigned style
Fonts (via Google Fonts), colour palette, shapes, borders, shadows, textures,
decorative motifs, backgrounds, motion — all must scream the style. Someone
should name the style in one glance. No generic "AI slop". Match decoration
density and motion intensity to the style (maximalist styles → elaborate;
minimal styles → restraint and precision).

## Content
The page is explicitly a showcase OF the assigned style. The hero headline
should say so, in the style's own voice. You may rename the brand and rewrite
microcopy to fit the theme, but keep the section structure identical so all 50
pages stay comparable.

## Quality bar
- Semantic HTML, focus-visible states, ARIA on custom controls, honour
  `prefers-reduced-motion`.
- Responsive: 3-col → 2-col → 1-col.
- VERIFY before finishing: render a screenshot with headless Chrome —
  `"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless
  --disable-gpu --hide-scrollbars --window-size=1280,3800 --screenshot=_v.png
  "file://<absolute-path-to-your-html>"` — then Read the PNG, fix anything broken,
  off-style, overlapping, or low-quality, re-render, and repeat until it is
  genuinely polished. DELETE the screenshot when done.
- Leave only the one HTML file behind.
