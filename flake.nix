{
  description = "Mikojs NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    {
      nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          isWSL = true;
          stateVersion = "24.11";
          user = {
            "name" = "Mikojs";
            "email" = "mikojs@gmail.com";
          };
          languages = [
            { language = "nix"; }
            { language = "nodejs"; }
            { language = "rust"; }
            { language = "postgresql"; }
          ];
        };
        modules = [
          ./overlays
          ./nixos
          ./nixos/wsl.nix
          ./home-manager
        ];
      };
    };
}
