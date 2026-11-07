---
name: oat-site
description: Build or extend a minimal website on Oat UI (knadh/oat, @knadh/oat, oat.ink), the ~10 KB semantic, zero-dependency HTML/CSS/JS component library. Use when starting a new small site, landing page, tool page or dashboard with Oat, or when editing any page that already loads oat.min.css. Keeps the agent on the current release, using the components Oat already ships, and working with Oat's semantic-HTML approach instead of against it.
---

# Building on Oat

Oat styles plain semantic HTML. A `<button>`, `<dialog>`, `<details>`, `<progress>` or
`<table>` looks finished with no classes. Variants are attributes (`data-variant`, `role`,
`aria-*`), and the few interactive pieces are small WebComponents (`ot-dropdown`, `ot-tabs`,
`ot-taginput`, `ot-upload`) plus `ot.toast()`. There's no build step, no framework and no
dependency. A site built on it should read like a well-written HTML document with very little
CSS of its own.

The two failure modes this skill exists to prevent:

1. **Rebuilding something Oat ships**, such as a custom modal, dropdown, tabs script, toast
   system, tooltip library, spinner, switch, grid or button styles.
2. **Fighting the paradigm**, with class soup, a utility framework on top, `!important`
   overrides, `<div onclick>` instead of a `<button>`, JS for what native HTML does, or a
   bundler for a page that needs none.

## 1. Check the release first

Run the bundled check before writing code:

```sh
sh <skill-dir>/scripts/check-release.sh
```

The skill tracks Oat by minor version: `references/oat-1.1.md` covers every 1.1.x release,
because Oat's patch releases are fixes only. Whatever the status, pin the site to the exact
version on the `pin:` line.

- **current:** use `references/oat-1.1.md` as the source of truth.
- **outdated:** a newer Oat minor or major is out and the reference may be stale. Open the
  compare link it prints and read the changed pages on <https://oat.ink> (or
  `docs/content/components/` at the new tag) for every component you use, and tell the user
  the skill's reference is behind so they can update it (steps at the end of the reference).
- **unchecked (offline):** use the reference and the `pin:` version, and say so.

