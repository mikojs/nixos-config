{
  lib,
  ...
}:
with lib;
evalModules {
  modules = [
    {
      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          # Disable Greeting
          set fish_greeting
        '';

        shellAliases = {
          nsf = ''nix-shell --run "SHELL=$SHELL; fish"'';
        };
      };
    }
    ./custom.nix
    ./nord.nix
    ./tide.nix
  ];
}
