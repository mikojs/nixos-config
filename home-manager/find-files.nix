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
    (pkgs.writeShellApplication {
      name = "find-files";

      text = ''
        shopt -s dotglob nullglob

        find-files() {
          local dir="$1"
          local file

          for file in "$dir"/*; do
            if [ -d "$file" ]; then
              find-files "$file"
            else
              echo "$file"
            fi
          done
        }

        find-files "''${1:-.}"
      '';
    })
  ];
}
