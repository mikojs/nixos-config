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
  aiInitFiles =
    pkgs.runCommand "ai-init-files"
      {
        nativeBuildInputs = [ pkgs.rtk ];
      }
      ''
        export HOME=$out
        ${concatStringsSep "\n" (
          map (a: ''
            mkdir -p $HOME/.${a.name}

            ${
              if hasAttr "${a.name}MD" a then
                "echo ${a."${a.name}MD"} > $HOME/.${a.name}/${toUpper a.name}.md"
              else
                ""
            }

            ${
              if a.name == "gemini" then
                "rtk init -g --auto-patch --gemini"
              else if a.name == "claude" then
                ''
                  echo '${
                    toJSON ({
                      "statusLine" = {
                        "type" = "command";
                        "command" = "fish ~/.claude/claude-statusline.fish";
                      };
                    })
                  }' > $HOME/.claude/settings.json
                  rtk init -g --auto-patch
                  rm $HOME/.claude/settings.json.bak
                ''
              else
                ""
            }
          '') ai
        )}
      '';
  getConfig = miko.getConfig (map (a: ./${a.name}.nix) ai) {
    inherit
      lib
      pkgs
      miko
      aiInitFiles
      ;
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
      ${getConfig [
        "programs"
        "fish"
        "interactiveShellInit"
      ] ""}

      # check rtk files
      for storePath in (find ${aiInitFiles} -type f)
        set -l relPath (string replace -- "${aiInitFiles}" "$HOME" $storePath)

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
