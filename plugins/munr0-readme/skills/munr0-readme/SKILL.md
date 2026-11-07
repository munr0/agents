---
name: munr0-readme
description: Write, revise or review a README in munr0's (Munro Anderson's) style. Use whenever creating or editing a README.md for one of munr0's repositories, or when asked to "write a README", "polish the README", "update the docs for release" or similar in a munr0 project. Calibrates length, polish and sections to the project's field, scope and maturity instead of applying a fixed template.
---

# munr0 README

There is no template. munr0's READMEs share a voice and a set of instincts, and each one is
shaped by what the project *is*: an Advent of Code scratch repo gets a command block, a
released Windows app gets an icon, badges and a floated screenshot. Your job is to make the
calls munr0 would make, not to fill in sections.

`references/examples.md` has annotated excerpts from munr0's real READMEs. Read it before
writing anything longer than a few lines.

## Workflow

1. **Learn the project from the code, not from guesses.** Read the manifest
   (`package.json`, `*.toml`, build scripts, VS Code `contributes`, `manifest.json`), the entry
   point and any config the user edits. Find out what the user actually runs, clicks or
   installs. Never document a command, flag, setting or feature you haven't seen in the repo.
2. **Read the existing README and its git history** (`git log -p -- README.md`). If munr0 has
   already written prose, keep their wording wherever it's still true. Revise; don't replace.
3. **Place the project** on the scale below and decide how far the README should go.
4. **Draft**, then run the checks at the end of this file.
5. **Report what you couldn't fill.** If a screenshot, release link or badge target doesn't
   exist yet, say so to the user instead of inventing paths or URLs.

## Scale it to the project

Before writing, answer three questions. Together they set the ceiling on length and polish.

**Who reads it?** Only munr0 (a workspace), a narrow audience (a UBC course, a game's players),
or anyone who finds it (a marketplace listing, a public site).

**How mature is it?** Prototype → works for munr0 → released (has a Releases page, a
marketplace listing or a live URL). munr0's READMEs grow *with* the project: TraySym's first
README was two lines ("A lightweight symbol picker for the Windows system tray.") and got the
icon, badges and screenshots at release. Git Hush's `yo code` boilerplate was deleted wholesale,
not filled in. Don't dress a prototype as a product. Don't leave a shipped product with a
prototype's README.

**What field is it in?** Each ecosystem has its own idiom, and munr0 follows it:

| Field | Idioms munr0 uses |
|-|-|
| VS Code extension | Marketplace version/installs badges; a **Settings** section as `` `ext.key` – what it does (default: on) ``; keys as <kbd>Ctrl</kbd>+<kbd>.</kbd> (<kbd>Cmd</kbd>+<kbd>.</kbd> on macOS) |
| Windows app | `cmd` code fences, `.\build.bat`; "Add to startup at Windows Settings > Apps > Startup"; simple download path before build-from-source |
| Chrome extension | Numbered `chrome://extensions/` → developer mode → load unpacked steps |
| Calculator programs | Keys in calculator notation, `[PRGM]`, `[ENTER]`, `[◄]`; LaTeX (`$\vec{\text R}$`) for maths |
| Course tooling | Name the course and the tool it replaces ("drop-in replacement for CrossIDE for CPEN 312 at UBC"); link course references |
| Website | Live-site and CI badges; how it deploys, how to preview, what CI checks; a disclaimer if it could be mistaken for official |
| Game mod / asset | Visual before/after gallery; explain the single file the player installs |
| Personal workspace | Commands to run, plus the one non-obvious setup step. Nothing else |

Rough tiers, as a sense of proportion rather than a checklist:

- **Workspace / scratch** (AoC): a title, the command block with inline comments, and a section
  for the single thing that will trip you up next year (the session cookie). ~20 lines.
- **Small single-purpose tool** (SIGlet, LowShldPack): one pitch sentence, then whatever shows
  it best (sample output, a gallery), how to use it, requirements. Plain `# Title`.
- **Niche or collection** (fpga-asm-toolchain, TI-84-prgms): scoped to its audience. A table
  when the content is a mapping (tasks → what they do, outputs → meaning); per-item sections
  for collections, each with one line, usage and a screenshot.
- **Released product** (TraySym, Git Hush, Triangle Solver, ubcworkday.ca): icon in the H1,
  a badge row, a right-floated hero image, Features, Installation (easiest path first), Usage
  broken into the real tasks, Settings or Customization. Still lean: everything earns its place.

When a project sits between tiers, lean smaller. munr0 adds polish when the project ships.

## Voice

- **Open with one plain sentence that says what it is and does**, often with one concrete,
  specific detail: "A lightweight (~44 KB), modern, customizable Windows system tray
  application…", "…hide files from Git with a right-click – just for you, or for everyone."
- **Then say why it exists, usually against the obvious alternative or a hidden fact.** "Unlike
  Chrome password autofill, this extension automatically *submits*…" "Some UBC tools, like
  Workday, aren't indexed… *ubcworkday.ca* does." "Every Git repo has a private ignore file…
  Git Hush makes it as easy to use as `.gitignore`." This paragraph is the heart of a good munr0
  README; get the insight right.
- **Direct, practical, a little casual.** Short sentences. Second person for instructions.
  Occasional first person for a real recommendation ("I recommend through MSYS2"). A dry aside
  is fine when it's earned and rare: "(duh)", "Personalize at will!", "do yourself a favor", ":)".
  No hype words ("blazing", "powerful", "seamless", "revolutionary"), no exclamation-mark
  enthusiasm in every section.
- **Precise about behaviour, especially the gotcha.** munr0 spells out the detail a user would
  otherwise discover the hard way: "Both options are toggles: if the path is already listed…
  the same option removes it." "Missing files are created for you." "Consecutive duplicate
  symbols automatically merge into one wider button." "It expires after a while, at which point
  repeat the above." Find the equivalent for this project.
- **Honest about mechanism.** Say how something works when the user would care (where the
  credentials are stored, what CI does when a link dies, that a `.mcpack` is "simply a zip").
- **Credit upstream by name** when the project bundles or depends on someone's work (Glenn
  Chappell's big.flf FIGfont; Jesus Calvino-Fraga's Call51, with a pointer to its licence).
