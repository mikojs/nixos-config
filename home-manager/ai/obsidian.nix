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

          CLI notes manager that integrates with LLMs. Open source and free.

          [Repository](https://github.com/obsidianmd/obsidian-releases)
        '';
      }
    ];

    packages = [
      pkgs.obsidian
    ];
  };
}
