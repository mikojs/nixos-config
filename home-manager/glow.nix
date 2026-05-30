{
  pkgs,
  miko,
  ...
}:
{
  home = {
    file = miko.getDocs [
      {
        filePath = "glow";
        docs = ''
          # Glow

          Render markdown on the CLI.

          [Repository](https://github.com/charmbracelet/glow)
        '';
      }
    ];

    packages = with pkgs; [
      glow
    ];
  };
}
