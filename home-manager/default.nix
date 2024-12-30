{
  pkgs,
  inputs,
  stateVersion,
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
        extraSpecialArgs = { inherit languages; };

        users.nixos = {
          imports =
            with builtins;
            [
              ./git.nix
              ./gh.nix
              ./neovim
              ./tree.nix
              ./tmux.nix
              ./jless.nix
              ./jq.nix
              ./fish.nix
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
