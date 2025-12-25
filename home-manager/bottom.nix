{
  pkgs,
  ...
}:
{
  home.file = {
    ".docs/bottom.md".text = ''
      # Bottom

      Yet another cross-platform graphical process/system monitor.

      - [Repository](https://github.com/ClementTsang/bottom)
    '';
  };

  home.packages = with pkgs; [
    bottom
  ];
}
