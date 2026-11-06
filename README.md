# agents

Skills and tooling for my coding agents, packaged as a [Claude Code](https://claude.com/claude-code) plugin marketplace.

```sh
/plugin marketplace add munr0/agents
/plugin install munr0-readme@munr0
/plugin install oat-site@munr0
```

## Plugins

| Plugin | Skill |
|-|-|
| [**munr0-readme**](plugins/munr0-readme) | Writes and revises READMEs in my style – scaled to the project's field, scope and maturity rather than a fixed template. Annotated examples from my repos in [`references/examples.md`](plugins/munr0-readme/skills/munr0-readme/references/examples.md). |
| [**oat-site**](plugins/oat-site) | Builds minimal sites on [Oat](https://oat.ink) without re-implementing components it already ships or working against its semantic-HTML approach. Bundles an API reference for the current Oat minor and checks it against the latest release before each use. |

## Layout

```
.claude-plugin/marketplace.json     # lists every plugin
plugins/<plugin>/
  .claude-plugin/plugin.json
  skills/<skill>/SKILL.md           # plus references/, scripts/, assets/ as needed
```

New plugins go under `plugins/` and get an entry in `marketplace.json`.

## Updating

Bump `version` in a plugin's `plugin.json` with every change – installs compare that field, so an unbumped push won't reach them. Then on each machine:

```sh
/plugin marketplace update munr0
```

While editing a skill, skip the install and load it straight from disk with `claude --plugin-dir plugins/<plugin>`.

## Keeping oat-site current

The plugin's version tracks Oat: major.minor is the Oat release the reference covers, patch is my own refinements in between. Oat's patch releases are fixes only, so the skill stays current through them – it just pins new sites to the latest patch.

[`check-release.sh`](plugins/oat-site/skills/oat-site/scripts/check-release.sh) reads the covered version from `plugin.json` and flags a new Oat minor or major on use. To catch up, follow *Updating this reference* at the bottom of [`oat-1.1.md`](plugins/oat-site/skills/oat-site/references/oat-1.1.md).
