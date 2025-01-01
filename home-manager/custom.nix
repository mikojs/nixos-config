{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    init
  ];
}
