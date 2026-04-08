{
  ai,
  languages,
  ...
}:
{
  lib,
  pkgs,
  miko,
  ...
}:
with lib;
with builtins;
let
  useAI = lists.length ai > 0;
  getConfig = miko.getConfig (map (a: ./${a}.nix) ai) {
    inherit pkgs miko;
  };
in
if !useAI then
  { }
else
  {
    home = {
      file = getConfig [
        "home"
        "file"
      ] { };

      packages =
        getConfig
          [
            "home"
            "packages"
          ]
          [ pkgs.smux ];
    };

    programs.tmux.extraConfig = ''
      ${readFile pkgs.smux.configPath}
    '';
  }