Don't rely on memory of Oat's API. It has renamed things across releases (see "Renamed or
removed" in the reference), and models often confuse it with Pico CSS, Bootstrap or Tailwind
class names. Look it up.

## 2. Reach for what exists

Before writing any CSS rule or line of JS, find the need in this table, then read its section
in `references/oat-1.1.md`. Only build something when it's genuinely missing.

| Need | Use | Not |
|-|-|-|
| Modal / confirm | `<dialog>` + `commandfor` / `command="show-modal"`, `closedby="any"` | A custom overlay div, a JS modal library |
| Menu, popover | `<ot-dropdown>` + `popovertarget` / `popover`, `role="menuitem"` | A hand-positioned absolute div with click-outside JS |
| Tabs | `<ot-tabs>` + `role="tablist|tab|tabpanel"`, `data-anchor` for deep links | A show/hide tab script |
| Accordion, FAQ, disclosure | `<details>` / `<summary>`, `name` for exclusive | A collapse component |
| Notifications | `ot.toast(msg, title, { variant, placement, duration })` | A toast library or custom stack |
| Tooltip | The `title` attribute (+ `data-tooltip-placement`) | Tippy/Popper, custom hover CSS |
| Button styles | `<button>`, `data-variant`, `.outline` `.ghost` `.small` `.large` `.icon`, `<a class="button">` | `.btn-primary`-style classes |
| Grouped buttons, pagination | `<menu class="buttons">` | Custom border-radius stitching |
| Forms, validation | `label[data-field]`, `data-hint`, `aria-invalid` + `.error`, `fieldset.group` | Custom field and error styling |
| Toggle | `<input type="checkbox" role="switch">` | A CSS toggle widget |
| Tags, chips input | `<ot-taginput>` | A tag-input library |
| File picker, drop zone | `<ot-upload>` | A dropzone library |
| Loading | `aria-busy="true"` (`data-spinner`), `.skeleton` | Spinner SVGs/GIFs |
| Progress, gauges | `<progress>`, `<meter>` | Width-animated divs |
| Status message | `role="alert"` + `data-variant` | A custom callout box |
| Labels, pills | `.badge` + `data-variant` | Custom pill CSS |
| Cards | `<article class="card">` with header/footer | Bordered divs |
| Avatars | `<figure data-variant="avatar">` | Rounded-image CSS |
| Layout | `.container` / `.row` / `.col-n`, `.hstack` / `.vstack`, gap/margin utilities | Bootstrap/Tailwind, custom grid CSS |
| App shell | `data-sidebar-layout`, `aside[data-sidebar]`, `data-topnav`, `data-sidebar-toggle` | A custom off-canvas nav |
| Dark mode | Automatic via `light-dark()`; force with `color-scheme` | Duplicated dark stylesheets, a theme JS framework |
| Brand colours, spacing, fonts | Override the theme variables on `:root` | Hard-coded colours and pixel values |
| Hide/show | The native `hidden` attribute | `.d-none`, `display:none` classes |

Also check the documented recipes (split button, radio cards, form card, empty state, stats
cards, download, copy, loading and confirm-delete buttons) and Oat's listed extensions
(oat-table for sortable tables, oat-chips, oat-animate, oat-upload) in the reference before
designing a composition yourself.

**Genuinely not in Oat**, so it's fine to build small, in Oat's style: page header/nav bar
and footer layout outside the sidebar shell, hero sections, icons (there's no icon set; use
inline SVG with `stroke="currentColor"`, as the docs do), images and media layout, charts,
routing (knadh's tinyrouter.js), date pickers (prefer the native `<input type="date">`).

## 3. Work with the paradigm

- **Semantic element first.** Choose the element that means the thing (`button`, `nav`,
  `article`, `dialog`, `details`, `fieldset`, `output`, `menu`), then add the attribute that
  states its role or variant. A class is the last resort, and only one of Oat's or one with a
  real layout job.
- **Attributes over classes for state and variants.** `data-variant`, `aria-busy`,
  `aria-invalid`, `aria-current`, `aria-disabled`, `disabled`, `hidden`, `open`. Changing state
  in JS means setting an attribute, not swapping class names.
- **Native behaviour before JS.** Dialogs, popovers, details, form validation and
  `commandfor` all work without script (Oat's JS adds a `commandfor` polyfill for Safari, so
load it anyway). Write JS only for application logic, and keep it as
  short handlers, as the recipes do.
- **Theme through variables only.** Put the site's CSS in a `style.css` loaded *after* Oat:
  variable overrides on `:root` first, then the few layout rules Oat doesn't cover, using
  `var(--space-*)`, `var(--radius-*)`, `var(--text-*)` and the colour tokens. Keep colours as
  `light-dark(light, dark)` so dark mode keeps working.
- **No `!important`, no specificity battles.** Oat is entirely inside `@layer`s, so any plain
  unlayered rule already wins. If a rule seems not to apply, check the selector instead of
  escalating.
- **Don't restyle components into something else.** If you're overriding most of a component's
  CSS, you either picked the wrong component or the design is fighting Oat. Raise it with the
  user rather than forking the look.
- **No build step unless the project already has one.** Two `<link>`/`<script>` tags (pinned),
  or vendored copies of the two files. Don't add npm, a bundler, a CSS framework or a JS
  framework to a minimal site.
- **New interactive widgets follow Oat's shape**: a small custom element over semantic
  children, initialised on connect, state in attributes, events via `dispatchEvent`, with
  `OtBase` (`src/js/base.js`) as the model. Check Oat and its extension list first.

## 4. Starting a new site

Copy `assets/starter.html` and `assets/style.css`, and set both Oat URLs to the release
check's `pin:` version. For a static host like GitHub Pages, that is the whole
project: `index.html`, `style.css`, assets, plus whatever the host needs (`CNAME`, favicon,
`robots.txt`). Add pages as more `.html` files. Reach for a static site generator only if the
user asks for one or the site has many templated pages.

Keep `style.css` short. If it grows past a screen or two, look again at whether Oat already
covers what it's doing.

## 5. Before you finish

- Did you run the release check, and do both Oat URLs pin the exact `pin:` version it printed?
- Grep your CSS: any `!important`, hard-coded colours, or rules restyling `button`, `input`,
  `dialog`, `table`, `.card`, `.badge` and the like beyond variables? Justify or remove them.
- Grep your JS: does any of it open dialogs, position menus, switch tabs, show tooltips or
  toasts, or toggle visibility that an Oat component or native attribute already handles?
- Are the class names all from Oat's real utility set (see the reference), not Bootstrap or
  Tailwind look-alikes such as `.text-center`, `.mx-auto` or `.d-flex`?
- Does it work with JS disabled for everything that isn't a JS component? Does dark mode
  still look right?
- Open the page (e.g. `python3 -m http.server`) and check it at phone width and in both colour
  schemes.
