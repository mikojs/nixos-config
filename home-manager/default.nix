{
  pkgs,
  inputs,
  stateVersion,
  user,
  languages,
  ...
}:
with inputs;
{
  imports = [
    home-manager.nixosModules.home-manager

    {
      programs.fish.enable = true;
      users.users.nixos.shell = pkgs.fish;

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit user languages; };

        users.nixos = {
          imports =
            with builtins;
            [
              ./custom.nix
              ./fish.nix
              ./gh.nix
              ./git.nix
              ./jless.nix
              ./jq.nix
              ./neovim
              ./tmux.nix
              ./tree.nix
            ]
            ++ (map (l: ./languages/${l.language}.nix) (
              filter (l: pathExists ./languages/${l.language}.nix) languages
            ));
          home.stateVersion = stateVersion;
        };
      };
    }
  ];
}
