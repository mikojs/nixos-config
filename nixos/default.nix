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
      nixpkgs.config.allowUnfree = true;
      services.tailscale.enable = true;
      boot.kernel.sysctl = {
        "net.ipv4.ip_forward" = 1;
        "net.ipv6.conf.all.forwarding" = 1;
      };
    }
  ];
}
