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
          filePath = "ai/antigravity";
          docs = ''
            # Antigravity

            Antigravity is an AI agent that brings the power of Antigravity directly into your terminal.
          '';
        }
      ]
      // {
        ".claude/GEMINI.md".source = "${aiInitFiles}/.gemini/GEMINI.md";
      };

    packages = with pkgs; [
      antigravity
    ];
  };
}
