{
  pkgs,
  ...
}:
{
  packages = with pkgs; [
    pgformatter
  ];

  support = [ "- `pgformatter`: Provides `pg_format`, which formats SQL." ];

  formatter = ''sql = { "pg_format" },'';
}
