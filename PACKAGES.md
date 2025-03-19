# Packages

The following packages are used in this NixOS configuration. You can find more information about each package in its own file.

## [Tailscale](./nixos/tailscale.nix) - [repo](https://github.com/tailscale/tailscale)

Tailscale is used to build a private network.

## [fish](./home-manager/fish.nix) - [repo](https://github.com/fish-shell/fish-shell)

Fish is a user-friendly command line shell.

### tide - [Respoitory](https://github.com/IlanCosman/tide)

The ultimate Fish prompt.

## [gh](./home-manager/gh.nix) - [repo](https://github.com/cli/cli)

GitHub CLI is used to login to GitHub.

## [git](./home-manager/git.nix) - [repo](https://github.com/git/git)

Git is used to manage version control.

- `aliases`
    - `gr`: Show formatted git logs.

### delta - [repo](https://github.com/dandavison/delta)

A syntax-highlighting pager for git and diff output.

### cz - [repo](https://github.com/commitizen-tools/commitizen)

Commitizen is used to manage commits.

## [jless](./home-manager/jless.nix) - [repo](https://github.com/PaulJuliusMartinez/jless)

jless is a less-like pager for JSON files.

## [jq](./home-manager/jq.nix) - [repo](https://github.com/stedolan/jq)

jq is a lightweight and flexible command-line JSON processor.

## [Neovim](./home-manager/neovim/default.nix) - [repo](https://github.com/neovim/neovim)

Neovim is a Vim-fork focused on extensibility and agility.

- Keybindings:
    - `Window`: `<leader>w`
        - `Ressize height`: `<leader>wh`
        - `Increase 10 height`: `<leader>wh+`
        - `Decrease 10 height`: `<leader>wh-`
        - `Ressize width`: `<leader>ww`
        - `Increase 20 width`: `<leader>ww+`
        - `Decrease 20 width`: `<leader>ww-`

## [Tmux](./home-manager/tmux.nix) - [repo](https://github.com/tmux/tmux)

Tmux is a terminal multiplexer.

## [Tree](./home-manager/tree.nix)

Tree is a directory listing program that makes it easy to display a directory tree.
