# munr0 README examples

Excerpts from munr0's own repositories, each with what it shows. They're examples of judgment
to learn from, not templates to copy. Newer READMEs (2025–2026: Git Hush, ubcworkday.ca,
fpga-asm-toolchain, TraySym, the Triangle Solver rewrite) reflect munr0's current taste better
than the 2024 ones (TI-84-prgms, LowShldPack, the first UBC-AutoLogin), which use Title Case
headings and a `# Purpose` opener that munr0 has since dropped.

---

## Workspace: AoC (whole README)

````markdown
# Advent of Code

For Julia solutions:

```sh
echo "AOC_SESSION=..." > .env   # see below
julia new.jl <day|all> [year]   # scaffold a day (or all 25) and fetch input
julia 2025/day01.jl             # run a day
```

## Getting a session cookie

Puzzle inputs are downloaded using your adventofcode.com login cookie:

1. Log into adventofcode.com in your browser.
2. Open DevTools → Application/Storage → Cookies → `https://adventofcode.com`.
3. Copy the `session` cookie value into `.env` as `AOC_SESSION=...`.

It expires after a while, at which point repeat the above.
````

- No pitch: the reader is munr0. The commands are the README.
- Inline `#` comments do the explaining.
- The only section covers the thing future-munr0 will have forgotten, and it ends with the
  gotcha ("It expires after a while…").

---

## Small tool: SIGlet (opening and usage)

````markdown
# SIGlet

Make your email signature stand out with FIGlet text banners!

This tool uses the [**big.flf**](…) FIGfont by Glenn Chappell. Signatures use HTML &lt;table&gt;
elements to prevent text wrapping for email client/device compatibility.

## Sample Output
<pre>…rendered banner…</pre>
*For a proper CSS-rich preview, see `example.html`*

## Usage

1. Edit `profile.yaml` with your contact details:
    ```yaml
    email: info@figlet.org      # creates a mailto anchor
    website: www.figlet.org     # exclude the URI scheme
    ```
2. Run the generator
3. Open the generated `signature.html` with a web browser
4. <kbd>Ctrl</kbd> <kbd>A</kbd>, <kbd>Ctrl</kbd> <kbd>C</kbd> the rendered HTML, <kbd>Ctrl</kbd> <kbd>V</kbd> into your email client
````

- One-line pitch, then the "how it works" detail that matters (tables stop wrapping).
- Credits the font author by name.
- Shows the output before the steps, because the output is the selling point.
- The config comments head off mistakes ("exclude the URI scheme").

---

## Visual mod: LowShldPack (whole README, trimmed)

```markdown
# LowShldPack
A resource pack for Minecraft Bedrock Edition that changes the first person shield model and
animations in the offhand slot to improve a player's screen visibility.

## Files
[LowShld.mcpack](LowShld.mcpack) is simply a zip of the `LowShld` folder that will extract to
the appropriate location in your game's `com.mojang` folder.

## Gallery
#### Without pack:
![before](…)
#### With pack:
![after](…)
```

- A visual change gets proven visually: before/after pairs, nothing else.
- Demystifies the one file ("simply a zip").

---

## Course tooling: fpga-asm-toolchain (opening and tasks)

```markdown
# 8051 Assembler Toolchain

A VS Code development environment for programming the CV-8052 soft processor on Terasic DE
series FPGA boards in 8051 assembly.

Serves as a drop-in replacement for [CrossIDE](…) for CPEN 312 at UBC.

**Requirements:**
- [VS Code](https://code.visualstudio.com/) (duh)
- [Quartus Prime](…) (for flashing via `quartus_stp.exe`)

| Task | Function |
|-|-|
| **Build & Flash** | Runs `a51` to assemble, then `quartus_stp` to flash via JTAG. Default build task –⁠ <kbd>Ctrl</kbd><kbd>Shift</kbd><kbd>B</kbd> |
| **Clean** | Removes generated `.hex` and `.lst` files. |

The flashing task requires the `QUARTUS_ROOTDIR` environment variable set by the Quartus Prime
installer. If it's not set, configure it manually.

## Credits

This toolchain uses the **Call51** cross-compiler and assembler by Jesus Calvino-Fraga.
```

- Names the audience and the tool it replaces in one line, so classmates know immediately.
- Each requirement says *why* it's needed. "(duh)" is the single joke, and it's dry.
- Tasks are a mapping, so they get a table, with UI names in bold.
- Names the environment-variable gotcha.
- The course tips live in a separate `CPEN312-tips.md` and are linked, not inlined.

---

## Released app: TraySym (header)

```markdown
<h1><img src="media/logo.svg" height="24px"> TraySym</h1>
<img src="media/sampleMenu.png" align="right" height="272">

[![Platform: Windows](…)](#installation)
[![License: MIT](…)](LICENSE)
[![GitHub Release](…)](…/releases/latest)
[![GitHub Downloads](…)](…/releases)

<br>
A lightweight (~44 KB), modern, customizable Windows system <br>tray application for quick
insertion of Unicode symbols and more.
<br><br>
TraySym builds to a standalone executable with all resources <br>embedded—no dependencies
required at runtime.
<br clear="both">

## Installation

### Download Release (Simple)
1. Download the `traysym.exe` executable from [Releases](…/releases/latest)
    * Save in a convenient location
1. Run `traysym.exe` to install (double-click)

### Build from Source (Customizable)
1. Install MinGW-w64, I recommend through [MSYS2](https://www.msys2.org/)
```

