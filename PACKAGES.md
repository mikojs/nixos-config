# Packages

The following packages are used in this NixOS configuration. You can find more information about each package in its own file.

## [tailscale](./nixos/tailscale.nix) - [Repository](https://github.com/tailscale/tailscale)

Tailscale is used to build a private network.

## [fish](./home-manager/fish.nix) - [Repository](https://github.com/fish-shell/fish-shell)

Fish is a user-friendly command line shell.

### tide - [Respoitory](https://github.com/IlanCosman/tide)

The ultimate Fish prompt.

## [gh](./home-manager/gh.nix) - [Repository](https://github.com/cli/cli)

GitHub CLI is used to login to GitHub.

## [git](./home-manager/git.nix) - [Repository](https://github.com/git/git)

Git is used to manage version control.

- `aliases`
    - `gr`: Show formatted git logs.

### delta - [Repository](https://github.com/dandavison/delta)

A syntax-highlighting pager for git and diff output.

### cz - [Repository](https://github.com/commitizen-tools/commitizen)

Commitizen is used to manage commits.

## [jless](./home-manager/jless.nix) - [Repository](https://github.com/PaulJuliusMartinez/jless)

jless is a less-like pager for JSON files.

## [jq](./home-manager/jq.nix) - [Repository](https://github.com/stedolan/jq)

jq is a lightweight and flexible command-line JSON processor.

## [neovim](./home-manager/neovim/default.nix) - [Repository](https://github.com/neovim/neovim)

Neovim is a Vim-fork focused on extensibility and agility.

- Keybindings:
    - `Window`: `<leader>w`
        - `Ressize height`: `<leader>wh`
        - `Increase 10 height`: `<leader>wh+`
        - `Decrease 10 height`: `<leader>wh-`
        - `Ressize width`: `<leader>ww`
        - `Increase 20 width`: `<leader>ww+`
        - `Decrease 20 width`: `<leader>ww-`

## [tmux](./home-manager/tmux.nix) - [Repository](https://github.com/tmux/tmux)

Tmux is a terminal multiplexer.

## [tree](./home-manager/tree.nix)

tree is a directory listing program that makes it easy to display a directory tree.
