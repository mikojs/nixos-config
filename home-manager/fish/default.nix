{
  pkgs,
  n8n,
  ...
}:
let
  getConfig = (import ../../lib.nix).getConfig ([
    ./custom.nix
    ./docs.nix
    ./tailscale.nix
    ./n8n
    ./nord.nix
    ./tide.nix
  ]) { inherit pkgs n8n; };
in
{
  home = {
    packages =
      getConfig
        [
          "home"
          "packages"
        ]
        [ ];

    file = getConfig [
      "home"
      "file"
    ] { };
  };

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

    shellAliases =
      getConfig
        [
          "programs"
          "fish"
          "shellAliases"
        ]
        {
          nsf = ''nix-shell --run "SHELL=$SHELL; fish"'';
        };
  };
}
