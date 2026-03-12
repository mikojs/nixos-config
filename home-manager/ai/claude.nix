{
  pkgs,
  miko,
  ...
}:
{
  home = {
    file = miko.getDocs [
      {
        filePath = "ai/claude-code";
        docs = ''
          # Claude Code

          Claude Code is an AI agent that brings the power of Claude directly into your code.

          [Repository](https://github.com/anthropics/claude-code)
        '';
      }
    ];

    packages = with pkgs; [
      claude-code
    ];
  };
}
