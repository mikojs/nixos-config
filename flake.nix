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
    inputs:
    let
      mkSystem = import ./mkSystem.nix inputs;
    in
    {
      nixosConfigurations.wsl = mkSystem {
        system = "x86_64-linux";
        isWSL = true;
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
    };
}
