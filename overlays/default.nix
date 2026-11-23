{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  _module.args.miko = import ./miko.nix { inherit lib pkgs; };

  nixpkgs.overlays = [
    (import ./patch inputs)
  ];
}
