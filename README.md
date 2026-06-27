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

Currently, only `antigravity` and `claude` are supported. Run the commands and authorize them manually according to your settings.

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

## Upgrade

### Routine upgrade

Each package under `overlays/patch/` mirrors its counterpart in nixpkgs unstable.
To upgrade, find the package in [nixpkgs unstable](https://github.com/NixOS/nixpkgs/tree/nixos-unstable) and copy the updated code into the corresponding patch file.

The upstream source path for each patch is noted as a comment in `overlays/patch/default.nix`.

### NixOS pkgs major version upgrade

When a new NixOS stable release is published (e.g. 25.05 → 25.11), all related dependencies need to be updated in sync.

1. **Update the version strings in `flake.nix`**

   Replace the version in all three inputs (using `25.11` as an example):

   ```nix
   nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
   nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
   home-manager.url = "github:nix-community/home-manager/release-25.11";
   ```

2. **Update `stateVersion` in `mkSystem.nix`**

   ```nix
   stateVersion = "25.11";
   ```

3. **Update the lock file and apply the configuration**

   ```bash
   nix flake update
   ```

4. **Remove patches in `overlays/patch/` that are no longer needed**

   After a major upgrade, some patches may have landed in the new nixpkgs.
   Once confirmed, remove the corresponding patch files together with their entries in `overlays/patch/default.nix`.

5. **Handle breaking API changes**

   The new nixpkgs or upstream packages may introduce breaking changes.
   Check the build log carefully after running `nixos-rebuild switch` and fix issues one by one.
