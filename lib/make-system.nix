{ nixpkgs, inputs, stateVersion }:

{ system
, wsl ? false
}:

let
  isWSL = wsl;
in
with inputs; nixpkgs.lib.nixosSystem rec {
  inherit system;

  modules = [
    (if isWSL then nixos-wsl.nixosModules.default else { })

    ({ pkgs, ... }: {
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      system.stateVersion = stateVersion;
      wsl.enable = isWSL;

      programs.git = {
        enable = true;
      };

      programs.neovim = {
        enable = true;
        defaultEditor = true;
      };
    })
  ];
}
