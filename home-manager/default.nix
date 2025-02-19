{
  lib,
  pkgs,
  inputs,
  stateVersion,
  isVMware,
  user,
  languages,
  ...
}:
with lib;
with inputs;
{
  imports = [
    home-manager.nixosModules.home-manager
  ];

  programs.fish.enable = true;

  users.users.nixos = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit user languages; };

    users.nixos = {
      imports =
        with builtins;
        [
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
        ))
        ++ (optionals isVMware [ ./ghostty.nix ]);

      home.stateVersion = stateVersion;
    };
  };
}
