{
  pkgs,
  ...
}:
{
  packages = with pkgs; [
    rustfmt
  ];

  support = [ "- `rustfmt`: Formats Rust." ];

  formatter = ''rust = { "rustfmt" },'';
}
