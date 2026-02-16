{
  pkgs,
  ...
}:
{
  home = {
    file.".docs/db.md".text = ''
      # [miko] DB

      Some helpful commands for working with databases.
      Use `--help` to see available commands.

      [Code](https://github.com/mikojs/nixos-config/tree/main/overlays/custom/db)

    '';

    packages = with pkgs; [
      miko-db
    ];
  };
}
