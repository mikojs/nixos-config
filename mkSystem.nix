inputs:
{
  system,
  isWSL ? false,
  isMac ? false,
  users,
}:
let
  mkSystem = if isMac then inputs.nix-darwin.lib.darwinSystem else inputs.nixpkgs.lib.nixosSystem;
in
with inputs.nixpkgs.lib;
mkSystem {
  inherit system;

  specialArgs = {
    inherit
      inputs
      isWSL
      isMac
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
    ])
    ++ (optionals isMac [
      ./nixos/mac.nix
    ]);
}
