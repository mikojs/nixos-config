inputs:
{
  system,
  systemModules ? [ ],
  isWSL ? false,
  isMac ? false,
  n8n,
  timezones ? [ ],
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
      system
      isWSL
      isMac
      n8n
      timezones
      users
      ;

    stateVersion = "25.11";
  };

  modules =
    systemModules
    ++ [
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
