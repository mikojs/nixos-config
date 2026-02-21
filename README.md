# NixOS Configuration

Here is my NixOS configuration.

## Before installing

Some steps are required before installing NixOS.

### WSL

- Follow the instructions in [NixOS-WSL](https://github.com/nix-community/NixOS-WSL).
- Use `MesloLGS NF` and `Nord` in Windows Terminal.
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

### MacOS

- Install [nix](https://nixos.org/download/).
- Install [nix-darwin](https://github.com/nix-darwin/nix-darwin).
- Install [docker](https://www.docker.com/get-started).

The macOS built-in terminal has some customization limitations, so it is not used.
We use [Kitty](https://sw.kovidgoyal.net/kitty/) to replace it. Here is the [configuration](./home-manager/kitty.nix).

## Installation

Set up `git` and `ssh` keys.

```bash
nix-shell -p git <other packages you need> # use any method you like to set up `ssh` keys
```

Install the NixOS configuration.

```bash
# MacOS
# If you have the problem, follow this: https://github.com/nix-darwin/nix-darwin?tab=readme-ov-file#step-2-installing-nix-darwin
sudo darwin-rebuild switch --flake github:mikojs/nixos-config#<system name>
# Others
nixos-rebuild switch --flake github:mikojs/nixos-config#<system name> --sudo

# Run `initialize` command manually
# It will automatically run when you reopen the terminal
initialize
```

## After installing, you need to do the following manually

### AI

Currently, only `gemini` and `claude` are supported. Run the commands and authorize them manually according to your settings.

### Claude code statusline

Ccstatusline is a highly customizable statusline for the Claude Code CLI, offering powerline support, themes, and more.

[Repository](https://github.com/sirmalloc/ccstatusline)

```
# Run it manually
npx ccstatusline@latest
```

### Codeium in nvim

```nvim
# If you encounter issues with the dressing UI, run this command:
:lua require("dressing").setup({ select = { enabled = false }})

:Codeium Auth
```

## Development

### How to add a new language

[Here](./home-manager/languages/) are the specific packages for each language supported by this flake.
This flake also provides support for these languages within `nvim-treesitter`, `nvim-cmp`, and `conform.nvim`.

- Add a new language file to `./home-manager/languages/`.
- Neovim
    - (Optional) Add a new language file to `./home-manager/neovim/languages/`.
    - Add a new language configuration to `./home-manager/neovim/nvim-treesitter.nix`.
    - Add a new language file to `./home-manager/neovim/nvim-cmp/`.
    - Add a new language file to `./home-manager/neovim/conform-nvim/`.


If the new language is a database language, please refer to this section first.
Common database packages, plugins and configurations are provided in the `db` files.

- [language configuration](./home-manager/languages/db.nix)
- [nvim-cmp configuration](./home-manager/neovim/nvim-cmp/db.nix)
- [conform.nvim configuration](./home-manager/neovim/conform-nvim/db.nix)
