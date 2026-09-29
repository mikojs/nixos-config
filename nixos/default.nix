{
  lib,
  inputs,
  stateVersion,
  isMac,
  ...
}:
with lib;
{
  imports = [
    ./tailscale.nix
  ]
  ++ (optionals (!isMac) [
    ./docker.nix
  ]);

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [ "https://cache.numtide.com" ];
    trusted-public-keys = [ "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=" ];
  };

  system = {
    stateVersion = if isMac then 5 else stateVersion;
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or "dirty";
  };

  nixpkgs.config.allowUnfree = true;
}
