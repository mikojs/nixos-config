---
paths:
  - "**/*.nix"
---

# `miko.getDocs` topic roster

The `## <topic>` heading in a `miko.getDocs` `docs` string (see `miko-getdocs.md`) must
be one of the following. Don't invent a new one — if none fit, that's a sign the entry
needs a heading added here, or belongs to a domain-specific extension (see
`miko-getdocs.md`'s "Closing the `## <topic>` list").

- **Alias** — shell/tool aliases the entry's package installs or configures.
- **Support packages** — a language server, formatter, or CLI the entry shells out to;
  see `miko-getdocs.md`'s "Adding a package".
- **Keybindings** — a key mapping the entry adds or overrides, in whatever tool it
  belongs to — not exclusive to an editor.
- **Appearance** — a non-default visual this repo bakes into the tool (a theme file, an
  added status-bar segment) that upstream doesn't ship by default.
- **Gotcha** — something about this entry that surprises the user relative to what
  they'd assume (an unsupported platform, a non-default version/variant, a missing
  feature) and what to do about it.
