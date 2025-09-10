{
  description = "Mikojs NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mcphub-nvim.url = "github:ravitemer/mcphub.nvim";
    mcp-hub.url = "github:ravitemer/mcp-hub";
  };

  outputs =
    inputs:
    let
      mkSystem = import ./mkSystem.nix inputs;

      n8n = {
        homeDir = "/home/miko";
        postgresUser = "postgresUser";
        postgresPassword = "postgresPassword";
        postgresDb = "postgresDb";
        postgresNonRootUser = "postgresNonRootUser";
        postgresNonRootPassword = "postgresNonRootPassword";
      };
      users = [
        {
          name = "miko";
          gitconfig = {
            userName = "Mikojs";
            userEmail = "mikojs@gmail.com";
          };
          ai = [
            "gemini"
            "claude"
          ];
          languages = [
            { language = "nix"; }
            { language = "nodejs"; }
            { language = "rust"; }
            { language = "postgresql"; }
            { language = "sqlite"; }
          ];
        }
      ];
    in
    {
      inherit mkSystem;

      darwinConfigurations.mac = mkSystem {
        inherit n8n users;

        system = "aarch64-darwin";
        isMac = true;
      };

      nixosConfigurations = {
        wsl = mkSystem {
          inherit n8n users;

          system = "x86_64-linux";
          isWSL = true;
        };
      };
    };
}
