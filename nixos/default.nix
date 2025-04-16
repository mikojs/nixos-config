{
  lib,
  stateVersion,
  isMac,
  ...
}:
with lib;
{
  imports =
    [
      ./tailscale.nix
    ]
    ++ (optionals (!isMac) [
      ./docker.nix
    ]);

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = if isMac then 5 else stateVersion;
}
