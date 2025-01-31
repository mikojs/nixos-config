{
  inputs,
  isWSL ? false,
  stateVersion,
  ...
}:
with inputs;
{
  imports = [
    (if isWSL then nixos-wsl.nixosModules.default else { })

    {
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      system.stateVersion = stateVersion;
      wsl.enable = isWSL;
    }

    ./hardware-configuration.nix

    {
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      services.openssh.enable = true;
      services.openssh.settings.PasswordAuthentication = true;
      services.openssh.settings.PermitRootLogin = "yes";
      users.users.root.initialPassword = "root";
    }

    (import ./tailscale.nix)
  ];
}
