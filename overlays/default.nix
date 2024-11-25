{
  nixpkgs.overlays = [
    (import ./fish.nix)
  ];
}
