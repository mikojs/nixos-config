{
  language,
}:
{
  pkgs,
  miko,
  ...
}:
let
  db = import ./db.nix { inherit pkgs; };
in
{
  home = {
    file =
      miko.getDocs [
        {
          filePath = "litecli";
          docs = ''
            # Litecli

            A command-line interface for SQLite.

            [Repository](https://github.com/dbcli/litecli)
          '';
        }
      ]
      // db.home.file;

    packages =
      with pkgs;
      [
        sqlite
        litecli
      ]
      ++ db.home.packages;
  };
}
