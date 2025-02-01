inputs:
{
  system,
  isWSL ? false,
  isVMware ? false,
  user,
  languages,
}:
inputs.nixpkgs.lib.nixosSystem {
  inherit system;

  specialArgs = {
    inherit
      inputs
      user
      languages
      ;

    stateVersion = "24.11";
  };

  modules = [
    ./overlays
    ./nixos

    (if isWSL then ./nixos/wsl.nix else { })
    (if isVMware then ./nixos/vmware.nix else { })
    (if isVMware then ./hardwares/${system}.nix else { })

    ./home-manager
  ];
}
