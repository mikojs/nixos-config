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
        ".gemini/statusline.fish".source = ./statusline.fish;
      };

    packages = with pkgs; [
      llm-agents.antigravity-cli
    ];
  };

  programs.fish.interactiveShellInit = ''
    set -l antigravity_settings ~/.gemini/antigravity-cli/settings.json
    set -l desired_statusline_command "fish ~/.gemini/statusline.fish"

    if test -f $antigravity_settings
      jq --arg cmd "$desired_statusline_command" \
        '.statusLine.type = "command" | .statusLine.command = $cmd | .statusLine.enabled = true' \
        $antigravity_settings > $antigravity_settings.tmp
      and mv $antigravity_settings.tmp $antigravity_settings
    end
  '';
}
