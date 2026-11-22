{
  pkgs,
  miko,
  ...
}:
{
  home = {
    file = miko.getDocs [
      {
        filePath = "herdr";
        docs = ''
          # Herdr

          Herdr is a terminal multiplexer that shows the state of every running AI agent at a glance.

          [Repository](https://github.com/herdrdev/herdr)
        '';
      }
    ];

    packages = with pkgs; [
      herdr
    ];
  };
}
