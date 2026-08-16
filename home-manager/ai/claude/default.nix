{
  pkgs,
  miko,
  aiInitFiles,
  ...
}:
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
        ".claude/settings.json".source = "${aiInitFiles}/.claude/settings.json";
        ".claude/statusline.fish".source = ./statusline.fish;
        ".claude/hooks/approval.fish".source = ./claude-approval-hook.fish;
        ".claude/hooks/approval-list.fish".source = ./claude-approval-list.fish;
        ".claude/RTK.md".source = "${aiInitFiles}/.claude/RTK.md";
        ".claude/CLAUDE.md".source = "${aiInitFiles}/.claude/CLAUDE.md";
      };

    packages = with pkgs; [
      claude-code
      gum
    ];
  };
}
