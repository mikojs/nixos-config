{
  ...
}:
{
  nixpkgs.overlays = [
    (import ./patch)
    (import ./custom)
    (final: prev: {
      miko = {
        getConfig = (import ../lib.nix).getConfig;
        getDocs = (import ../lib.nix).getDocs final;
      };
    })
  ];
}
