{
  pkgs,
  ...
}:
{
  packages = with pkgs; [
    nixfmt-rfc-style
  ];

  formatter = ''nix = { "nixfmt" },'';
}
