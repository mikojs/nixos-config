{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    miko-initialize
    miko-coder
  ];
}
