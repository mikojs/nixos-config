# Languages

[Here](../home-manager/languages/) are the specific packages for each language supported by this flake.
Basically, this flake also support those languages for `nvim-treesitter`, `nvim-cmp` and `conform.nvim`.

## Nix

* No specific packages listed.

## Nodejs

* No specific packages listed.

## Postgresql

### pgcli

A command-line interface for PostgreSQL.

- [Repository](https://github.com/dbcli/pgcli)
- [Configuration](../home-manager/languages/postgresql.nix)

## Rust

### crates.nvim

A neovim plugin that helps managing crates.io dependencies.

- [Repository](https://github.com/saecki/crates.nvim)
- [Configuration](../home-manager/neovim/languages/rust.nix)

## How to add a new language

- Add a new language file to `../home-manager/languages/`.
- Neovim
    - Add a new language configuration to `../home-manager/neovim/nvim-treesitter.nix`.
    - Add a new language file to `../home-manager/neovim/nvim-cmp/`.
    - Add a new language file to `../home-manager/neovim/conform-nvim/`.
    - (Optional) Add a new language file to `../home-manager/neovim/languages/`.
