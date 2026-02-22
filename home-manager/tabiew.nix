{
  pkgs,
  ...
}:
{
  home = {
    file = (import ../lib.nix).getDocs pkgs [
      {
        filePath = "tabiew";
        docs = ''
          # Tabiew

          Tabiew is a lightweight TUI application to view and query tabular data files, such as CSV, TSV, and parquet.

          [Repository](https://github.com/shshemi/tabiew)

          ```sh
          tw ...
          ```
        '';
      }
    ];

    packages = with pkgs; [
      tabiew
    ];
  };
}
