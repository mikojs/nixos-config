{
  ...
}:
{
  nixpkgs.overlays = [
    (import ./patch)
    (import ./custom)
  ];
}
