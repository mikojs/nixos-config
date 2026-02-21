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

      ## Note

      If you need some help, you could use `:help` in the tabiew view.

    '';

    packages = with pkgs; [
      tabiew
    ];
  };
}
