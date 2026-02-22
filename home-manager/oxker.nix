{
  pkgs,
  ...
}:
{
  home = {
    file =
      with pkgs.miko;
      getDocs [
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
