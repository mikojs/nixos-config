{
  pkgs,
  ai,
  mcpServers,
  ...
}:
let
  getConfig =
    (import ../../lib.nix).getConfig (map (a: import ./${a}.nix { inherit pkgs mcpServers; }) ai)
      {
        inherit pkgs mcpServers;
      };

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
