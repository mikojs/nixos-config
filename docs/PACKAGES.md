# Packages

The following packages are used in this NixOS configuration.

## Tailscale

Tailscale is used to build a private network.

- [Configuration](../nixos/tailscale.nix)
- [Repository](https://github.com/tailscale/tailscale)

## Docker

Docker is used to run containers.

- [Configuration](../nixos/docker.nix)
- [Repository](https://github.com/docker/cli)

We don't support it in MacOS. [Here](https://github.com/nix-darwin/nix-darwin/issues/112) are details.
Please install it manually.

## Git

Git is used to manage version control.

- [Configuration](../home-manager/git.nix)
- [Repository](https://github.com/git/git)
- `aliases`
    - `d`: Show default `git diff` output.
    - `gr`: Show formatted git logs.

### cz

Commitizen is used to manage commits.

- [Repository](https://github.com/commitizen-tools/commitizen)

### Delta

A syntax-highlighting pager for git and diff output.

- [Repository](https://github.com/dandavison/delta)

## jless

jless is a less-like pager for JSON files.

- [Configuration](../home-manager/jless.nix)
- [Repository](https://github.com/PaulJuliusMartinez/jless)

## jq

jq is a lightweight and flexible command-line JSON processor.

- [Configuration](../home-manager/jq.nix)
- [Repository](https://github.com/stedolan/jq)

## Neovim

Neovim is a Vim-fork focused on extensibility and agility.

- [Configuration](../home-manager/neovim/default.nix)
- [Repository](https://github.com/neovim/neovim)
- [Plugins](./NEOVIM.md)
- Keybindings

    | Description        | Key           |
    | ---                | ---           |
    | Increase 10 height | `<leader>wh+` |
    | Decrease 10 height | `<leader>wh-` |
    | Increase 20 width  | `<leader>ww+` |
    | Decrease 20 width  | `<leader>ww-` |

    | Description             | Key          |
    | ---                     | ---          |
    | Copy current file path  | `<leader>cf` |
    | Copy relative file path | `<leader>cr` |

    | Description                      | Key          |
    | ---                              | ---          |
    | Toggle diagnostics virtual lines | `<leader>dt` |

## Somo

Somo is a human-friendly alternative to netstat for socket and port monitoring on Linux and macOS.

- [Configuration](../home-manager/somo.nix)
- [Repository](https://github.com/theopfr/somo)

## Tabiew

Tabiew is a lightweight TUI application to view and query tabular data files, such as CSV, TSV, and parquet.

- [Configuration](../home-manager/tabiew.nix)
- [Repository](https://github.com/shshemi/tabiew)

## Tmux

Tmux is a terminal multiplexer.

- [Configuration](../home-manager/tmux.nix)
- [Repository](https://github.com/tmux/tmux)

## Tree

tree is a directory listing program that makes it easy to display a directory tree.

- [Configuration](../home-manager/tree.nix)

## Wtfutil

WTF is the personal information dashboard for your terminal.

- [Configuration](../home-manager/wtfutil.nix)
- [Repository](https://github.com/wtfutil/wtf)
