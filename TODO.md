# TODO: port missing usage docs into `miko.getDocs` entries

Context: `hsuting/nixos-config` just closed the section list for its own vault
(`docs/`) — every entry may only use a fixed set of `##` headings (`Purpose`,
`Behaviour`, `Why <decision>`, `See also`, plus a couple of category-specific
additions). Auditing against that list surfaced several vault entries that
document *this* repo's packages and hold bare invocation syntax that has no
counterpart in the actual deployed `~/.docs/*` doc (built by `miko.getDocs`
here). That's backwards — usage syntax is deployed-layer material (see
`.claude/rules/miko-getdocs.md`'s own scope), so the vault content should be
trimmed and this repo's `getDocs` entries should carry it instead.

**Before doing this**, note this repo already has an established heading
vocabulary in `## <topic>` sections — don't invent `## Usage`. A quick survey
of existing entries found:

- `## Alias` — `git.nix`, `home-manager/ai/gitnexus.nix`, `home-manager/tmux/`,
  `home-manager/fish/default.nix`
- `## Keybindings` — most `neovim/*.nix` plugin modules, `ai/claude/default.nix`
- `## Gotcha` — `languages/nodejs.nix`, `fish/default.nix`
- `## Support packages` — several `neovim/*.nix`, `languages/rust.nix`,
  `fish/custom.nix`
- `## Appearance` — `tmux/tmux-powerline/default.nix`, `ai/claude/default.nix`

Whatever heading fits (`## Alias` looks like the closest match for a bare
invocation line) should follow that existing pattern, not a new one. It may
also be worth writing a `.claude/rules/miko-getdocs-*.md` companion (the
"Closing the `## <topic>` list" mechanism added in #232) if this vocabulary
should become a closed list — that's this repo's own call to make.

## Packages missing usage entirely (no existing `getDocs` content to overlap)

**Resolved 2026-09-15.** A bare invocation is only worth documenting when the
command differs from the package/attribute name — when they match, the title
line (`# Bottom`, `# Tree`, …) already tells the user what to type, so a
one-liner repeating it is redundant. Checked against `tabiew.nix` (`tw`) and
`git/commitizen` (`git cz`) as precedent for "command differs from package
name," but since these are single differing command names (not multi-arg
aliases-with-description), they fit `## Alias` (`- \`name\`: one line.`)
better than a bare code fence.

- `home-manager/bottom.nix` — **done**: `## Alias` — `` `btm`: Run bottom. ``
- `home-manager/mermaid.nix` — **done**: `## Alias` — `` `mmdc`: Render a
  diagram, e.g. `mmdc -i input.mmd -o output.svg`. ``
- `home-manager/jq.nix` (`jq`), `home-manager/tree.nix` (`tree`),
  `home-manager/glow.nix` (`glow`), `home-manager/jless.nix` (`jless`),
  `home-manager/oxker.nix` (`oxker`), `home-manager/somo.nix` (`somo`),
  `home-manager/fastfetch.nix` (`fastfetch`) — **decided: no change.** Command
  name equals the package name in each case, so there's nothing non-obvious to
  add.

## Missing a plugin/support-package roster

**Resolved 2026-09-15: no change.** `home-manager/neovim/default.nix`'s import
list (lines ~19-42) already groups plugins with `# Colorschema` / `# UI` /
`# Lsp` / `# Editor` / `# Viewer` / `# Coding` / `# Formatting` / `# AI`
comments — a complete match for the vault's categorized breakdown. Decided
that duplicating this into the user-facing `getDocs` string isn't worth it:
each plugin already has its own `getDocs` entry, and reusing `## Support
packages` for it would misuse that heading (`miko-getdocs-topics.md` scopes it
to CLIs the entry shells out to, not bundled plugins) — inventing a new
`## Plugins` heading just to restate existing comments was judged not worth
the churn. Vault's `neovim.md` `### Plugin Categories` table is therefore
**not** a duplicate and should stay as-is.

## Partial — has a bare link/one-liner, vault has more detail worth folding in

