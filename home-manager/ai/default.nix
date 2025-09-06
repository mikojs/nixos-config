{
  ai,
  mcpServers,
  languages,
  ...
}:
{
  lib,
  pkgs,
  ...
}:
with lib;
with builtins;
let
  getConfig =
    (import ../../lib.nix).getConfig
      (
        (optionals (lists.length ai > 0) [
          ./uv.nix
          ./github.nix
        ])
        ++ (optionals (!(elem "nodejs" (map (a: a.language) languages))) [
          ./npx.nix
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
