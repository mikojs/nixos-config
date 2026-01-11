{
  lib,
  pkgs,
  n8n,
  timezones,
  ...
}:
let
  getConfig = (import ../../lib.nix).getConfig ([
    ./custom.nix
    ./tailscale.nix
    ./n8n
    ./nord.nix
    ./tide.nix
  ]) { inherit pkgs n8n; };
in
{
  home = {
    file =
      getConfig
        [
          "home"
          "file"
        ]
        {
          ".docs/fish.md".text = ''
            # Fish

            Fish is a user-friendly command line shell.

            [Repository](https://github.com/fish-shell/fish-shell)

            ## Alias

            - `nsf`: Run `nix-shell` with fish-shell.
            - `times`: Show times in different timezones.
            ${with lib; strings.concatStringsSep "\n" (getConfig [ "fish-alias" ] [ ])}

          '';
        };

    packages =
      getConfig
        [
          "home"
          "packages"
        ]
        [ ];
  };

  programs.fish = with builtins; {
    enable = true;
    interactiveShellInit =
      getConfig
        [
          "programs"
          "fish"
          "interactiveShellInit"
        ]
        ''
          # Disable Greeting
          set fish_greeting

          ${
            if length timezones <= 0 then
              ""
            else
              ''
                # Show times
                function times --description "Show times in different timezones"
                  begin
                    echo -e "timezone,time"
                    ${concatStringsSep "\n" (
                      map (t: "echo -e \"${t},$(TZ=${t} date +'%Y-%m-%d %H:%M:%S')\"") timezones
                    )}
                  end | column -t -s ','
                end
              ''
          };
        '';

    plugins =
      getConfig
        [
          "programs"
          "fish"
          "plugins"
        ]
        [ ];

    shellAliases =
      getConfig
        [
          "programs"
          "fish"
          "shellAliases"
        ]
        {
          nsf = ''nix-shell --run "SHELL=$SHELL; fish"'';
        };
  };
}
