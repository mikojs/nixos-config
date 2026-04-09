{
  pkgs,
  miko,
  ...
}:
{
  home = {
    file =
      miko.getDocs [
        {
          filePath = "ai/gemini";
          docs = ''
            # Gemini

            Gemini is an AI agent that brings the power of Gemini directly into your terminal.

            [Repository](https://github.com/google-gemini/gemini-cli)
          '';
        }
      ]
      // {
        ".gemini/skills/smux".source = pkgs.smux.skillDir;
      };

    packages = with pkgs; [
      gemini-cli-bin
    ];
  };
}
