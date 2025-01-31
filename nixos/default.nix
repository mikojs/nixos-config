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
  system.stateVersion = stateVersion;
}
