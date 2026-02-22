{ language }:
{
  pkgs,
  ...
}:
with builtins;
let
  version = if hasAttr "version" language then "_${language.version}" else "";
  db = import ./db.nix { inherit pkgs; };
in
{
  home = {
    file =
      (import ../../../lib.nix).getDocs pkgs [
        {
          filePath = "pgcli";
          docs = ''
            # PGcli

            A command-line interface for PostgreSQL.

            [Repository](https://github.com/dbcli/pgcli)

          '';
        }
      ]
      // db.home.file;

    packages =
      with pkgs;
      [
        pkgs."postgresql${version}"
        pgcli
      ]
      ++ db.home.packages;
  };

  xdg.configFile."pgcli/config".text = ''
    [main]
    use_local_timezone = False
    keyring = False
  '';
}
