{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    wtfutil
  ];
}
