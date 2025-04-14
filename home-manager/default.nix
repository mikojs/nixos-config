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
    extraSpecialArgs = {
      inherit isWSL;
    };

    users = listToAttrs (
      map (
        user:
        nameValuePair user.name {
          imports =
            [
              ./fish.nix
              ./gh.nix
              ./jless.nix
              ./jq.nix
              ./nq.nix
              ./tmux.nix
              ./tree.nix
              (import ./git.nix { gitconfig = user.gitconfig; })
              (import ./neovim { languages = user.languages; })
            ]
            ++ (map (l: import ./languages/${l.language}.nix { language = l; }) (
              filter (l: pathExists ./languages/${l.language}.nix) user.languages
            ));

          home.stateVersion = stateVersion;
        }
      ) users
    );
  };
}
