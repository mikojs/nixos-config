{
  pkgs,
  ...
}:
{
  packages = with pkgs.nodePackages; [
    prettier
  ];
  formatter = ''javascript = { "prettier" }'';
}
