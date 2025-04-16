{
  lib,
  pkgs,
  inputs,
  stateVersion,
  isWSL,
  isMac,
  users,
  ...
}:
with lib;
with inputs;
with builtins;
{
  imports = [
    (if isMac then home-manager.darwinModules.home-manager else home-manager.nixosModules.home-manager)
  ];

  programs.fish.enable = true;

  # FIXME default shell, https://github.com/nix-darwin/nix-darwin/issues/1237
  environment.variables = (
    if isMac then
      {
        SHELL = "fish";
        EDITOR = "nvim";
      }
    else
      { }
  );

  users.users = listToAttrs (
    map (
      user:
      nameValuePair user.name {
        shell = pkgs.fish;
      }
      // (
        if isMac then
          {
            home = "/Users/${user.name}";
          }
        else
          {
            isNormalUser = true;
            extraGroups = [ "wheel" ];
          }
      )
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
            ]
            ++ (map (l: import ./languages/${l.language}.nix { language = l; }) (
              filter (l: pathExists ./languages/${l.language}.nix) user.languages
            ))
            ++ (optionals isMac [
              (import ./kitty.nix { userName = user.name; })
            ]);

          home.stateVersion = stateVersion;
        }
      ) users
    );
  };
}
