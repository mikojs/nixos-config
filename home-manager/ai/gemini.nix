{
  lib,
  pkgs,
  miko,
  ai,
  rtkInitFiles,
  ...
}:
with lib;
with builtins;
let
  gemini = lists.findFirst (x: x.name == "gemini") null ai;
in
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
        ".gemini/GEMINI.md".text = ''
          ${if hasAttr "geminiMD" gemini then gemini.geminiMD else ""}
          ${readFile "${rtkInitFiles}/.gemini/GEMINI.md"}
        '';
      };

    packages = with pkgs; [
      gemini-cli-bin
    ];
  };

  programs.fish.interactiveShellInit = "
    # Add rtk gemini settings
    if not test -f ~/.gemini/settings.json
      echo '{}' > ~/.gemini/settings.json
    end

    jq '. * ${readFile "${rtkInitFiles}/.gemini/settings.json"}' ~/.gemini/settings.json > /tmp/gemini.json
    cp /tmp/gemini.json ~/.gemini/settings.json
  ";
}
