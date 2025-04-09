{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    miko-db
  ];
}
