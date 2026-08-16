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

            ## Tmux-powerline customize

            - Claude approval notifications segment (`~/.config/tmux-powerline/segments/claude.sh`)
          '';
        }
      ]
      // {
        ".claude/settings.json".source = "${aiInitFiles}/.claude/settings.json";
        ".claude/statusline.fish".source = ./statusline.fish;
        ".claude/approval/hook.fish".source = ./approval-hook.fish;
        ".claude/approval/list.fish".source = ./approval-list.fish;
        ".claude/RTK.md".source = "${aiInitFiles}/.claude/RTK.md";
        ".claude/CLAUDE.md".source = "${aiInitFiles}/.claude/CLAUDE.md";
        ".config/tmux-powerline/segments/claude.sh".source = ./tmux-powerline-claude.sh;
      };

    packages = with pkgs; [
      claude-code
      gum
    ];
  };

  programs.tmux.extraConfig = ''
    bind-key A display-popup -E "fish ~/.claude/approval/list.fish"
  '';
}
