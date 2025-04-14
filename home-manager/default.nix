{
  lib,
  pkgs,
  inputs,
  stateVersion,
  isWSL,
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
        ]
        ++ (map (l: ./languages/${l.language}.nix) (
          filter (l: pathExists ./languages/${l.language}.nix) languages
        ));

      home.stateVersion = stateVersion;
    };
  };
}
