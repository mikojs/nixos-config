{
  pkgs,
  ai,
  mcpServers,
  ...
}:
with builtins;
let
  getConfig =
    (import ../../lib.nix).getConfig
      (
        (
          optionals lists.length ai > 0 [
            ./uv.nix
            ./github.nix
          ]
        )
        ++ (map (a: import ./${a}.nix { inherit pkgs mcpServers; }) ai)
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
