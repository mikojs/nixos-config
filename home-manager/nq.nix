{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    nq
  ];
}
