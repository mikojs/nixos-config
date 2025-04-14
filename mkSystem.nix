inputs:
{
  system,
  isWSL ? false,
  user,
  languages,
}:
with inputs.nixpkgs.lib;
nixosSystem {
  inherit system;

  specialArgs = {
    inherit
      inputs
      isWSL
      user
      languages
      ;

    stateVersion = "24.11";
  };

  modules =
    [
      ./overlays
      ./nixos
      ./home-manager
    ]
    ++ (optionals isWSL [
      ./nixos/wsl.nix
    ]);
}