- History: v1 of this README was two lines. Detail, then badges, then polish ("Polish
  README" swapped a stack of `<br>`s for `<br clear="both">` and removed a placeholder
  `cd CLONELOCATION` line). Polish arrives with the release.
- Icon H1, floated hero image, a badge row whose badges all link somewhere useful.
- Two install paths labelled by what they're for ("Simple", "Customizable"), easiest first.

---

## Released extension: Git Hush (opening, features, a usage task)

```markdown
<h1><img src="img/icon.png" height="24"> Git Hush – Ignore & Exclude</h1>

[![VS Marketplace](…)](…) [![Installs](…)](…) [![License: MIT](…)](LICENSE)

A Visual Studio Code extension to hide files from Git with a right-click – just for you, or for
everyone.

Every Git repo has a private ignore file, `.git/info/exclude`, that works like `.gitignore` but
is never committed. It's perfect for your own scratch files, notes, and editor clutter. Git
Hush makes it as easy to use as `.gitignore`.

## Features

- Jump between `.gitignore` and its private counterpart with one click
- Move a rule from one file to the other with a 💡︎ quick fix
- Ignore files and folders from the Explorer right-click menu – click again to un-ignore

Handles multiple selections, keeps rules sorted, never adds duplicates, and works in worktrees
and submodules.

## Usage

### Ignore (and un-ignore) a file

Right-click any file or folder in the Explorer and open the **Ignore** submenu:

- **Ignore Locally** – adds it to `.git/info/exclude`, so it's hidden on your machine only
- **Ignore for Everyone** – adds it to `.gitignore`, so it's hidden for everyone

Both options are toggles: if the path is already listed in that file, the same option removes it.

<img src="img/context-menu.png" width="628" alt="Ignore submenu in the Explorer context menu">

## Settings

- `gitHush.showInContextMenu` – toggle the **Ignore** submenu in the Explorer (default: on)

## Tip

Install [Syler.ignore](…) for syntax highlighting in these files.
```

- The best model of current munr0 style. The pitch sentence, then the hidden fact that makes
  the tool make sense.
- Feature bullets are short verb phrases. The smaller qualities get swept into one sentence
  instead of more bullets.
- Usage headings are tasks. Each task: what to do, what each option means, the gotcha, a
  sized screenshot with alt text.
- The scaffold's Requirements / Known Issues / Release Notes sections were deleted, not filled.
- A one-line "Tip" section is fine when there's a genuinely useful tip.

---

## Website: ubcworkday.ca (whole README, trimmed)

```markdown
<h1><img src="favicon.svg" height="24"> ubcworkday.ca</h1>

[![Website](…)](https://ubcworkday.ca)
[![Link check](…)](…/actions/workflows/link-check.yml)

Quick links for UBC students – Workday, Canvas, and other tools.

Some UBC tools, like Workday, aren't indexed and don't show up in search engine results.
[*ubcworkday.ca*](https://ubcworkday.ca) does, so searching "UBC Workday" gets you there.

*Not affiliated with the University of British Columbia.*

## Development

Plain HTML/CSS – no build step. GitHub Pages serves `master` directly, so every push goes
live; `_config.yml` keeps repo-only files off the site.

Preview locally with <kbd>Ctrl</kbd> <kbd>Shift</kbd> <kbd>B</kbd> in VS Code – a
live-reloading server at `localhost:8000` (needs [Node.js](https://nodejs.org)).

## CI

[lychee](…) checks every link on the page, including ubcworkday.ca itself:

- Runs every Monday, and on any change to the page, icons, or check config
- Opens a `stale-links` issue when a link dies, or comments on the one already open
- Closes the issue once every link passes again
```

- The why-it-exists paragraph is a single non-obvious fact and its consequence.
- Development explains the deploy model in a sentence, including the consequence ("every push
  goes live").
- CI is described by behaviour (when it runs, what it does on failure, when it recovers), not
  by restating the YAML.

---

## Released calculator program: Ti-84-Triangle-Solver (fragments)

```markdown
A triangle-solving program for the TI-84 Plus CE line of calculators featuring robust error
handling and an intuitive GUI.

Given 3 dimensions of a triangle, the program will solve the remaining dimensions and render a
geometrically proportional triangle, similar to a tool like http://cossincalc.com.

### Special Keys
- `[+]` – display help menu
- `[CLEAR]` – gracefully quit program (erase plot)
- `[MODE]` – toggle between degree and radian modes

## Files
- `*.8xp` – native TI-BASIC binary source code
- `TRIG.bas` – minimal TI-BASIC source code, in ASCII form
- `TRIG-commented.txt` – source code with descriptive comments
```

- Anchors the pitch to something the reader already knows ("similar to … cossincalc.com").
- Keys in the calculator's own notation.
- A HTML `<table>` was used where the on-screen layout itself needed to be mirrored (keypad
  positions). Reach for HTML only when Markdown can't show the shape.
- A Files section explains why there are three copies of the source.
