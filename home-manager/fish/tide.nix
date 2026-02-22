{
  pkgs,
  ...
}:
{
  home.file = (import ../../lib.nix).getDocs pkgs [
    {
      filePath = "fish/tide";
      docs = ''
        # Fish tide

        Tide is the ultimate Fish prompt.

        [Repository](https://github.com/IlanCosman/tide)

      '';
    }
  ];

  programs.fish.plugins = with pkgs.fishPlugins; [
    {
      name = "tide";
      src = tide.src;
    }
  ];
}
