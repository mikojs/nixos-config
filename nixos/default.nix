{ inputs
, isWSL ? false
, stateVersion
, ...
}: with inputs; {
  imports = [
    (if isWSL then nixos-wsl.nixosModules.default else { })

    {
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      system.stateVersion = stateVersion;
      wsl.enable = isWSL;
    }

    ./git.nix
    ./neovim.nix
  ];
}
