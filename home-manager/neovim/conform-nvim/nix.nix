{
  pkgs,
  ...
}:
{
  packages = with pkgs; [
    nixfmt
  ];

  formatter = ''nix = { "nixfmt" },'';
}
