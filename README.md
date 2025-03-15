# NixOS ConfiguratioC

## Installation

To install NixOS, run the following command:

```bash
nixos-rebuild switch --flake .#<system>
```

### VMware

* `chromium`: Chromium
	+ Repository: https://github.com/chromium/chromium
	+ Description: Chromium is a web browser.
* `ghostty`: Ghostty
	+ Repository: https://github.com/ghostty/ghostty
	+ Description: Ghostty is a terminal emulator.

### WSL

* No specific packages listed.

## Common Packages

The following packages and repositories are used in this NixOS configuration:

* `neovim`: Neovim
	+ Repository: https://github.com/neovim/neovim
	+ Description: Neovim is a fork of the Vim text editor.
* `codeium-nvim`: Codeium Neovim plugin
	+ Repository: https://github.com/Exafunction/codeium.nvim
	+ Description: Codeium is a Neovim plugin for code completion and other features.

## Custom Commands

* [Initialize](overlays/custom/initialize): Initialize the system with custom settings
    + [tide](https://github.com/IlanCosman/tide)
    + [gh](https://github.com/cli/cli)
    + [tailscale](https://tailscale.com)
