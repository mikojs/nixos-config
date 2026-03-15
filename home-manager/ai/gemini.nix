{
  pkgs,
  miko,
  ...
}:
with builtins;
{
  home = {
    file = miko.getDocs [
      {
        filePath = "ai/gemini";
        docs = ''
          # Gemini

          Gemini is an AI agent that brings the power of Gemini directly into your terminal.

          [Repository](https://github.com/google-gemini/gemini-cli)
        '';
      }
    ];

    packages = with pkgs; [
      gemini-cli-bin
    ];
  };
}
