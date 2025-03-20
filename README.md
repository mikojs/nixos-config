# NixOS Configuration

## Installation

To install NixOS, run the following command:

```bash
nixos-rebuild switch --flake .#<system>
```

### VMware

* [i3](./nixos/specialization/i3.nix)
    + Repository: [https://github.com/i3/i3](https://github.com/i3/i3)
    + Description: i3 is a tiling window manager.
* [openssh](./nixos/openssh.nix)
    + Description: OpenSSH is a secure remote login tool.
* [fcitx5](./nixos/fcitx5.nix)
    + Repository: [https://github.com/fcitx/fcitx5](https://github.com/fcitx/fcitx5)
    + Description: fcitx5 is a free and open source input method framework.
* [rofi](./nixos/rofi.nix)
    + Repository: [https://github.com/davatorium/rofi](https://github.com/davatorium/rofi)
    + Description: rofi is a window switcher, application launcher and dmenu replacement.
* [chromium](./nixos/chromium.nix)
    + Repository: [https://github.com/chromium/chromium](https://github.com/chromium/chromium)
    + Description: Chromium is a web browser from Google.

### WSL

* No specific packages listed.

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
