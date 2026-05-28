{
  pkgs,
  miko,
  ...
}:
{
  home = {
    file = miko.getDocs [
      {
        filePath = "db";
        docs = ''
          # [miko] DB

          Some helpful commands for working with databases.
          Use `--help` to see available commands.

          [Code](https://github.com/mikojs/nixos-config/tree/main/overlays/custom/db)
        '';
      }
    ];

    packages = with pkgs; [
      miko-db
    ];
  };

  programs.fish.interactiveShellInit = ''
    # db
    if type -q db
      db --generate fish | source
    end
  '';
}
