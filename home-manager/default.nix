{
  lib,
  pkgs,
  miko,
  inputs,
  stateVersion,
  isWSL,
  isMac,
  n8n,
  timezones,
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

  # FIXME: default shell, https://github.com/nix-darwin/nix-darwin/issues/1237
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
      nameValuePair user.name (
        {
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
              extraGroups = [
                "wheel"
                "docker"
              ];
            }
        )
      )
    ) users
  );

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit
        miko
        isWSL
        isMac
        n8n
        timezones
        ;
    };

    users = listToAttrs (
      map (
        user:
        nameValuePair user.name {
          imports =
            (optionals (hasAttr "packages" user) user.packages)
            ++ [
              ./bottom.nix
              ./fastfetch.nix
              ./fish
              ./gh.nix
              ./jless.nix
              ./jq.nix
              ./oxker.nix
              ./somo.nix
              ./tabiew.nix
              ./tree.nix
              (import ./tmux.nix user)
              (import ./git.nix user)
              (import ./neovim user)
              (import ./ai user)
            ]
            ++ (map (l: import ./languages/${l.language}.nix { language = l; }) (
              filter (l: pathExists ./languages/${l.language}.nix) user.languages
            ))
            ++ (optionals isMac [
              (import ./kitty.nix user)
            ]);

          home = {
            inherit stateVersion;

            file = miko.getDocs [
              {
                filePath = "tailscale";
                docs = ''
                  # Tailscale

                  Tailscale is used to build a private network.

                  [Repository](https://github.com/tailscale/tailscale)
                '';
              }
            ];
          };
        }
      ) users
    );
  };
}
