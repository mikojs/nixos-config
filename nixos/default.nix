{
  inputs,
  isWSL,
  stateVersion,
  ...
}:
with inputs;
{
  imports = [
    (if isWSL then nixos-wsl.nixosModules.default else { })

    ./tailscale.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = stateVersion;
  wsl.enable = isWSL;
}