- **Italic one-line disclaimer** where needed: "*Not affiliated with the University of British
  Columbia.*"

## Formatting habits

- Spaced en dash ` – ` for asides and in list items (`**Ignore Locally** – adds it to…`).
- `<kbd>` for every key or chord: <kbd>Ctrl</kbd> <kbd>Shift</kbd> <kbd>B</kbd>.
- **Bold** for UI labels the user clicks or reads on screen; `code` for files, paths, commands,
  settings keys and config values.
- Numbered steps for procedures (repeated `1.` is fine and common); bullets for features and
  options. Nest a sub-step rather than writing a paragraph inside a step.
- Inline comments in code blocks to explain config and commands instead of prose after them.
- Tables for mappings, with the compact `|-|-|` separator.
- Headings in sentence case and phrased as tasks where possible ("Ignore (and un-ignore) a
  file", "Getting a session cookie", "Jump between files").
- Images: for released projects, an icon in the title (`<h1><img src="…" height="24"> Name</h1>`)
  and a hero screenshot floated right (`<img src="…" align="right">`, then `<br clear="both">`
  before the next heading). Inline screenshots get explicit `width` and real `alt` text. Use
  images that exist in the repo; don't invent paths.
- Badges only once there's something to point at (a release, a marketplace listing, a live
  site, a CI workflow), placed right under the title. Use them sparingly: three or four at most.
- Emoji only when it names something the user will actually see (🧩 for Chrome's extensions
  button, 💡︎ for the quick-fix lightbulb). Never as section decoration.

## What munr0 leaves out

These show up in generic READMEs and are absent from every munr0 one:

- Table of contents, "About", "Overview" or "Introduction" headings above the pitch
- Contributing, Code of Conduct, Roadmap, Known Issues, Changelog or Release Notes sections
  (release notes live in GitHub Releases)
- A "License" section restating the LICENSE file (a licence badge is enough)
- "Built with" or tech-stack badge walls; marketing taglines; "Star this repo"
- Placeholder sections waiting to be filled ("Coming soon", "TODO")
- Repeating the same instruction in Features, Usage and an FAQ

If a section has nothing specific to say about *this* project, cut it.

## Before you finish

- Does the first sentence say what it is, and the next paragraph say why it's worth using?
- Is the length right for the tier, and smaller rather than larger when in doubt?
- Is every command, setting, key and path real and copied from the repo?
- Did you name the one gotcha a user will hit?
- Did you keep munr0's existing wording where it's still accurate?
- Are images and badges pointing at things that exist? List any that are missing in your reply.
- Read it once as the intended reader (a classmate, a marketplace browser, munr0 a year from
  now). Anything they'd skip should go.
