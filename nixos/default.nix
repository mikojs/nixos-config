{ inputs
, isWSL ? false
, ...
}: with inputs; {
  imports = [
    (if isWSL then nixos-wsl.nixosModules.default else { })

    {
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      system.stateVersion = "24.05";
      wsl.enable = isWSL;
    }

    ./git.nix
    ./neovim.nix
  ];
}
