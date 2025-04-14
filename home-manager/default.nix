{
  lib,
  pkgs,
  inputs,
  stateVersion,
  isWSL,
  users,
  ...
}:
with lib;
with inputs;
with builtins;
{
  imports = [
    home-manager.nixosModules.home-manager
  ];

  programs.fish.enable = true;

  users.users = listToAttrs (
    map (
      user:
      nameValuePair user.name {
        isNormalUser = true;
        shell = pkgs.fish;
        extraGroups = [ "wheel" ];
      }
    ) users
  );

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users = listToAttrs (
      map (
        user:
        nameValuePair user.name {
          extraSpecialArgs = { inherit isWSL user; };

          imports =
            [
              ./fish.nix
              ./gh.nix
              ./git.nix
              ./jless.nix
              ./jq.nix
              ./nq.nix
              ./neovim
              ./tmux.nix
              ./tree.nix
            ]
            ++ (map (l: ./languages/${l.language}.nix) (
              filter (l: pathExists ./languages/${l.language}.nix) user.languages
            ));

          home.stateVersion = stateVersion;
        }
      ) users
    );
  };
}
