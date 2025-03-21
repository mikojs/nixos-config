{
  ...
}:
{
  nixpkgs.overlays = [
    (import ./patch.nix)
    (import ./custom)
  ];
}
