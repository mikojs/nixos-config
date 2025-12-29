{
  lib,
  pkgs,
  inputs,
  stateVersion,
  isWSL,
  isMac,
  n8n,
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
    extraSpecialArgs = { inherit isWSL isMac n8n; };

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
              ./somo.nix
              ./tabiew.nix
              ./tree.nix
              ./wtfutil.nix
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

            file = {
              ".docs/tailscale.md".text = ''
                # Tailscale

                Tailscale is used to build a private network.

                [Repository](https://github.com/tailscale/tailscale)

              '';

              ".docs/docker.md".text = ''
                # Docker

                Docker is used to run containers.

                [Repository](https://github.com/docker/cli)

                We don't support it in MacOS. [Here](https://github.com/nix-darwin/nix-darwin/issues/112) are details.
                Please install it manually.

              '';
            };
          };
        }
      ) users
    );
  };
}
