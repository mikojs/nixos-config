# Languages

[Here](../home-manager/languages/) are the specific packages for each language supported by this flake.
Basically, this flake also support those languages for `nvim-treesitter`, `nvim-cmp` and `conform.nvim`.

## Postgresql

## Sqlite

## How to add a new language

- Add a new language file to `../home-manager/languages/`.
- Neovim
    - Add a new language configuration to `../home-manager/neovim/nvim-treesitter.nix`.
    - Add a new language file to `../home-manager/neovim/nvim-cmp/`.
    - Add a new language file to `../home-manager/neovim/conform-nvim/`.
    - (Optional) Add a new language file to `../home-manager/neovim/languages/`.
