{
  description = "Mikojs NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = { self, nixpkgs, nixos-wsl, ... }@inputs: {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixosConfigurations.core = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nixos-wsl.nixosModules.default
        {
          system.stateVersion = "24.05";
          wsl.enable = true;
        }
      ];
    };
  };
}
