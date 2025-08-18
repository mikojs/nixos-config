{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    somo
  ];
}
