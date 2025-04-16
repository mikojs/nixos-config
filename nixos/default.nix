{
  stateVersion,
  isMac,
  ...
}:
{
  imports = [
    ./tailscale.nix
    ./docker.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = if isMac then 5 else stateVersion;
}
