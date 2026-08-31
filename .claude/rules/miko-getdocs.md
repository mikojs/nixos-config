---
paths:
  - "**/*.nix"
---

# `miko.getDocs`

`miko.getDocs [ { filePath, docs } ]` writes `~/.docs/<filePath>.md` onto the user's
machine. It is what the person *using* this machine reads — not a description of the Nix
code. Write for someone who already has the tool installed and needs to know what it is,
where the real documentation lives, and what will bite them.

## Every entry must have

1. `# Title` — what the user would call the tool, not the Nix attribute name.
2. One sentence saying what it is. Upstream's own tagline is fine.

Both must be literal text, and so must the link. Interpolation belongs inside a
`## <topic>` section — the generated alias lists in `home-manager/fish/default.nix`
and `home-manager/tmux/default.nix` do exactly this. An entry whose title, sentence,
or link only appears on one branch of an `if` is a doc that silently changes shape
per host.

## Links

**An entry that packages an external tool must carry an upstream link** — a user who
wants the real manual has nowhere else to go:

- `[Repository](…)` — upstream source
- `[Website](…)` / `[Homepage](…)` — upstream site

An entry for something defined in this repo (an agent, a skill, a custom script) has no
upstream. Where it points at code, the convention is `[Code](…)` linking the file or
folder on GitHub.

## Adding a package

Anything added to `home.packages` is accounted for in the same file. Without that the
user has a binary on their PATH and nothing telling them where it came from.

Two ways to account for one:

- **Its own `getDocs` entry** — for a package the user reaches for directly.
- **A line under `## Support packages`** in the entry for the package it backs — for a
  language server, a formatter, or a CLI the parent shells out to. One line, saying what
  pulls it in: `` - `ripgrep`: Grep pickers shell out to `rg`. ``

Where the backing packages depend on the host's languages, the language modules each
carry their own `support` lines and the parent interpolates the list — see
`neovim/conform-nvim` and `neovim/nvim-cmp`.

## Warnings and reminders

Anything the user has to *act on* — a prerequisite, a keybinding that differs from the
tool's default, a gotcha — belongs in the doc, not only in a commit message. Two places
to put it:

- **A `## <topic>` section in the `docs` string** — for behaviour this repo itself
  configures, e.g. the `## Tmux customize` keybindings in `home-manager/ai/claude`.
- **A `<name>-note` overlay attribute** — `getDocs` appends `pkgs.<name>-note` to the
  generated file when it exists, `<name>` being the last segment of `filePath`. This is
  how a repo annotates a doc it does not own; in `hsuting/nixos-config` these live in
  `overlays/note.nix`.
