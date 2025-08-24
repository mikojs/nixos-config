{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    miko-initialize
    miko-coder
  ];

  programs.fish.interactiveShellInit = with pkgs; ''
    ${miko-fish.interactiveShellInit}
  '';
}
