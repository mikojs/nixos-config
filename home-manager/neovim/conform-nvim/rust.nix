{
  pkgs,
  ...
}:
{
  packages = with pkgs; [
    rustfmt
  ];

  formatter = ''rust = { "rustfmt" }'';
}
