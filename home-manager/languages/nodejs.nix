{
  languages,
}:
{
  pkgs,
  ...
}:
with builtins;
let
  language = elemAt (filter (l: l.language == "nodejs") languages) 0;
  version = if hasAttr "version" language then "-${language.version}" else "";
in
{
  home.packages = with pkgs; [
    pkgs."nodejs${version}"
    yarn
  ];
}
