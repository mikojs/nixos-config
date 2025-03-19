# NixOS Configuration

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
* [nvim-cmp](./home-manager/neovim/nvim-cmp.nix)
    + Repository: [https://github.com/hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
    + Description: nvim-cmp is a completion plugin for Neovim.
    + Support languages:
        - `nix`
        - `nodejs`
        - `postgresql`
        - `rust`
    + Keybindings:
        - `Lsp`: `<leader>l`
            - `Show information`: `<leader>li`
            - `Show diagnostics`: `<leader>ld`
            - `Rename`: `<leader>lr`
        - `Snippet`
            - `Scroll up`: `<C-b>`
            - `Scroll down`: `<C-f>`
            - `Complete`: `<C-Space>`
            - `Abort`: `<C-e>`
            - `Confirm`: `<CR>`
            - `Select`: `<Tab>`
* [which-key-nvim](./home-manager/neovim/which-key-nvim.nix)
    + Repository: [https://github.com/folke/which-key.nvim](https://github.com/folke/which-key.nvim)
    + Description: which-key.nvim is a plugin for Neovim that shows a popup with available keybindings.
* [telescope-nvim](./home-manager/neovim/telescope-nvim.nix)
    + Repository: [https://github.com/nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
    + Description: telescope.nvim is a fuzzy finder for Neovim.
    + Keybindings:
        - `Find files`: `<leader>F`
        - `Search with grep`: `<leader>G`
        - `Show buffers`: `<leader>B`
        - `Help`: `<leader>?`
        - `Show keymaps`: `<leader>K`
        - `Show diagnostics`: `<leader>D`
        - `Git`
            - `Show git status`: `<leader>gT`
            - `Show git stash`: `<leader>gA`
            - `Show git commit`: `<leader>gC`
        - `Lsp`
            - `Go to definition`: `<leader>lD`
            - `Go to type definition`: `<leader>lT`
            - `Show references`: `<leader>lR`
            - `Go to implementation`: `<leader>lI`
            - `Show document symbols`: `<leader>lS`
* [gitsigns-nvim](./home-manager/neovim/gitsigns-nvim.nix)
    + Repository: [https://github.com/lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
    + Description: gitsigns.nvim is a git signs plugin for Neovim.
    + Keybindings:
        - `Next git hunk`: `]c`
        - `Previous git hunk`: `[c`
        - `Git`: `<leader>g`
            - `Stage git hunk`: `<leader>gs`
            - `Reset git hunk`: `<leader>gr`
            - `Stage git buffer`: `<leader>gS`
            - `Undo stage git hunk`: `<leader>gu`
            - `Reset git buffer`: `<leader>gR`
            - `Preview git hunk`: `<leader>gp`
            - `Diff this`: `<leader>gd`
            - `Diff this (cached)`: `<leader>gD`
            - `Blame line`: `<leader>gb`
            - `Toggle deleted`: `<leader>gt`
* [toggleterm-nvim](./home-manager/neovim/toggleterm-nvim.nix)
    + Repository: [https://github.com/akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
    + Description: toggleterm.nvim is a terminal plugin for Neovim.
    + Keybindings:
        - `Terminal`: `<leader>T`
            - `Toggle terminal`: `<leader>Tn`
            - `Toggle vertical terminal`: `<leader>Tv`
            - `Toggle horizontal terminal`: `<leader>Th`
            - `Toggle tab terminal`: `<leader>Tt`
            - `Send selection to terminal`: `<leader>s`
* [barbar-nvim](./home-manager/neovim/barbar-nvim.nix)
    + Repository: [https://github.com/romgrk/barbar.nvim](https://github.com/romgrk/barbar.nvim)
    + Description: barbar.nvim is a tabline plugin for Neovim.
    + Keybindings:
        - `Tab`: `<leader>t`
            - `Go to previous tab`: `<A-[>`
            - `Go to next tab`: `<A-]>`
            - `Move tab left`: `<A-,>`
            - `Move tab right`: `<A-.>`
            - `Go to tab (1-9)`: `<A-(1-9)>`
            - `Go to last tab`: `<A-0>`
            - `Sort`: `<leader>ts`
                - `Sort by buffer number`: `<leader>tsb`
                - `Sort by name`: `<leader>tsn`
                - `Sort by directory`: `<leader>tsd`
                - `Sort by location`: `<leader>tsl`
                - `Sort by window number`: `<leader>tsw`
            - `Close all tabs but current or pinned`: `<leader>to`
            - `Close left other tabs`: `<leader>tl`
            - `Close right other tabs`: `<leader>tr`
* [presistence-nvim](./home-manager/neovim/presistence-nvim.nix)
    + Repository: [https://github.com/folke/persistence.nvim](https://github.com/folke/persistence.nvim)
    + Description: persistence.nvim is a session plugin for Neovim.
    + Keybindings:
        - `Session`: `<leader>s`
            - `Load last session`: `<leader>sl`
            - `Save auto-save session`: `<leader>ss`
* [todo-comments-nvim](./home-manager/neovim/todo-comments-nvim.nix)
    + Repository: [https://github.com/folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
    + Description: todo-comments.nvim is a todo comments plugin for Neovim.
    + Keybindings:
        - `Show TODOs`: `<leader>O`
* [mini-nvim](./home-manager/neovim/mini-nvim.nix)
    + Repository: [https://github.com/echasnovski/mini.nvim](https://github.com/echasnovski/mini.nvim)
    + Description: mini.nvim is a plugin for Neovim that provides small utilities.
    + Plugins:
        - [mini.icons](https://github.com/echasnovski/mini.icons): Icon provider
        - [mini.notify](https://github.com/echasnovski/mini.notify): Show notifications
        - [mini.trailspace](https://github.com/echasnovski/mini.trailspace): Trailing space highlighter
        - [mini.files](https://github.com/echasnovski/mini.files): Navigate and manipulate files
            - `Manipulate files`: `<leader>f`
        - [mini.ai](https://github.com/echasnovski/mini.ai): Extend and create `a/i` textobjects
        - [mini.surround](https://github.com/echasnovski/mini.surround): Fast and feature-rich surround actions
        - [min.bracketed](https://github.com/echasnovski/mini.bracketed): Go forward/backward with square brackets
        - [mini.comment](https://github.com/echasnovski/mini.comment): Comment lines
        - [mini.move](https://github.com/echasnovski/mini.move): Move any selection in any direction
        - [mini.align](https://github.com/echasnovski/mini.align): Align text interactively
* [conform-nvim](./home-manager/neovim/conform-nvim/default.nix)
    + Repository: [https://github.com/stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)
    + Description: conform.nvim is a formatter plugin for Neovim.
    + Support languages:
        - `nix`: [nixfmt](https://github.com/NixOS/nixfmt)
        - `nodejs`: [prettier](https://github.com/prettier/prettier)
        - `postgresql`: [pgformatter](https://github.com/darold/pgformatter)
        - `rust`: [rustfmt](https://github.com/rust-lang/rustfmt)
* [codeium-nvim](./home-manager/neovim/codeium-nvim.nix)
    + Repository: [https://github.com/Exafunction/codeium.vim](https://github.com/Exafunction/codeium.vim)
    + Description: codeium.nvim is a plugin for Neovim that provides AI code completion.

## Languages Packages

### Nodejs

* No specific packages listed.

### Postgresql

- [pgcli](https://github.com/dbcli/pgcli): A command-line interface for PostgreSQL.

### Rust

- [crates.nvim](https://github.com/saecki/crates.nvim): A neovim plugin that helps managing crates.io dependencies.

## Custom Commands

The following custom commands are available:

* [Initialize](./overlays/custom/initialize): Initialize the system with custom settings
    + `tide`
    + `gh`
    + `tailscale`
