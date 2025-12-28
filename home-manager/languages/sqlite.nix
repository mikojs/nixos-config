{
  language,
}:
{
  pkgs,
  ...
}:
{
  home = {
    file = {
      ".docs/sqlite/litecli.md".text = ''
        # litecli

        A command-line interface for SQLite.

        [Repository](https://github.com/dbcli/litecli)

      '';
    };

    packages =
      with pkgs;
      [
        sqlite
        litecli
      ]
      ++ (import ./db.nix { inherit pkgs; }).home.packages;
  };
}
