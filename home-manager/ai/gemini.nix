{
  pkgs,
  miko,
  rtkInitFiles,
  ...
}:
with builtins;
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
        ".gemini/hooks/.rtk-hook.sha256".text = readFile "${rtkInitFiles}/.gemini/hooks/.rtk-hook.sha256";
        ".gemini/hooks/rtk-hook-gemini.sh".text =
          readFile "${rtkInitFiles}/.gemini/hooks/rtk-hook-gemini.sh";
        # TODO: support customized
        ".gemini/GEMINI.md".text = readFile "${rtkInitFiles}/.gemini/GEMINI.md";
      };

    packages = with pkgs; [
      gemini-cli-bin
    ];
  };
}
