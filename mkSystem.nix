inputs:
{
  system,
  isWSL ? false,
  user,
  languages,
}:
inputs.nixpkgs.lib.nixosSystem {
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

  modules = [
    ./overlays

    ./nixos
    (if isWSL then ./nixos/wsl.nix else { })

    ./home-manager
  ];
}
