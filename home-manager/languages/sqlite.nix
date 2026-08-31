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
        filePath = "sqlite";
        docs = ''
          # SQLite

          Self-contained, serverless, zero-configuration, transactional SQL database engine.

          [Website](https://www.sqlite.org/)
        '';
      }
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
