{
  language,
}:
{
  pkgs,
  miko,
  ...
}:
with builtins;
let
  version = if hasAttr "version" language then "_${language.version}" else "";
in
{
  home = {
    file = miko.getDocs [
      {
        filePath = "nodejs";
        docs = ''
          # Node.js

          An event-driven I/O framework for the V8 JavaScript engine.

          [Website](https://nodejs.org)
        '';
      }
      {
        filePath = "yarn";
        docs = ''
          # Yarn

          Fast, reliable, and secure dependency management for JavaScript.

          [Website](https://classic.yarnpkg.com/)

          ## Version

          This is Yarn Classic (1.x). Run `yarn set version berry` in a project that needs Yarn 2+.
        '';
      }
    ];

    packages = with pkgs; [
      pkgs."nodejs${version}"
      yarn
    ];
  };
}
