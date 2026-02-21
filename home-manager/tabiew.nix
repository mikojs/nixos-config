{
  pkgs,
  ...
}:
{
  home = {
    file.".docs/tabiew.md".text = (import ../lib.nix).getDocs pkgs "tabiew" ''
      # Tabiew

      Tabiew is a lightweight TUI application to view and query tabular data files, such as CSV, TSV, and parquet.

      [Repository](https://github.com/shshemi/tabiew)

      ```sh
      tw ...
      ```
    '';

    packages = with pkgs; [
      tabiew
    ];
  };
}
