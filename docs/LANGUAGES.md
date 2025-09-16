# Languages

[Here](../home-manager/languages/) are the specific packages for each language supported by this flake.
Basically, this flake also support those languages for `nvim-treesitter`, `nvim-cmp` and `conform.nvim`.

## Nix

* No specific packages listed.

## Nodejs

### package-info.nvim

A neovim plugin that provides information about npm packages.

- [Repository](https://github.com/vuki656/package-info.nvim)
- [Configuration](../home-manager/neovim/languages/nodejs.nix)
- Keybindings

    | Description               | Key          |
    | ---                       | ---          |
    | Enable or disable info    | `<leader>nt` |
    | Update dependency         | `<leader>nu` |
    | Change dependency version | `<leader>nc` |

## Rust

### crates.nvim

A neovim plugin that helps managing crates.io dependencies.

- [Repository](https://github.com/saecki/crates.nvim)
- [Configuration](../home-manager/neovim/languages/rust.nix)
- Keybindings

    | Description             | Key          |
    | ---                     | ---          |
    | Reload data             | `<leader>CR` |
    | Enable or disable info  | `<leader>Ct` |
    | Expand crate            | `<leader>Ce` |
    | Upgrade crate           | `<leader>Cu` |
    | Open homepage           | `<leader>Ch` |
    | Open repository         | `<leader>Cr` |
    | Open documentation      | `<leader>Cd` |
    | Open crates.io          | `<leader>Cc` |
    | Show crate details      | `<leader>Cs` |

## DB

Common database packages, plugins and configurations are provided in the `db` files.

- [language configuration](../home-manager/languages/db.nix)
- [nvim-cmp configuration](../home-manager/neovim/nvim-cmp/db.nix)
- [conform.nvim configuration](../home-manager/neovim/conform-nvim/db.nix)

### sqls.nvim

A neovim plugin for SQL.

- [Repository](https://github.com/nanotee/sqls.nvim)
- [Configuration](../home-manager/neovim/nvim-cmp/db.nix)

```nvim
:Sqls...
```

## Postgresql

### pgcli

A command-line interface for PostgreSQL.

- [Repository](https://github.com/dbcli/pgcli)
- [Configuration](../home-manager/languages/postgresql.nix)

## Sqlite

### litecli

A command-line interface for SQLite.

- [Repository](https://github.com/dbcli/litecli)
- [Configuration](../home-manager/languages/sqlite.nix)

## How to add a new language

- Add a new language file to `../home-manager/languages/`.
- Neovim
    - Add a new language configuration to `../home-manager/neovim/nvim-treesitter.nix`.
    - Add a new language file to `../home-manager/neovim/nvim-cmp/`.
    - Add a new language file to `../home-manager/neovim/conform-nvim/`.
    - (Optional) Add a new language file to `../home-manager/neovim/languages/`.
