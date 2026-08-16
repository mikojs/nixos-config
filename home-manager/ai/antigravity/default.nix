{
  pkgs,
  miko,
  aiInitFiles,
  ...
}:
with builtins;
{
  home = {
    file =
      miko.getDocs [
        {
          filePath = "ai/antigravity";
          docs = ''
            # Antigravity

            Antigravity is an AI agent that brings the power of Gemini directly into your terminal.
          '';
        }
      ]
      // {
        ".gemini/GEMINI.md".source = "${aiInitFiles}/.gemini/GEMINI.md";
      };

    packages = with pkgs; [
      llm-agents.antigravity-cli
    ];
  };
}
