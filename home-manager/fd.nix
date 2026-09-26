{
  pkgs,
  miko,
  ...
}:
{
  home = {
    file = miko.getDocs [
      {
        filePath = "fd";
        docs = ''
          # fd

          fd is a simple, fast and user-friendly alternative to `find`.

          [Repository](https://github.com/sharkdp/fd)

          ## Gotcha

          - Searches skip dotfiles and anything `.gitignore` covers by default, so a bare
            `fd` does not list every file. To list them all, pass `-H` (hidden) and `-I`
            (no ignore): `fd -H -I -t f . [dir]` returns exactly what
            `find [dir] -type f` would.
        '';
      }
    ];

    packages = with pkgs; [
      fd
    ];
  };
}
