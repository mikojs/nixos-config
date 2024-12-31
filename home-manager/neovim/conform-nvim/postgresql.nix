{
  pkgs,
  ...
}:
{
  packages = with pkgs; [
    pgformatter
  ];

  formatter = ''sql = { "pg_format" }'';
}
