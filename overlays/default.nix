{
  ...
}:
{
  nixpkgs.overlays = [
    (import ./custom)
  ];
}
