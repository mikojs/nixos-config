{
  ...
}:
{
  nixpkgs.overlays = [
    (import ./custom)
  ];
}