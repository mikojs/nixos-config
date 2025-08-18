{ language }:
{
  pkgs,
  ...
}:
with builtins;
let
  version = if hasAttr "version" language then "_${language.version}" else "";
in
{
  home.packages =
    with pkgs;
    [
      pkgs."postgresql${version}"
      pgcli
    ]
    ++ (import ./db.nix { inherit pkgs; }).home.packages;

  xdg.configFile = {
    "pgcli/config".text = ''
      [main]
      use_local_timezone = False
      keyring = False
    '';
  };
}
