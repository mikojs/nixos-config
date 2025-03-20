# NixOS Configuration

Here is my NixOS configuration.

## Before installing

Some steps are required before installing NixOS.

### WSL

- Follow the instructions in [NixOS-WSL](https://github.com/nix-community/NixOS-WSL).
- (Optional) Install the [powerline](https://github.com/powerline/fonts) font.

### MacOS VMware

I refer to this [repository](https://github.com/mitchellh/nixos-config).
Follow this [video](https://youtu.be/ubDMLoWz76U?t=82) to set up the VMware setting.

- ISO: NixOS 23.05 or later.
- Disk: SATA 150 GB+
- CPU/Memory: I give at least half my cores and half my RAM, as much as you can.
- Graphics: Full acceleration, full resolution, maximum graphics RAM.
- Network: Shared with my Mac.
- Remove sound card, remove video camera, remove printer.
- Profile: Disable almost all keybindings
- Boot Mode: UEFI

Set up ssh.

```bash
sudo su
passwd # set root password to root
```

Run the following command.

```bash
parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart primary 512MB -8GB
parted /dev/sda -- mkpart primary linux-swap -8GB 100%
parted /dev/sda -- mkpart ESP fat32 1MB 512MB
parted /dev/sda -- set 3 esp on

mkfs.ext4 -L nixos /dev/sda1
mkswap -L swap /dev/sda2
mkfs.fat -F 32 -n boot /dev/sda3

mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
nixos-generate-config --root /mnt
```

Add to `/mnt/etc/nixos/configuration.nix`.

```nix
nix.settings.experimental-features = [
  "nix-command"
  "flakes"
];
services.openssh.enable = true;
services.openssh.settings.PasswordAuthentication = true;
services.openssh.settings.PermitRootLogin = "yes";
users.users.root.initialPassword = "root";
```

Run the following command.

```bash
nixos-install --no-root-passwd && reboot
```

## Installation

To install NixOS, run the following command after setting `git` and `ssh`.

```bash
# `--install-bootloader` for VMware first time
nixos-rebuild switch --flake github:mikojs/nixos-conifg#<wsl|mac-vmware>
```

After installing, you need to authorize `Codeium` in `nvim` manually.

```nvim
:Codeium Auth
```

Here are the packages I use.

- [Common](./docs/PACKAGES.md)
- [Languages](./docs/LANGUAGES.md)
- [Custom commands](./docs/CUSTOM_COMMANDS.md)

Here are the system packages I use.

- [VMware](./docs/VMWARE.md)
