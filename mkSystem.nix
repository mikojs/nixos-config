inputs:
{
  system,
  isWSL ? false,
  isMac ? false,
  users,
}:
let
  lib = if isMac then inputs.nix-darwin.lib else inputs.nixpkgs.lib;
  mkSystem = if isMac then lib.darwinSystem else lib.nixosSystem;
in
with lib;
mkSystem {
  inherit system;

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
