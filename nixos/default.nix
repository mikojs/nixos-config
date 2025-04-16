{
  stateVersion,
  ...
}:
{
  imports = [
    ./tailscale.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = 5;
}
