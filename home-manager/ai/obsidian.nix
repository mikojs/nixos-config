{
  pkgs,
  miko,
  ...
}:
{
  home = {
    file = miko.getDocs [
      {
        filePath = "ai/obsidian";
        docs = ''
          # Obsidian

          Powerful knowledge base that works on top of a local folder of plain text Markdown files.

          [Website](https://obsidian.md)
        '';
      }
    ];

    packages = [
      pkgs.obsidian
    ];
  };
}
