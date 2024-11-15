{
  description = "Mikojs NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, ... }@inputs: {
    nixosConfigurations.core = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nixos-wsl.nixosModules.default
        {
          system.stateVersion = "24.05";
          wsl.enable = true;
        }
        {
          nix.settings.experimental-features = [ "nix-command" "flakes" ];
        }
      ];
    };
  };
}
