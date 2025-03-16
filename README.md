# NixOS ConfiguratioC

## Installation

To install NixOS, run the following command:

```bash
nixos-rebuild switch --flake .#<system>
```

### VMware

* [i3](./nixos/specialization/i3.nix)
    + Repository: [https://github.com/i3/i3](https://github.com/i3/i3)
    + Description: i3 is a tiling window manager.
* [openssh](./nixos/openssh.nix)
    + Description: OpenSSH is a secure remote login tool.
* [fcitx5](./nixos/fcitx5.nix)
    + Repository: [https://github.com/fcitx/fcitx5](https://github.com/fcitx/fcitx5)
    + Description: fcitx5 is a free and open source input method framework.
* [rofi](./nixos/rofi.nix)
    + Repository: [https://github.com/davatorium/rofi](https://github.com/davatorium/rofi)
    + Description: rofi is a window switcher, application launcher and dmenu replacement.
* [chromium](./nixos/chromium.nix)
    + Repository: [https://github.com/chromium/chromium](https://github.com/chromium/chromium)
    + Description: Chromium is a web browser from Google.

### WSL

* No specific packages listed.

## Packages

The following packages and repositories are used in this NixOS configuration:

* [tailscale](./nixos/tailscale.nix)
    + Repository: [https://github.com/tailscale/tailscale](https://github.com/tailscale/tailscale)
    + Description: Tailscale is used to build a private network.
* [fish](./home-manager/fish.nix)
    + Repository: [https://github.com/fish-shell/fish-shell](https://github.com/fish-shell/fish-shell)
    + Description: Fish is a user-friendly command line shell.
    + `tide`
        - Respoitory: [https://github.com/IlanCosman/tide](https://github.com/IlanCosman/tide)
        - Description: The ultimate Fish prompt.
* [gh](./home-manager/gh.nix)
    + Repository: [https://github.com/cli/cli](https://github.com/cli/cli)
    + Description: GitHub CLI is used to login to GitHub.
* [git](./home-manager/git.nix)
    + Repository: [https://github.com/git/git](https://github.com/git/git)
    + Description: Git is used to manage version control.
    + `delta`
        - Repository: [https://github.com/dandavison/delta](https://github.com/dandavison/delta)
        - Description: A syntax-highlighting pager for git and diff output.
    + `cz`
        - Repository: [https://github.com/commitizen-tools/commitizen](https://github.com/commitizen-tools/commitizen)
        - Description: Commitizen is used to manage commits.
    + `aliases`
        - `gr`: Show formatted git logs.
* [jless](./home-manager/jless.nix)
    + Repository: [https://github.com/PaulJuliusMartinez/jless](https://github.com/PaulJuliusMartinez/jless)
    + Description: jless is a less-like pager for JSON files.
* [jq](./home-manager/jq.nix)
    + Repository: [https://github.com/stedolan/jq](https://github.com/stedolan/jq)
    + Description: jq is a lightweight and flexible command-line JSON processor.
* [neovim](./home-manager/neovim/default.nix)
    + Repository: [https://github.com/neovim/neovim](https://github.com/neovim/neovim)
    + Description: Neovim is a Vim-fork focused on extensibility and agility.
    + Keybindings:
        - `Window`: `<leader>w`
        - `Ressize height`: `<leader>wh`
        - `Increase 10 height`: `<leader>wh+`
        - `Decrease 10 height`: `<leader>wh-`
        - `Ressize width`: `<leader>ww`
        - `Increase 20 width`: `<leader>ww+`
        - `Decrease 20 width`: `<leader>ww-`
* [tmux](./home-manager/tmux.nix)
    + Repository: [https://github.com/tmux/tmux](https://github.com/tmux/tmux)
    + Description: Tmux is a terminal multiplexer.
* [tree](./home-manager/tree.nix)
    + Description: tree is a directory listing program that makes it easy to display a directory tree.

### Neovim

The following Neovim plugins are used in this NixOS configuration:

* [tokyonight-nvim](./home-manager/neovim/tokyonight-nvim.nix)
    + Repository: [https://github.com/folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
    + Description: tokyonight.nvim is a color scheme for Neovim.
* [lualine-nvim](./home-manager/neovim/lualine-nvim.nix)
    + Repository: [https://github.com/nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
    + Description: lualine.nvim is a statusline plugin for Neovim.
* [nvim-treesitter](./home-manager/neovim/nvim-treesitter.nix)
    + Repository: [https://github.com/nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
    + Description: nvim-treesitter is a syntax highlighting plugin for Neovim.

## Custom Commands

The following custom commands are available:

* [Initialize](./overlays/custom/initialize): Initialize the system with custom settings
    + `tide`
    + `gh`
    + `tailscale`
