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

  programs.fish = {
    interactiveShellInit = "
      if not set -q GITHUB_PERSONAL_ACCESS_TOKEN and type -q gh and gh status &> /dev/null
        set -Ux GITHUB_PERSONAL_ACCESS_TOKEN $(gh auth token)
      end
    ";

    shellAliases = getConfig [
      "programs"
      "fish"
      "shellAliases"
    ] { };
  };
}
