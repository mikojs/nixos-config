{
  lib,
  pkgs,
  miko,
  isMac,
  ...
}:
with lib;
let
  getConfig =
    miko.getConfig
      [
        ./custom.nix
        ./nord.nix
        ./tide.nix
      ]
      {
        inherit
          lib
          pkgs
          miko
          ;
      };
in
{
  home = {
    file =
      getConfig
        [
          "home"
          "file"
        ]
        (
          miko.getDocs [
            {
              filePath = "fish";
              docs = ''
                # Fish

                Fish is a user-friendly command line shell.

                [Repository](https://github.com/fish-shell/fish-shell)
                ${
                  if isMac then
                    ''

                      ## Gotcha

                      - `ssh` is overridden to run `kitty +kitten ssh` on macOS instead of the
                        plain OpenSSH client, needed for terminfo to work correctly over SSH.
                    ''
                  else
                    ""
                }
              '';
            }
            {
              filePath = "nix";
              docs = ''
                # Nix

                Nix is a package manager.

                [Repository](https://github.com/NixOS/nixpkgs)

                ## Alias

                - `nsf`: Run `nix-shell` with fish-shell.
              '';
            }
            {
              filePath = "docker";
              docs = ''
                # Docker

                Docker is used to run containers.

                [Repository](https://github.com/docker/cli)
                ${
                  if isMac then
                    ''

                      ## Gotcha

                      We don't support it in MacOS. [Here](https://github.com/nix-darwin/nix-darwin/issues/112) are details.
                      Please install it manually.
                    ''
                  else
                    ""
                }
                ## Alias

                - `dsd`: Run `Docker system df`. Show docker disk usage.
              '';
            }
          ]
        );

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

    # FIXME: https://github.com/IlanCosman/tide/pull/626
    shellInit = ''
      set fish_key_bindings fish_default_key_bindings
    '';

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
        (
          {
            dsd = "docker system df";
            nsf = ''nix-shell --run "SHELL=$SHELL; fish"'';
          }
          // (optionalAttrs isMac { ssh = "kitty +kitten ssh"; })
        );
  };
}
