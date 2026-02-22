{
  pkgs,
  ...
}:
{
  home = {
    file = (import ../lib.nix).getDocs pkgs [
      {
        filePath = "bottom";
        docs = ''
          # Bottom

          Yet another cross-platform graphical process/system monitor.

          [Repository](https://github.com/ClementTsang/bottom)
        '';
      }
    ];

    packages = with pkgs; [
      bottom
    ];
  };
}
