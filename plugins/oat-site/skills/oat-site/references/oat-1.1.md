# Oat 1.1.x reference

Covers every `@knadh/oat` 1.1.x release. Compiled from the `v1.1.0` source (`src/css`,
`src/js`) and docs (`docs/content`); patch releases are fixes only and don't change anything
here. If the release check reports `outdated`, see "Updating this reference" at the end, and
trust the live docs over this file for anything that changed.

Docs: <https://oat.ink> · Source: <https://github.com/knadh/oat/tree/v1.1.0>

## Contents

- [Install](#install)
- [Elements styled with no markup](#elements-styled-with-no-markup)
- [Components](#components)
- [JavaScript API](#javascript-api)
- [Utilities](#utilities)
- [Theme variables](#theme-variables)
- [Cascade layers](#cascade-layers)
- [Partial builds](#partial-builds)
- [Renamed or removed in earlier versions](#renamed-or-removed-in-earlier-versions)
- [Recipes from the docs](#recipes-from-the-docs)
- [Extensions and companion libraries](#extensions-and-companion-libraries)
- [Updating this reference](#updating-this-reference)

## Install

```html
<link rel="stylesheet" href="https://unpkg.com/@knadh/oat@1.1.0/oat.min.css">
<script src="https://unpkg.com/@knadh/oat@1.1.0/oat.min.js" defer></script>
```

Always pin an exact version: the `pin` line from `scripts/check-release.sh`, i.e. the latest
1.1.x patch (1.1.0 above). The docs show an unversioned unpkg URL, which silently follows the
latest release. Other routes: `npm install @knadh/oat` (`import '@knadh/oat/oat.min.css'`,
`import '@knadh/oat/oat.min.js'`, or individual files from `@knadh/oat/css` and
`@knadh/oat/js`), or vendor the two files into the site:

```sh
curl -fsSLO https://unpkg.com/@knadh/oat@1.1.0/oat.min.css
curl -fsSLO https://unpkg.com/@knadh/oat@1.1.0/oat.min.js
```

(The docs' `gh-pages` download URLs are also unversioned.) The bundle is ~7 KB CSS + ~4 KB JS
gzipped. The JS is only needed for the components marked **JS** below, but it is small enough to
always include.

## Elements styled with no markup

Typography: `h1`–`h6`, `p`, `a` (no underline by default; underlined inside `p`,
`blockquote` and `figcaption`), `strong`/`b`, `em`/`i`, `small`, `code`, `pre`, `blockquote`,
`hr`, `ul`, `ol`, `li`, `mark`. Also `img`/`video`/`svg` (block, max-width 100%), `main`,
`[hidden]`, `:focus-visible` rings, and `:disabled` / `[aria-disabled="true"]`.

Forms: every `input` type, `textarea`, `select`, `label`, `fieldset`, `legend`, `progress`,
`meter`, `::file-selector-button`, `button`, `[type=submit|reset|button]`.

Also: `table` (with `thead`/`tbody`/`tfoot`), `dialog`, `details`/`summary`, `[popover]`.

There are **no** default styles for `header`, `nav` or `footer` outside the components below.
Lay these out with `.hstack`, `.container` and friends rather than adding a navbar framework.

## Components

**JS** marks the components that need `oat.min.js`.

### Button
`<button>` is primary by default. `<a class="button">` makes a link look like one.
- Variants (attribute): `data-variant="secondary"`, `data-variant="danger"`
- Styles (class): `.outline`, `.ghost`; size: `.small`, `.large`; square icon button: `.icon`
- Group: `<menu class="buttons"><li><button>…</button></li>…</menu>`
- Loading: `aria-busy="true"` (+ `disabled`), sized with `data-spinner="small"`

### Form fields
- Field wrapper: `<label data-field>Label <input> <small data-hint>Hint</small></label>`, or
  `<div data-field><label for>…</label><input id>…</div>`
- Errors: put `aria-invalid="true"` on the field wrapper (or the input) and include
  `<div class="error" role="status">Message</div>`; the `.error` is hidden until invalid.
  `:user-invalid` also styles the input.
- Switch: `<input type="checkbox" role="switch">`
- Input group: `<fieldset class="group">` around inputs, selects, buttons and `<label>`s; a
  `<legend>` becomes a leading addon.
- Disabled field: `aria-disabled` on the wrapper plus `disabled` on the input.
- Radio/checkbox groups: `<fieldset class="hstack"><legend>…</legend><label><input type="radio">…</label>…</fieldset>`

### Card
`<article class="card">` with optional `<header>` (h3 + p) and `<footer class="hstack">`.

### Alert
`<div role="alert">`; `data-variant="success|warning|error"` (`danger` also works).

### Badge
`<span class="badge">`; `data-variant="secondary|success|warning|danger"`; `.outline`.

### Avatar
`<figure data-variant="avatar" aria-label="Name"><img src alt=""></figure>` or with
`<abbr title="Name">JD</abbr>`. Sizes `.small` / `.large`. Group: wrap several in
`<figure data-variant="avatar" role="group">` (size the group to size all).

### Accordion
Native `<details><summary>…</summary>…</details>`. `name="x"` on several makes them exclusive.
No JS.

### Dialog
Native `<dialog>`, opened with `<button commandfor="id" command="show-modal">` and closed with
`command="close"`. `closedby="any"` closes on backdrop click or Escape. Structure:
`<dialog><form method="dialog"><header><h3/><p/></header><div>…</div><footer>buttons</footer></form></dialog>`.
The pressed button's `value` lands in `dialog.returnValue`; listen for `close`. oat polyfills
`commandfor` in Safari. No custom JS needed.

### Dropdown / popover (JS: `ot-dropdown`)
```html
<ot-dropdown>
  <button popovertarget="menu-id">Options</button>
  <menu popover id="menu-id">
    <button role="menuitem" class="ghost">Item</button>
    <hr>
    <a href="#" role="menuitem" class="unstyled">Link</a>
  </menu>
</ot-dropdown>
```
Positions the popover under the trigger (flipping it to stay in the viewport, and following
scroll and resize), focuses the first `role="menuitem"` on open, adds Up/Down/Home/End
navigation between items, and keeps `aria-expanded` on the trigger in sync. The popover can be any
element (`<article class="card" popover>` for a confirm popover). Close from inside with
`popovertarget="id" popovertargetaction="hide"`.

### Tabs (JS: `ot-tabs`)
```html
<ot-tabs data-anchor="settings">
  <div role="tablist"><button role="tab">A</button><button role="tab" id="b">B</button></div>
  <div role="tabpanel">…</div><div role="tabpanel">…</div>
</ot-tabs>
```
Handles arrow-key navigation and `aria-selected`. `data-anchor` plus tab `id`s deep-links the
active tab via the URL hash. Emits `ot-tab-change` with `detail: { index, tab }`.

### Tag input (JS: `ot-taginput`)
`<ot-taginput value="a, b"><input placeholder="Add tags"></ot-taginput>`. Enter or comma adds
a tag. `disabled` attribute. `.value` gets and sets an array (setting doesn't emit), `.add(v)`
adds one, and an `input` event bubbles on add/remove with `detail` set to the array.
Autocomplete: give the inner input a `list` and a `<datalist>` and fill it from `oninput`; an
`<option>` can carry an object via `option.data`. **New in 1.1:** the datalist is optional
(drop `list` and call `.add()` from any custom picker), and tags can be DOM elements or text
nodes, rendered inside the badge and deduplicated by `===`.

### Upload (JS: `ot-upload`)
```html
<ot-upload>
  <div data-field class="vstack">
    <input type="file" name="files" multiple hidden>
    <button type="button" class="ghost">Choose files</button>
    <div data-files><small data-hint>Drop files here or click to choose</small></div>
  </div>
</ot-upload>
```
Click to pick, drag and drop (sets `[data-drag]` while hovering), and selected files appear as
removable badges in `[data-files]`. The native input's `change` event fires on pick, drop and
remove, so read `input.files` as usual.

### Tooltip (JS)
The plain `title` attribute becomes a styled tooltip. `data-tooltip-placement="top|bottom|left|right"`
(default top). Replaced elements such as `<img>` and `<iframe>` need a wrapping element that
carries the `title`. It also sets an `aria-label`/`aria-description` for you.

### Toast (JS)
`ot.toast(message, title?, { variant, placement, duration })`, see the JavaScript API below.

### Sidebar layout (JS)
```html
<body data-sidebar-layout>
  <header data-topnav><button data-sidebar-toggle aria-label="Menu" class="outline">☰</button> App</header>
  <aside data-sidebar>
    <header>…</header>
    <nav><ul><li><a href="/" aria-current="page">Home</a></li>
      <li><details open><summary>Group</summary><ul>…</ul></details></li></ul></nav>
    <footer>…</footer>
  </aside>
  <main>…</main>
</body>
```
A sticky sidebar that becomes a slide-out overlay at ≤768px. `data-sidebar-layout="always"`
keeps the toggle visible and lets it collapse the sidebar at every width. `data-topnav` (on a
`nav` or `header`) is a full-width sticky top bar. `data-sidebar-open` is set on the layout
while the sidebar is open. Width: `--sidebar-width`.

### Grid
`.container` (max `--container-max: 1280px`, padding `--container-pad`) → `.row` (12-column
CSS grid, `--grid-gap: 1.5rem`) → `.col-1`…`.col-12` / `.col`, `.offset-1`…`.offset-6`,
`.col-end`. At ≤768px rows collapse to 4 columns and every column spans the full row.

### Table
Styled by default. Wrap in `<div class="table">` for horizontal scrolling on small screens.

### Progress, meter, spinner, skeleton
- `<progress value max>`, `<meter value min max low high optimum>`: native, coloured by state.
- Spinner: `aria-busy="true"` on any element; `data-spinner="small|large"`; add `overlay`
  (`data-spinner="large overlay"`) to dim the content and centre the spinner over it.
- Skeleton: `<div role="status" class="skeleton line">` or `class="skeleton box"`; put
  them in an `<article>` for a card-shaped placeholder.

### Breadcrumb and pagination (composition, no new CSS)
- Breadcrumb: `<nav aria-label="Breadcrumb"><ol class="unstyled hstack"><li><a class="unstyled">…</a></li><li aria-hidden="true">/</li>…</ol></nav>`, with `aria-current="page"` on the last link.
- Pagination: `<nav aria-label="Pagination"><menu class="buttons"><li><a class="button outline small">1</a></li>…</menu></nav>`, with the current page as `class="button small" aria-current="page"`.

## JavaScript API

The only global is `window.ot`.

| Call | Does |
|-|-|
| `ot.toast(msg, title?, opts?)` | Show a toast. `opts.variant`: `'info'` (default), `'success'`, `'danger'`, `'warning'`. `opts.placement`: `top-left`, `top-center`, `top-right` (default), `bottom-left`, `bottom-center`, `bottom-right`. `opts.duration`: ms, default `4000`, `0` = stays until dismissed |
| `ot.toast.el(elOrTemplate, opts?)` | Show custom markup: an `<output class="toast" data-variant>` with `.toast-title` and content, or a `<template>` holding one. The element is cloned, so a template can be reused |
| `ot.toast.clear(placement?)` | Remove all toasts, or only those at one placement |

Toasts stack and expand on hover. Custom elements: `ot-dropdown`, `ot-tabs`, `ot-taginput`,
`ot-upload`. Events: `ot-tab-change` (tabs), `input` (taginput), `change` (upload's file input),
and native `close` / `toggle` on dialog / popover. Components initialise themselves on connect,
including elements added to the DOM later. There is nothing to call.

The source's `OtBase` class (`src/js/base.js`) is the pattern for writing a new component in
the same style (`init()`, `cleanup()`, `handleEvent` → `on<type>`, `emit()`, `keyNav()`), but
it isn't exposed by the bundle. A site that needs it can import it from
`@knadh/oat/js/base.js` (npm) or vendor that file from the tag.

## Utilities

| Class | Effect |
|-|-|
| `.align-left` / `.align-center` / `.align-right` | Text alignment (logical start/end) |
| `.text-light` / `.text-lighter` | `--muted-foreground` / `--faint-foreground` colour |
| `.flex`, `.flex-col`, `.items-center`, `.justify-center`, `.justify-between`, `.justify-end` | Flexbox basics |
| `.hstack` | Wrapping row, centred items, `--space-3` gap, child margins reset |
| `.vstack` | Column, `--space-3` gap |
| `.gap-1` `.gap-2` `.gap-4` `.gap-6` | Gap from the space scale |
| `.mt-2` `.mt-4` `.mt-6` `.mt-8`, `.mb-2` `.mb-4` `.mb-6` `.mb-8` | Block margins |
| `.p-4` | Padding `--space-4` |
| `.w-100` | Full width |
| `ul.unstyled` / `ol.unstyled` | No bullets, no padding |
| `a.unstyled` | Inherit colour, no underline, primary on hover |

That is the complete set. There is no `.mx-*`, `.px-*`, `.text-center`, `.d-none`, `.grid`
and so on. Use the native `hidden` attribute to hide things, and a few lines of site CSS
that use the theme variables for anything else.

## Theme variables

Defined on `:root` in `src/css/01-theme.css`. Colours use `light-dark(light, dark)` with
`color-scheme: light dark`, so dark mode follows the OS automatically.

- **Colours:** `--background`, `--foreground`, `--card`, `--card-foreground`, `--primary`,
  `--primary-foreground`, `--secondary`, `--secondary-foreground`, `--muted`,
  `--muted-foreground`, `--faint`, `--faint-foreground`, `--accent`, `--danger`,
  `--danger-foreground`, `--success`, `--success-foreground`, `--warning`,
  `--warning-foreground`, `--border`, `--input`, `--ring`
- **Space:** `--space-1` (0.25rem) `-2` `-3` `-4` (1rem) `-5` `-6` `-8` `-10` `-12` `-14` `-16` `-18` (4.5rem)
- **Radius:** `--radius-small`, `--radius-medium`, `--radius-large`, `--radius-full`
- **Type:** `--font-sans` (system-ui), `--font-mono`, `--text-1` … `--text-8` (1–4 fluid
  `clamp()`, 6 = 1rem body, 8 = 0.75rem), `--text-regular`, `--leading-normal`,
  `--font-normal`, `--font-medium`, `--font-semibold`, `--font-bold`
- **Other:** `--shadow-small|medium|large`, `--transition-fast`, `--transition`,
  `--z-dropdown`, `--z-modal`, `--bar-height`
- **Component knobs:** `--grid-cols`, `--grid-gap`, `--container-max`, `--container-pad`,
  `--sidebar-width`

Theme by overriding these in a stylesheet loaded after oat:

```css
:root {
  --primary: light-dark(#1d2b4f, #c7d3f0);
  --primary-foreground: light-dark(#fafafa, #18181b);
}
```

Force a scheme with `color-scheme` on `:root` (or `document.body.style.colorScheme = 'dark'`),
not by swapping variable sets in JS. `data-variant` colours are shared: success, warning and
danger/error each map to `--_variant-color`, which alert, badge and toast all read.

## Cascade layers

Everything in oat lives in `@layer theme, base, components, animations, utilities`. Unlayered
CSS beats every layer regardless of specificity, so plain site CSS loaded after oat already
wins. Never use `!important` to override oat, and don't chase specificity. Write your rule
plainly, or put it in your own named layer declared after oat's if you want it to sit below
other unlayered CSS.

## Partial builds

`00-base.css`, `01-theme.css` and `base.js` are required. Every component file
(`button.css`, `form.css`, `dropdown.js`, …) is optional and listed in the repo's `Makefile`
in bundle order. For a minimal site, just use the full bundle: cherry-picking
saves almost nothing and gets out of step with releases.

## Renamed or removed in earlier versions

Older blog posts, LLM memory and pre-1.0 examples may use these. Don't.

| Old | Current |
|-|-|
| `.text-left` / `.text-center` / `.text-right` | `.align-left` / `.align-center` / `.align-right` |
| Badge colour classes (`.badge.success` …) | `data-variant="success"` on `.badge` |
| `data-field="error"` | `aria-invalid="true"` on the field + `.error` message |
| `[data-theme="dark"]` variable blocks swapped by JS | `light-dark()` + `color-scheme` (a `[data-theme="dark"]` override block still works if you set the attribute yourself) |
| Pseudo-element-only tooltips | Tooltips render in a `popover`; still driven by `title` |
| Brown default primary (pre-1.0) | Neutral greys; set `--primary` for brand colour |
| Toasts as separate floating boxes | Toasts always stack (1.0) |

## Recipes from the docs

Compositions oat documents (on oat.ink/recipes) using only existing pieces. Reuse these before
inventing structure:

- **Split button:** `ot-dropdown` > `menu.buttons` with the second button as the
  `popovertarget`
- **Radio cards:** `fieldset` > `.row` > `label.col-4.card.vstack` with the radio inside
- **Form card:** `article.card` > header + `label[data-field]`s + `footer.hstack.justify-end`
- **Empty state:** `article.card.align-center` with h3, `.text-light` p and a footer button
- **Stats cards:** `.container > .row > article.card.col-4` with a badge, h2 and
  progress/meter
- **Download button:** `<a href download class="button">`
- **Copy button:** `button.icon.outline` with two SVGs toggled via `hidden` and
  `navigator.clipboard`
- **Loading button:** set `aria-busy="true"` and `disabled` on submit
- **Confirm delete:** a danger outline button with `commandfor` → `<dialog closedby="any">`
  with a danger confirm button

## Extensions and companion libraries

Listed by oat itself. Check these before building the equivalent:

- [oat-chips](https://github.com/someshkar/oat-chips): dismissible/toggle chips and filters
- [oat-animate](https://github.com/dharmeshgurnani/oat-animate): `ot-animate` on-load/hover/in-view animations
- [oat-table](https://github.com/MADEVAL/Oat-Table): sort, filter and select table rows
- [oat-upload](https://github.com/MADEVAL/Oat-Upload): richer dropzone with previews, validation and progress
- knadh's zero-dependency libraries: [tinyrouter.js](https://github.com/knadh/tinyrouter.js)
  (history routing), [floatype.js](https://github.com/knadh/floatype.js) (textarea
  autocomplete), [highlighted-input.js](https://github.com/knadh/highlighted-input.js),
  [dragmove.js](https://github.com/knadh/dragmove.js),
  [indexed-cache.js](https://github.com/knadh/indexed-cache)

Third-party extensions aren't versioned with oat. Pin them too, and check they still work
against the oat version in use.

## Updating this reference

Only a new Oat minor or major makes this file outdated. When `scripts/check-release.sh`
reports `outdated` with latest version `X.Y.Z`:

```sh
git clone --depth 50 https://github.com/knadh/oat /tmp/oat && cd /tmp/oat
git fetch --tags --depth 50
git log --oneline v1.1.0..vX.Y.Z             # what changed
git diff v1.1.0 vX.Y.Z --stat -- src docs/content
git diff v1.1.0 vX.Y.Z -- docs/content src/css/01-theme.css src/css/utilities.css
```

For the task at hand, read the changed component pages under `docs/content/components/`. To
update the skill itself:

1. Rewrite this file as `oat-X.Y.md` from the tagged docs and source, adding any renames to
   the table above, and delete this one.
2. Set `version` in the plugin's `.claude-plugin/plugin.json` to `X.Y.0`. The release check
   reads it from there.
3. Update the example version in `assets/starter.html`.

Refinements to the skill between Oat releases bump only the plugin's patch number.
