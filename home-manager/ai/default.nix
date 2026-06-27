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
          map (
            a:
            let
              name = if a.name == "antigravity" then "gemini" else a.name;
            in
            ''
              mkdir -p $HOME/.${name}

              ${
                if hasAttr "${name}MD" a then
                  ''echo "${a."${name}MD"}" > $HOME/.${name}/${toUpper name}.md''
                else
                  ""
              }

              ${
                if name == "claude" then
                  ''
                    echo '${
                      toJSON (
                        {
                          "statusLine" = {
                            "type" = "command";
                            "command" = "fish ~/.claude/claude-statusline.fish";
                          };
                        }
                        // (if hasAttr "settings" a then a.settings else { })
                      )
                    }' > $HOME/.claude/settings.json
                    rtk init -g --auto-patch
                    rm $HOME/.claude/settings.json.bak
                  ''
                else
                  ""
              }
            ''
          ) ai
        )}

        rm -rf $HOME/.config/rtk/filters.toml
      '';
  getConfig =
    miko.getConfig
      (
        [
          ./rtk.nix
          ./gitnexus.nix
          ./obsidian.nix
        ]
        ++ (map (a: ./${a.name}.nix) ai)
      )
      {
        inherit pkgs miko aiInitFiles;
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
          [ ];
    };

    programs.fish.interactiveShellInit = ''
      ${getConfig [
        "programs"
        "fish"
        "interactiveShellInit"
      ] ""}

      # check ai files
      for storePath in (find ${aiInitFiles} -type f)
        set -l relPath (string replace -- "${aiInitFiles}" "$HOME" $storePath)

        if not test -e $relPath
          echo "⚠ AI: $relPath missing, run home-manager switch"
        else if string match -q "*/.antigravity/settings.json" $relPath
          if not jq -e '[.. | strings | select(contains("rtk"))] | any' $relPath > /dev/null 2>&1
            echo "⚠ AI: $relPath exists but rtk hook is missing"
          end
        end
      end
    '';

  }
