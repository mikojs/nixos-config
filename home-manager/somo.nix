{
  pkgs,
  miko,
  ...
}:
{
  home = {
    file = miko.getDocs [
      {
        filePath = "somo";
        docs = ''
          # Somo

          Somo is a human-friendly alternative to netstat for socket and port monitoring on Linux and macOS.

          [Repository](https://github.com/theopfr/somo)
        '';
      }
    ];

    packages = with pkgs; [
      somo
    ];
  };
}
