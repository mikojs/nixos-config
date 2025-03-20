# Packages

The following packages are used in this NixOS configuration.

## Tailscale

Tailscale is used to build a private network.

- [Configuration](./nixos/tailscale.nix)
- [Repository](https://github.com/tailscale/tailscale)

## Fish

Fish is a user-friendly command line shell.

- [Configuration](./home-manager/fish.nix)
- [Repository](https://github.com/fish-shell/fish-shell)

### Tide

Tide is the ultimate Fish prompt.

- [Repository](https://github.com/IlanCosman/tide)

## gh

GitHub CLI is used to login to GitHub and control repositories.

- [Configuration](./home-manager/gh.nix)
- [Repository](https://github.com/cli/cli)

## Git

Git is used to manage version control.

- [Configuration](./home-manager/git.nix)
- [Repository](https://github.com/git/git)
- `aliases`
    - `gr`: Show formatted git logs.

### Delta

A syntax-highlighting pager for git and diff output.

- [Repository](https://github.com/dandavison/delta)

### cz

Commitizen is used to manage commits.

- [Repository](https://github.com/commitizen-tools/commitizen)

## jless

jless is a less-like pager for JSON files.

- [Configuration](./home-manager/jless.nix)
- [Repository](https://github.com/PaulJuliusMartinez/jless)

## jq

jq is a lightweight and flexible command-line JSON processor.

- [Configuration](./home-manager/jq.nix)
- [Repository](https://github.com/stedolan/jq)

## Neovim

Neovim is a Vim-fork focused on extensibility and agility.

- [Configuration](./home-manager/neovim/default.nix)
- [Repository](https://github.com/neovim/neovim)
- [Plugins](./NEOVIM.md)
- Keybindings

    | Description        | Key           |
    | ---                | ---           |
    | Window             | `<leader>w`   |
    | Resize height      | `<leader>wh`  |
    | Increase 10 height | `<leader>wh+` |
    | Decrease 10 height | `<leader>wh-` |
    | Resize width       | `<leader>ww`  |
    | Increase 20 width  | `<leader>ww+` |
    | Decrease 20 width  | `<leader>ww-` |

## Tmux

Tmux is a terminal multiplexer.

- [Configuration](./home-manager/tmux.nix)
- [Repository](https://github.com/tmux/tmux)

## Tree

tree is a directory listing program that makes it easy to display a directory tree.

- [Configuration](./home-manager/tree.nix)
