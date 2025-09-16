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

## Fish

Fish is a user-friendly command line shell.

- [Configuration](../home-manager/fish.nix)
- [Repository](https://github.com/fish-shell/fish-shell)
- `aliases`
    - `nsf`: Run `nix-shell` with fish-shell.
    - `n8n`: Run `n8n` server with docker compose.
    - `tssh`: Run `ssh` with tailscale.
    - `tdocker`: Run `docker` with tailscale.
    - `tcoder`: Run `coder` with tailscale.

### Tide

Tide is the ultimate Fish prompt.

- [Repository](https://github.com/IlanCosman/tide)

## gh

GitHub CLI is used to login to GitHub and control repositories.

- [Configuration](../home-manager/gh.nix)
- [Repository](https://github.com/cli/cli)

### gh-poi

Safely clean up your local branches.

- [Repository](https://github.com/seachicken/gh-poi)

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

## glances

Glances is a system monitor for Linux, macOS, and Windows.

- [Configuration](../home-manager/glances.nix)
- [Repository](https://github.com/nicolargo/glances)

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

## nq

Unix command line queue utility.

- [Configuration](../home-manager/nq.nix)
- [Repository](https://github.com/leahneukirchen/nq)

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
