# Packages

The following packages are used in this NixOS configuration. You can find more information about each package in its own file.

## [tailscale](./nixos/tailscale.nix)

Tailscale is used to build a private network.

- Repository: [https://github.com/tailscale/tailscale](https://github.com/tailscale/tailscale)

## [fish](./home-manager/fish.nix)

Fish is a user-friendly command line shell.

- Repository: [https://github.com/fish-shell/fish-shell](https://github.com/fish-shell/fish-shell)

### `tide`

The ultimate Fish prompt.

- Respoitory: [https://github.com/IlanCosman/tide](https://github.com/IlanCosman/tide)

## [gh](./home-manager/gh.nix)

GitHub CLI is used to login to GitHub.

- Repository: [https://github.com/cli/cli](https://github.com/cli/cli)

## [git](./home-manager/git.nix)

Git is used to manage version control.

- Repository: [https://github.com/git/git](https://github.com/git/git)
- `aliases`
    - `gr`: Show formatted git logs.

### `delta`

- Repository: [https://github.com/dandavison/delta](https://github.com/dandavison/delta)
- Description: A syntax-highlighting pager for git and diff output.

### `cz`

- Repository: [https://github.com/commitizen-tools/commitizen](https://github.com/commitizen-tools/commitizen)
- Description: Commitizen is used to manage commits.

## [jless](./home-manager/jless.nix)

jless is a less-like pager for JSON files.

- Repository: [https://github.com/PaulJuliusMartinez/jless](https://github.com/PaulJuliusMartinez/jless)

## [jq](./home-manager/jq.nix)

jq is a lightweight and flexible command-line JSON processor.

- Repository: [https://github.com/stedolan/jq](https://github.com/stedolan/jq)

## [neovim](./home-manager/neovim/default.nix)

Neovim is a Vim-fork focused on extensibility and agility.

- Repository: [https://github.com/neovim/neovim](https://github.com/neovim/neovim)
- Keybindings:
    - `Window`: `<leader>w`
        - `Ressize height`: `<leader>wh`
        - `Increase 10 height`: `<leader>wh+`
        - `Decrease 10 height`: `<leader>wh-`
        - `Ressize width`: `<leader>ww`
        - `Increase 20 width`: `<leader>ww+`
        - `Decrease 20 width`: `<leader>ww-`
## [tmux](./home-manager/tmux.nix)

Tmux is a terminal multiplexer.

- Repository: [https://github.com/tmux/tmux](https://github.com/tmux/tmux)

## [tree](./home-manager/tree.nix)

tree is a directory listing program that makes it easy to display a directory tree.
