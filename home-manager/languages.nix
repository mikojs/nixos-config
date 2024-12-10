{
  pkgs,
  languages,
  ...
}: {
  home.packages = with pkgs; with builtins; [ ] ++ (if elem "c" languages then [ libgccjit ] else [ ]);
}

