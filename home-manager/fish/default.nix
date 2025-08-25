{
  pkgs,
  ...
}:
let
  getConfig = (import ../../lib.nix).getConfig ([
    ./custom.nix
    ./nord.nix
    ./tide.nix
  ]) { inherit pkgs; };
in
{
  home.packages =
    getConfig
      [
        "home"
        "packages"
      ]
      [ ];

  programs.fish = {
    enable = true;
    interactiveShellInit =
      getConfig
        [
          "programs"
          "fish"
          "interactiveShellInit"
        ]
        ''
          # Disable Greeting
          set fish_greeting
        '';

    plugins =
      getConfig
        [
          "programs"
          "fish"
          "plugins"
        ]
        [ ];

    shellAliases = {
      nsf = ''nix-shell --run "SHELL=$SHELL; fish"'';
    };
  };
}
