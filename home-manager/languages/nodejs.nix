{
  language,
}:
{
  pkgs,
  ...
}:
with builtins;
let
  version = if hasAttr "version" language then "_${language.version}" else "";
in
{
  home.packages = with pkgs; [
    pkgs."nodejs${version}"
    yarn
  ];
}
