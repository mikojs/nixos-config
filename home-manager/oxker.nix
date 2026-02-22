{
  pkgs,
  ...
}:
{
  home = {
    file = (import ../lib.nix).getDocs pkgs [
      {
        filePath = "oxker";
        docs = ''
          # Oxker

          A simple tui to view & control docker containers.

          [Repository](https://github.com/mrjackwills/oxker)
        '';
      }
    ];

    packages = with pkgs; [
      oxker
    ];
  };
}
