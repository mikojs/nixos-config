{
  language,
}:
{
  pkgs,
  miko,
  ...
}:
{
  home = {
    file = miko.getDocs [
      {
        filePath = "litecli";
        docs = ''
          # Litecli

          A command-line interface for SQLite.

          [Repository](https://github.com/dbcli/litecli)
        '';
      }
    ];

    packages = with pkgs; [
      sqlite
      litecli
    ];
  };
}
