{
  name,
  ...
}:
{
  ...
}:
{
  home.file = (import ../../lib.nix).getDocs pkgs [
    {
      filePath = "kitty";
      docs = ''
        # Kitty

        The fast, feature-rich, cross-platform, GPU based terminal.

        [Repository](https://github.com/kovidgoyal/kitty)

      '';
    }
  ];

  programs.kitty = {
    enable = true;
    extraConfig =
      with builtins;
      # FIXME: default shell, https://github.com/nix-darwin/nix-darwin/issues/1237
      (replaceStrings [ "fish" ] [ "/etc/profiles/per-user/${name}/bin/fish" ] (readFile ./kitty));
  };
}
