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
      darwinConfigurations.mac = mkSystem {
        system = "aarch64-darwin";
        isMac = true;
        users = [
          {
            name = "mac";
            gitconfig = {
              userName = "Mikojs";
              email = "mikojs@gmail.com";
            };
            languages = [
              { language = "nix"; }
              { language = "nodejs"; }
              { language = "rust"; }
              { language = "postgresql"; }
              { language = "sqlite"; }
            ];
          }
        ];
      };

      nixosConfigurations = {
        wsl = mkSystem {
          system = "x86_64-linux";
          isWSL = true;
          users = [
            {
              name = "nixos";
              gitconfig = {
                userName = "Mikojs";
                userEmail = "mikojs@gmail.com";
              };
              languages = [
                { language = "nix"; }
                { language = "nodejs"; }
                { language = "rust"; }
                { language = "postgresql"; }
                { language = "sqlite"; }
              ];
            }
          ];
        };
      };
    };
}
