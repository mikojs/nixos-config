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
      antigravity-cli
    ];
  };

  programs.fish.interactiveShellInit = ''
    set -l antigravity_settings ~/.gemini/antigravity-cli/settings.json
    set -l desired_statusline_command "${statusline}/bin/antigravity-statusline"

    # A terminal can start a shell per pane at once, so each one writes its own temporary file;
    # a shared one could be truncated by another shell just before the mv and leave the
    # settings empty.
    if test -f $antigravity_settings; and set -l antigravity_settings_tmp (${pkgs.coreutils}/bin/mktemp $antigravity_settings.XXXXXX)
      if jq --arg cmd "$desired_statusline_command" \
          '.statusLine.type = "command" | .statusLine.command = $cmd | .statusLine.enabled = true' \
          $antigravity_settings > $antigravity_settings_tmp
        # jq prints nothing for an empty settings.json and still succeeds; writing that back
        # would keep the file empty, so an empty result is dropped.
        # An unchanged file is not rewritten, so concurrent shells mostly skip the mv.
        if not test -s $antigravity_settings_tmp; or ${pkgs.diffutils}/bin/cmp -s $antigravity_settings $antigravity_settings_tmp
          rm $antigravity_settings_tmp
        else
          mv $antigravity_settings_tmp $antigravity_settings
        end
      else
        rm -f $antigravity_settings_tmp
      end
    end
  '';
}
