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
      file =
        getConfig
          [
            "home"
            "file"
          ]
          (
            miko.getDocs [
              {
                filePath = "smux";
                docs = ''
                  # Smux

                  Tmux config with built-in terminal automation and agent-to-agent communication

                  [Repository](https://github.com/ShawnPana/smux)
                '';
              }
            ]
          );

      packages =
        getConfig
          [
            "home"
            "packages"
          ]
          [ pkgs.smux ];
    };

    programs.tmux.extraConfig = ''
      ${pkgs.smux.config}
    '';
  }
