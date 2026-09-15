{
  pkgs,
  miko,
  ...
}:
{
  home = {
    file = miko.getDocs [
      {
        filePath = "bottom";
        docs = ''
          # Bottom

          Yet another cross-platform graphical process/system monitor.

          [Repository](https://github.com/ClementTsang/bottom)

          ## Alias

          - `btm`: Run bottom.
        '';
      }
    ];

    packages = with pkgs; [
      bottom
    ];
  };
}
