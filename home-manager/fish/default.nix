{
  lib,
  pkgs,
  isMac,
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
  ]) { inherit pkgs n8n timezones; };
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

            - `times`: Show times in different timezones.
            ${with lib; strings.concatStringsSep "\n" (getConfig [ "fish-alias" ] [ ])}

          '';

          ".docs/nix.md".text = ''
            # Nix

            Nix is a package manager.

            [Repository](https://github.com/NixOS/nixpkgs)

            ## Search packages

            - `nix search`: Search packages.
            - Use `https://search.nixos.org/packages` to get the latest version.
            - Use `https://lazamar.co.uk/nix-versions` to get the different versions.

            ## Alias

            - `nsf`: Run `nix-shell` with fish-shell.

          '';

          ".docs/docker.md".text = ''
            # Docker

            Docker is used to run containers.
            ${
              if isMac then
                ''

                  We don't support it in MacOS. [Here](https://github.com/nix-darwin/nix-darwin/issues/112) are details.
                  Please install it manually.
                ''
              else
                ""
            }
            [Repository](https://github.com/docker/cli)

            ## Alias

            - `dsd`: Run `Docker system df`. Show docker disk usage.

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
          dsd = "docker system df";
          nsf = ''nix-shell --run "SHELL=$SHELL; fish"'';
        };
  };
}
