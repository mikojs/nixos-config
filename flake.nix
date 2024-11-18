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

  outputs = { nixpkgs, ... }@inputs: let
    makeSystem = import ./lib/make-system.nix {
      inherit nixpkgs inputs;
      stateVersion = "24.05";
    };
  in {
    nixosConfigurations.wsl = makeSystem {
      system = "x86_64-linux";
      wsl = true;
    };
  };
}
