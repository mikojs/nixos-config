{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    osquery
  ];
}
