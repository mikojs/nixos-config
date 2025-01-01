{
  ...
}:
{
  nixpkgs.overlays = [
    (final: prev: {
      init = final.callPackage ../pkgs/init.nix { };
    })
  ];
}
