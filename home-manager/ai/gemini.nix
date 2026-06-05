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
          filePath = "ai/gemini";
          docs = ''
            # Gemini

            Gemini is an AI agent that brings the power of Gemini directly into your terminal.

            [Repository](https://github.com/google-gemini/gemini-cli)
          '';
        }
      ]
      // {
        ".gemini/hooks/.rtk-hook.sha256".source = "${aiInitFiles}/.gemini/hooks/.rtk-hook.sha256";
        ".gemini/hooks/rtk-hook-gemini.sh".source = "${aiInitFiles}/.gemini/hooks/rtk-hook-gemini.sh";
        ".gemini/GEMINI.md".source = "${aiInitFiles}/.gemini/GEMINI.md";
      };

    packages = with pkgs; [
      gemini-cli-bin
    ];
  };

  programs.fish.interactiveShellInit = "
    # Add ai gemini settings
    if not test -f ~/.gemini/settings.json
      echo '{}' > ~/.gemini/settings.json
    end

    jq -s add ${aiInitFiles}/.gemini/settings.json ~/.gemini/settings.json > /tmp/gemini.json
    cp /tmp/gemini.json ~/.gemini/settings.json
  ";
}
