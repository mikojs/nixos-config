{
  pkgs,
  ...
}:
{
  home = {
    file.".docs/oxker.md".text = ''
      # Oxker

      A simple tui to view & control docker containers.

      [Repository](https://github.com/mrjackwills/oxker)

    '';

    packages = with pkgs; [
      oxker
    ];
  };
}
