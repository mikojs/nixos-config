{
  pkgs,
  ...
}:
{
  packages = with pkgs; [
    nixfmt
  ];

  support = [ "- `nixfmt`: Formats Nix." ];

  formatter = ''nix = { "nixfmt" },'';
}
