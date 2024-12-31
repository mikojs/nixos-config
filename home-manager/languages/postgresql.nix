{
  pkgs,
  languages,
  ...
}:
with builtins;
let
  language = elemAt (filter (l: l.language == "postgresql") languages) 0;
  version = if hasAttr "version" language then "_${language.version}" else "";
in
{
  home.packages = [ pkgs."postgresql${version}" ];
}
