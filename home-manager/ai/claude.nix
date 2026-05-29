{
  pkgs,
  miko,
  ...
}:
with builtins;
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
        ".claude/settings.json".text = toJSON {
          "statusLine" = {
            "type" = "command";
            "command" = "fish ~/.claude/claude-statusline.fish";
          };
        };
        ".claude/claude-statusline.fish".text = (readFile ./claude-statusline.fish);
      };

    packages = with pkgs; [
      claude-code
    ];
  };
}
