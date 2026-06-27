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

            Antigravity is an AI agent that brings the power of Antigravity directly into your terminal.
          '';
        }
      ]
      // {
        ".gemini/GEMINI.md".source = "${aiInitFiles}/.antigravity/GEMINI.md";
      };

    packages = with pkgs; [
      llm-agents.antigravity-cli
    ];
  };
}
