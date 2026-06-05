{
  lib,
  pkgs,
  miko,
  ai,
  rtkInitFiles,
  ...
}:
with lib;
with builtins;
let
  claude = lists.findFirst (x: x.name == "claude") null ai;
in
{
  home = {
    file =
      miko.getDocs [
        {
          filePath = "ai/claude-code";
          docs = ''
            # Claude Code

            Claude Code is an AI agent that brings the power of Claude directly into your code.

            [Repository](https://github.com/anthropics/claude-code)
          '';
        }
      ]
      // {
        ".claude/settings.json".text = toJSON (
          {
            "statusLine" = {
              "type" = "command";
              "command" = "fish ~/.claude/claude-statusline.fish";
            };
          }
          // fromJSON (readFile "${rtkInitFiles}/.claude/settings.json")
        );
        ".claude/claude-statusline.fish".text = readFile ./claude-statusline.fish;
        ".claude/RTK.md".text = readFile "${rtkInitFiles}/.claude/RTK.md";
        ".claude/CLAUDE.md".text = ''
          ${if hasAttr "claudeMD" claude then claude.claudeMD else ""}
          ${readFile "${rtkInitFiles}/.claude/CLAUDE.md"}
        '';
      };

    packages = with pkgs; [
      claude-code
    ];
  };
}
