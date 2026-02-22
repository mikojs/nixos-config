{
  pkgs,
  ...
}:
{
  _module.args.miko = (import ../lib.nix) pkgs;
  nixpkgs.overlays = [
    (import ./patch)
    (import ./custom)
  ];
}
