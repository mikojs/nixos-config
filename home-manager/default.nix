{ inputs
, stateVersion
, ...
}: with inputs; {
  imports = [
    home-manager.nixosModules.home-manager

    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        users.nixos = {
          imports = [
            ./git.nix
            ./neovim.nix
            ./tree.nix
            ./gh.nix
          ];
          home.stateVersion = stateVersion;
        };
      };
    }
  ];
}
