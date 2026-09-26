{
  pkgs,
  miko,
  aiInitFiles,
  ...
}:
let
  statusline = import ./statusline.nix { inherit pkgs; };
in
{
  home = {
    file =
      miko.getDocs [
        {
          filePath = "ai/antigravity";
          docs = ''
            # Antigravity

            Antigravity is an AI agent that brings the power of Gemini directly into your terminal.

            [Website](https://antigravity.google/)
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

  programs.fish.interactiveShellInit = ''
    set -l antigravity_settings ~/.gemini/antigravity-cli/settings.json
    set -l desired_statusline_command "${statusline}/bin/antigravity-statusline"

    if test -f $antigravity_settings
      jq --arg cmd "$desired_statusline_command" \
        '.statusLine.type = "command" | .statusLine.command = $cmd | .statusLine.enabled = true' \
        $antigravity_settings > $antigravity_settings.tmp
      and mv $antigravity_settings.tmp $antigravity_settings
    end
  '';
}
