{
  description = "Mikojs NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      darwinConfigurations."Miko-MacBook" = mkSystem {
        system = "aarch64-darwin";
        user = {
          "name" = "Mikojs";
          "email" = "mikojs@gmail.com";
        };
        languages = [
          { language = "nix"; }
          { language = "nodejs"; }
          { language = "rust"; }
          { language = "postgresql"; }
          { language = "sqlite"; }
        ];
      };

      nixosConfigurations = {
        wsl = mkSystem {
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
            { language = "sqlite"; }
          ];
        };

        "mac-vmware" = mkSystem {
          system = "aarch64-linux";
          isVMware = true;
          user = {
            "name" = "Mikojs";
            "email" = "mikojs@gmail.com";
          };
          languages = [
            { language = "nix"; }
            { language = "nodejs"; }
            { language = "rust"; }
            { language = "postgresql"; }
            { language = "sqlite"; }
          ];
        };
      };
    };
}
