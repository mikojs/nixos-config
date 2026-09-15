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

          ## Alias

          - `mmdc`: Render a diagram, e.g. `mmdc -i input.mmd -o output.svg`.
        '';
      }
    ];

    packages = with pkgs; [
      mermaid-cli
    ];
  };
}
