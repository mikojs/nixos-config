{
  userName,
}:
{
  ...
}:
{
  programs.kitty = {
    enable = true;
    extraConfig =
      with builtins;
      # FIXME default shell, https://github.com/nix-darwin/nix-darwin/issues/1237
      (replaceStrings [ "fish" ] [ "/etc/profiles/per-user/${userName}/bin/fish" ] (readFile ./kitty));
  };
}
