{
  lib,
  pkgs,
  miko,
  config,
  ...
}:
{
  home = {
    file = miko.getDocs [
      {
        filePath = "herdr";
        docs = ''
          # Herdr

          Herdr is a terminal multiplexer that shows the state of every running AI agent at a glance.

          [Repository](https://github.com/herdrdev/herdr)
        '';
      }
      {
        filePath = "herdr-desktop";
        docs = ''
          # Herdr desktop

          Herdr desktop (`herdr-app`) is a desktop app for terminals and coding agents, running on herdr-core.

          [Repository](https://github.com/herdrdev/herdr-app)

          ## Support packages

          - `herdr-core` (`hc`): the runtime that runs every terminal and agent; the app
            and the Herdr mobile app reach it. [Repository](https://github.com/herdrdev/herdr-core)

          ## Gotcha

          - The `herdr` TUI runs its own server and cannot see herdr-core's terminals
            and agents, and neither can the TUI's saved machines. Start agents in
            Herdr desktop or with `hc` for them to reach the mobile app.
          - On macOS, `~/.config/herdr-core/config.toml` pins new terminals to fish,
            because the login shell herdr-core would otherwise start is still zsh.
        '';
      }
    ];

    packages = with pkgs; [
      herdr
      herdr-core
      herdr-desktop
    ];
  };

  # FIXME: default shell, https://github.com/nix-darwin/nix-darwin/issues/1237
  # herdr-core starts the $SHELL it was launched with, and on macOS that is the login shell
  # (zsh), which nix-darwin leaves unchanged; kitty pins fish the same way
  xdg.configFile."herdr-core/config.toml" = lib.mkIf pkgs.stdenv.isDarwin {
    text = ''
      shell = ["/etc/profiles/per-user/${config.home.username}/bin/fish"]
    '';
  };
}
