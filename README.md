# NixOS Configuration

Here is my NixOS configuration.

## Before installing

Some steps are required before installing NixOS.

### WSL

- Follow the instructions in [NixOS-WSL](https://github.com/nix-community/NixOS-WSL).
- Install the [MesloLGS NF](https://github.com/IlanCosman/tide?tab=readme-ov-file#fonts) font.

## Installation

Set up `git` and `ssh` keys.

```bash
nix-shell -p git <other packages you need> # use any method you like to set up `ssh` keys
```

Install the NixOS configuration.

```bash
# `--install-bootloader` for VMware first time
nixos-rebuild switch --flake github:mikojs/nixos-conifg#<wsl>

# Reboot or reopen the terminal and it would auto run the `initialize` command
```

After installing, you need to authorize `Codeium` in `nvim` manually.

```nvim
:Codeium Auth
```

Here are the packages I use.

- [Common](./docs/PACKAGES.md)
- [Languages](./docs/LANGUAGES.md)
- [Custom commands](./docs/CUSTOM_COMMANDS.md)
