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
        filePath = "herdr-core";
        docs = ''
          # Herdr Core

          Herdr Core (`hc`) keeps terminals and agents running on a machine so the Herdr mobile app can reach them over SSH.

          [Repository](https://github.com/herdrdev/herdr-core)

          ## Gotcha

          The Herdr mobile app talks to herdr-core, not to the `herdr` TUI — with only `herdr` installed, the app reports Herdr as not installed.
        '';
      }
    ];

    packages = with pkgs; [
      herdr
      herdr-core
    ];
  };
}
