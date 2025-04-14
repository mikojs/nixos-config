inputs:
{
  system,
  isWSL ? false,
  users,
}:
with inputs.nixpkgs.lib;
with inputs.nix-darwin.lib;
darwinSystem {
  specialArgs = {
    inherit
      inputs
      isWSL
      users
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
