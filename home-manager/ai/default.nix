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
              if a.name == "antigravity" then
                ''
                  echo "# Global Execution Constraints

                  - **RTK Dependency:** This environment strictly enforces local token optimization via RTK. You must check for the existence of \`.agents/rules/antigravity-rtk-rules.md\` in the current working directory.
                  - **Graceful Failure:** If you are blocked by the global hook due to a missing RTK configuration, do not attempt to bypass it. Instead, output the following message verbatim to the user: 'Please run \`rtk init --agent antigravity\` manually in your local terminal to complete the project setup.'
                  ${if hasAttr "geminiMD" a then "
${a.geminiMD}" else ""}" > $HOME/.gemini/GEMINI.md
                ''
              else if hasAttr "${a.name}MD" a then
                ''echo "${a."${a.name}MD"}" > $HOME/.${a.name}/${toUpper a.name}.md''
              else
                ""
            }

            ${
              if a.name == "claude" then
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
          '') ai
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
        end
      end
    '';

  }
