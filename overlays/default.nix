{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  _module.args.miko = import ./miko.nix { inherit lib pkgs; };

  nixpkgs.overlays = [
    inputs.miko-coder.overlays.default
    (import ./patch inputs)
  ];
}