- `home-manager/git.nix` (`git/serie` entry) — **done 2026-09-15**: added
  `## Gotcha` — `gr` (the `git` alias) purges local tags before running serie,
  since serie errors out when there are too many tags.
- `home-manager/ai/gitnexus.nix` — **done 2026-09-15**: `## Alias` bullet now
  reads `` `ga (-c|--claude) (-v|--antigravity) (-a|--all)`: … With no flag,
  both are configured. ``

## Already fine, vault should just delete its copy (no repo change needed here)

- `home-manager/tabiew.nix` — already has a bare `` tw ... `` snippet.
- `home-manager/git.nix` (`git/commitizen` entry) — already has `` git cz ``.
- `home-manager/neovim/default.nix` — already carries the full Keybindings
  tables (window resizing, copy path, diagnostics toggle) verbatim; the vault
  copy is a pure duplicate.

## Fish-alias-based commands — resolved pattern, apply it to `tailscale.nix`

**Deferred 2026-09-15.** Blocked on the vault content (step 3 below needs the
`docs/mikojs/nixos-config/fish/tailscale.md` `### tssh` / `### tdocker` /
`### tcoder` subsections) — `hsuting/nixos-config` isn't checked out on this
machine, and fetching it from GitHub or rewriting the usage from scratch was
declined for this session. Revisit once that content is available.

`cr`, `sc`, `etdr`/`etsdr`, `dcm-run` (hsuting-side) and this repo's
`tssh`/`tdocker`/`tcoder` (`home-manager/fish/tailscale.nix`) all render into
one shared `~/.docs/fish.md` "External Alias" list — one bullet line per
alias, not a per-command doc. The vault copies carried much richer detail
(multi-line usage, step-by-step behaviour) that doesn't fit that shared,
terse format.

`hsuting/nixos-config` already resolved this for its own four commands — use
the same pattern here for `tssh`/`tdocker`/`tcoder`:

1. Keep the existing one-line `fish-alias` bullet for each command exactly as
   is (don't touch the shared list's terseness).
2. Append a pointer to the end of that line: `` — see `~/.docs/commands/tssh.md` ``
   (etc. for `tdocker`, `tcoder`).
3. Give each command its own `miko.getDocs` entry (`filePath =
   "commands/tssh"`, etc.) carrying the full usage block currently only in
   the vault (`docs/mikojs/nixos-config/fish/tailscale.md`'s `### tssh` /
   `### tdocker` / `### tcoder` subsections).
4. Wire the new entries into `home.file = miko.getDocs [...]` in
   `home-manager/fish/tailscale.nix` (or wherever its home-manager module is
   assembled) the same way `user-packages/fish/default.nix` does it in
   `hsuting/nixos-config` — that file is the reference implementation.

After this lands, `hsuting/nixos-config`'s `docs/mikojs/nixos-config/fish/tailscale.md`
should have its per-command usage blocks trimmed to match (same as its own
`docs/hsuting/commands/*.md` files already were).

## After any of the above lands: trim the hsuting vault copies

Once a package/command above actually gets its usage content in this repo's
`getDocs` output, go back to the matching `docs/mikojs/nixos-config/**/*.md`
file in `hsuting/nixos-config` and remove the now-duplicated `## Behaviour`
content — it was left in place only because this repo didn't have the content
yet.

- **Ready to trim now (2026-09-15):** `packages/bottom.md`, `packages/mermaid.md`,
  `git/serie.md`, `ai/gitnexus.md`.
- **Not a duplicate — leave as-is:** `packages/{jq,tree,glow,jless,oxker,somo,
  fastfetch}.md` (this repo decided not to add that content — see "Packages
  missing usage entirely" above) and `neovim.md`'s `### Plugin Categories`
  table (this repo decided its import-list comments are enough — see "Missing
  a plugin/support-package roster" above; there is no repo-side counterpart to
  duplicate it).
- **Still blocked:** `fish/tailscale.md` — waiting on `tailscale.nix` itself
  (see "Fish-alias-based commands" above).
