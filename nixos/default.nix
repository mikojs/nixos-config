{
  modules = [
    {
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      system.stateVersion = stateVersion;
    }

    ./git.nix
    ./neovim.nix
  ];
}
