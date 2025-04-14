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
    home-manager.darwinModules.home-manager
  ];

  programs.fish.enable = true;

  # FIXME default shell, https://github.com/nix-darwin/nix-darwin/issues/1237
  environment.variables = {
    SHELL = "fish";
    EDITOR = "nvim";
  };

  users.users = listToAttrs (
    map (
      user:
      nameValuePair user.name {
        shell = pkgs.fish;
        home = "/Users/${user.name}";
      }
    ) users
  );

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit isWSL; };

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
              (import ./kitty.nix { userName = user.name; })
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
