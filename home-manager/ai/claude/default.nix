{
  pkgs,
  miko,
  aiInitFiles,
  ...
}:
let
  approvalList = import ./approval-list.nix { inherit pkgs; };
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

            ## Keybindings

            - `A`: Claude approval list

            ## Appearance

            - Tmux Powerline: Claude approval notifications segment (`~/.config/tmux-powerline/segments/claude.sh`)
          '';
        }
      ]
      // {
        ".claude/settings.json".source = "${aiInitFiles}/.claude/settings.json";
        ".claude/RTK.md".source = "${aiInitFiles}/.claude/RTK.md";
        ".claude/CLAUDE.md".source = "${aiInitFiles}/.claude/CLAUDE.md";
        ".config/tmux-powerline/segments/claude.sh".source = ./tmux-powerline-claude.sh;
      };

    packages = with pkgs; [
      claude-code
    ];
  };

  programs.tmux.extraConfig = ''
    bind-key A display-popup -E "${approvalList}/bin/claude-approval-list"
  '';
}
