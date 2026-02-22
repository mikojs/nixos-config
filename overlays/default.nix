{
  lib,
  pkgs,
  ...
}:
{
  _module.args.miko = import ./miko.nix { inherit lib pkgs; };

  nixpkgs.overlays = [
    (import ./patch)
    (import ./custom)
  ];
}
