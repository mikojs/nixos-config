{
  pkgs,
  miko,
  ...
}:
{
  home.file = miko.getDocs [
    {
      filePath = "find-files";
      docs = ''
        # find-files

        Recursively list all files in a directory, including dotfiles. Defaults to
        the current directory when no argument is given.

        [Code](https://github.com/mikojs/nixos-config/tree/main/home-manager/find-files.nix)

        ```sh
        find-files [dir]
        ```
      '';
    }
  ];

  home.packages = [
    (pkgs.writeShellScriptBin "find-files" ''
      find-files() {
        local dir="$1"
        local file

        for file in $(ls -A "$dir"); do
          if [ -d "$dir/$file" ]; then
            find-files "$dir/$file"
          else
            echo "$dir/$file"
          fi
        done
      }

      find-files "''${1:-.}"
    '')
  ];
}
