{
  pkgs,
  miko,
  ...
}:
{
  home = {
    file = miko.getDocs [
      {
        filePath = "mermaid";
        docs = ''
          # Mermaid

          A simple way to generate mermaid diagrams.

          [Repository](https://github.com/mermaid-js/mermaid-cli)
        '';
      }
    ];

    packages = with pkgs; [
      nodePackages.mermaid-cli
    ];
  };
}
