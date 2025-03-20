# NixOS Configuration

Here is my NixOS configuration.

## Before installing

Some steps are required before installing NixOS.

### WSL

- Follow the instructions in [NixOS-WSL](https://github.com/nix-community/NixOS-WSL).
- (Optional) Install the [powerline](https://github.com/powerline/fonts) font.

### MacOS VMware

TODO

## Installation

To install NixOS, run the following command:

```bash
nixos-rebuild switch --flake .#<wsl|mac-vmware>
```

## Packages

Here are the packages I use.

- [Common](./docs/PACKAGES.md)
- [Languages](./docs/LANGUAGES.md)
- [Custom commands](./docs/CUSTOM_COMMANDS.md)

## System Packages

Here are the system packages I use.

- [VMware](./docs/VMWARE.md)
