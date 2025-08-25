{
  pkgs,
  ...
}:
with pkgs;
{
  home.packages = [
    miko-initialize
    miko-coder
  ];

  programs.fish.interactiveShellInit = miko-fish.interactiveShellInit;
}
