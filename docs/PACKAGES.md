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
