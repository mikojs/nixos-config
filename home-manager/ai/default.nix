{
  pkgs,
  ai,
  mcpServers,
  ...
}:
let
  getConfig = (import ../../lib.nix).getConfig [
    ./gemini.nix
    ./claude.nix
  ] { inherit pkgs mcpServers; };

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

  programs.fish.shellAliases = getConfig [
    "programs"
    "fish"
    "shellAliases"
  ] { };
}
