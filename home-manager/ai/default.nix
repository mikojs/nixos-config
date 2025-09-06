{
  ai,
  mcpServers,
  ...
}:
{
  lib,
  pkgs,
  ...
}:
with lib;
let
  getConfig =
    (import ../../lib.nix).getConfig
      (
        (optionals (lists.length ai > 0) [
          ./uv.nix
          ./github.nix
        ])
        ++ (map (a: ./${a}.nix) ai)
      )
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
