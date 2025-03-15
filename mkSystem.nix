inputs:
{
  system,
  isWSL ? false,
  isVMware ? false,
  user,
  languages,
}:
with inputs.nixpkgs.lib;
nixosSystem {
  inherit system;

  specialArgs = {
    inherit
      inputs
      isVMware
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
    ])
    ++ (optionals isVMware [
      ./nixos/vmware.nix
      ./hardwares/${system}.nix
    ]);
}
