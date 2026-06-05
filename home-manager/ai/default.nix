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
          (
            miko.getDocs [
              {
                filePath = "ai/rtk";
                docs = ''
                  # RTK

                  CLI proxy that reduces LLM token consumption by 60-90% on common dev commands. Single Rust binary, zero dependencies

                  [Repository](https://github.com/rtk-ai/rtk/)
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
          [ pkgs.rtk ];
    };

    programs.fish.interactiveShellInit = ''
      for storePath in (find ${rtkInitFiles} -type f)
        set -l relPath (string replace -- "${rtkInitFiles}" "$HOME" $storePath)

        if string match -q "*/.config/rtk/filters.toml" $relPath
          continue
        end

        if not test -e $relPath
          echo "⚠ RTK: $relPath missing, run home-manager switch"
        else if string match -q "*/settings.json" $relPath
          if not jq -e '[.. | strings | select(contains("rtk"))] | any' $relPath > /dev/null 2>&1
            echo "⚠ RTK: $relPath exists but rtk hook is missing"
          end
        end
      end
    '';

  }
