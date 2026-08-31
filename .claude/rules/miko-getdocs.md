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

Anything added to `home.packages` gets a `getDocs` entry in the same file. Without one
the user has a binary on their PATH and nothing telling them where it came from.

## Warnings and reminders

Anything the user has to *act on* — a prerequisite, a keybinding that differs from the
tool's default, a gotcha — belongs in the doc, not only in a commit message. Two places
to put it:

- **A `## <topic>` section in the `docs` string** — for behaviour this repo itself
  configures, e.g. the `ssm` wrapper in `user-packages/awscli.nix`.
- **A `<name>-note` overlay attribute** — `getDocs` appends `pkgs.<name>-note` to the
  generated file when it exists, `<name>` being the last segment of `filePath`. This is
  how a repo annotates a doc it does not own; in `hsuting/nixos-config` these live in
  `overlays/note.nix`.
