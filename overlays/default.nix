{
  lib,
  pkgs,
  ...
}:
{
  _module.args.miko = (import ../lib.nix) { inherit lib pkgs; };

  nixpkgs.overlays = [
    (import ./patch)
    (import ./custom)
  ];
}
