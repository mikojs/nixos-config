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
  rtkInitFiles =
    pkgs.runCommand "rtk-init-files"
      {
        nativeBuildInputs = [ pkgs.rtk ];
      }
      ''
        export HOME=$out
        ${concatStringsSep "\n" (
          map (a: ''
            mkdir -p $HOME/.${a}
            ${if a == "gemini" then "rtk init -g --auto-patch --gemini" else "rtk init -g --auto-patch"}
          '') ai
        )}
      '';
  getConfig = miko.getConfig (map (a: ./${a}.nix) ai) {
    inherit pkgs miko rtkInitFiles;
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
          miko.getConfig
          [
            {
              filePath = "ai/rtk";
              docs = ''
                # RTK

                CLI proxy that reduces LLM token consumption by 60-90% on common dev commands. Single Rust binary, zero dependencies

                [Repository](https://github.com/rtk-ai/rtk/)
              '';
            }
          ];

      packages =
        getConfig
          [
            "home"
            "packages"
          ]
          [ pkgs.rtk ];
    };

    # TODO: add rtk checking
    programs.fish.interactiveShellInit = "
    ";

  }
