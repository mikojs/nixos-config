{
  lib,
  pkgs,
  miko,
  timezones,
  ...
}:
with lib;
optionalAttrs (length timezones > 0) {
  home.file = miko.getDocs [
    {
      filePath = "times";
      docs = ''
        # times

        Show the current time in each configured timezone.

        [Code](https://github.com/mikojs/nixos-config/tree/main/home-manager/times.nix)

        ```sh
        times
        ```
      '';
    }
  ];

  home.packages = [
    (pkgs.writeShellScriptBin "times" ''
      {
        echo "timezone,time"
        ${concatStringsSep "\n" (
          map (t: ''echo "${t},$(TZ=${t} date +'%Y-%m-%d %H:%M:%S')"'') timezones
        )}
      } | column -t -s ','
    '')
  ];
}
