{
  languages,
}:
{
  pkgs,
  ...
}:
{
  home.packages =
    with pkgs;
    [
      sqlite
      litecli
    ]
    ++ (import ./db.nix { inherit pkgs; }).home.packages;
}
