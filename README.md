# NixOS Configuration

Here is my NixOS configuration.

## Before installing

Some steps are required before installing NixOS.

### WSL

- Follow the instructions in [NixOS-WSL](https://github.com/nix-community/NixOS-WSL).
- Install the [MesloLGS NF](https://github.com/IlanCosman/tide?tab=readme-ov-file#fonts) font.
- Add [Nord](https://www.nordtheme.com/) colorscheme to Windows Terminal.

  ```json
  {
    "background": "#2E3440",
    "black": "#3B4252",
    "blue": "#81A1C1",
    "brightBlack": "#3B4252",
    "brightBlue": "#5E81AC",
    "brightCyan": "#88C0D0",
    "brightGreen": "#A3BE8C",
    "brightPurple": "#B48EAD",
    "brightRed": "#BF616A",
    "brightWhite": "#E5E9F0",
    "brightYellow": "#EBCB8B",
    "cursorColor": "#E5E9F0",
    "cyan": "#88C0D0",
    "foreground": "#E5E9F0",
    "green": "#8FBCBB",
    "name": "Nord",
    "purple": "#B48EAD",
    "red": "#BF616A",
    "selectionBackground": "#E5E9F0",
    "white": "#4C566A",
    "yellow": "#EBCB8B"
  }
  ```

- Use `MesloLGS NF` and `Nord` in Windows Terminal.

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
