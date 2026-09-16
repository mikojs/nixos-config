{
  name,
  ...
}:
{
  miko,
  ...
}:
{
  home.file = miko.getDocs [
    {
      filePath = "kitty";
      docs = ''
        # Kitty

        The fast, feature-rich, cross-platform, GPU based terminal.

        [Repository](https://github.com/kovidgoyal/kitty)

        ## Gotcha

        - On macOS, Option is remapped to Alt (`macos_option_as_alt yes`), which
          disables the default Option-based accented-character input.
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
