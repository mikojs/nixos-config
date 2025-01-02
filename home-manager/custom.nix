{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    initialize
  ];
}
