# NixOS Configuration

## Installation

To install NixOS, run the following command:

```bash
nixos-rebuild switch --flake .#<system>
```
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
