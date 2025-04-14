inputs:
{
  system,
  isWSL ? false,
  isVMware ? false,
  user,
  languages,
}:
with inputs.nixpkgs.lib;
with inputs.nix-darwin.lib;
darwinSystem {
  specialArgs = {
    inherit
      inputs
      isWSL
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
    ]);
}
