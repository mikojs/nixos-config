{ inputs
, stateVersion
, pkgs
, languages
, ...
}: with inputs; {
  imports = [
    home-manager.nixosModules.home-manager

    {
      programs.fish.enable = true;
      users.users.nixos.shell = pkgs.fish;

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit languages; };

        users.nixos = {
          imports = [
            ./git.nix
            ./gh.nix
            ./neovim
            ./tree.nix
            ./fish.nix
            ./languages.nix
          ];
          home.stateVersion = stateVersion;
        };
      };
    }
  ];
}
