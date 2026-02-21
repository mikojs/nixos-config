{
  pkgs,
  ...
}:
{
  home = {
    file.".docs/tabiew.md".text = ''
      # Tabiew

      Tabiew is a lightweight TUI application to view and query tabular data files, such as CSV, TSV, and parquet.

      [Repository](https://github.com/shshemi/tabiew)

      ```sh
      tw ...
      ```
      ${(import ../lib.nix).getDocs pkgs "tabiew"}
    '';

    packages = with pkgs; [
      tabiew
    ];
  };
}
