{ inputs
, stateVersion
, ...
}: with inputs; {
  imports = [
    home-manager.nixosModules.home-manager

    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.nixos = {
        imports = [
          ./git.nix
        ];
        home.stateVersion = stateVersion;
      };
    }
  ];
}
