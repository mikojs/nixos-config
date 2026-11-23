{
  pkgs,
  miko,
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

          ## Appearance

          - Terminal font is `MesloLGS Nerd Font Mono` at 13, the same as kitty.

          ## Gotcha

          - The `herdr` TUI runs its own server and cannot see herdr-core's terminals
            and agents, and neither can the TUI's saved machines. Start agents in
            Herdr desktop or with `hc` for them to reach the mobile app.
          - `~/.config/herdr-app/settings.json` is written by Nix and read-only, so
            changes made in Herdr's own Settings are not saved; change them here.
        '';
      }
    ];

    packages = with pkgs; [
      herdr
      herdr-core
      herdr-desktop
    ];
  };

  xdg.configFile."herdr-app/settings.json".text = builtins.toJSON {
    font = "MesloLGS Nerd Font Mono";
    font_size = 13;
  };
}
