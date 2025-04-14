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

  users.users.nixos = {
    shell = pkgs.fish;
    home = "/Users/nixos";
  };

  # FIXME default shell, https://github.com/nix-darwin/nix-darwin/issues/1237
  environment.variables = {
    SHELL = "fish";
    EDITOR = "nvim";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit isWSL user languages; };

    users.nixos = {
      imports =
        with builtins;
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
          ./kitty.nix
        ]
        ++ (map (l: ./languages/${l.language}.nix) (
          filter (l: pathExists ./languages/${l.language}.nix) languages
        ))
        ++ (optionals isVMware [ ./ghostty.nix ]);

      home.stateVersion = stateVersion;
    };
  };
}
