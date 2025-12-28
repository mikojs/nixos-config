{
  pkgs,
  ...
}:
{
  home.file = {
    ".docs/fish/tide.md".text = ''
      # Fish tide

      Tide is the ultimate Fish prompt.

      [Repository](https://github.com/IlanCosman/tide)

    '';
  };

  programs.fish.plugins = with pkgs.fishPlugins; [
    {
      name = "tide";
      src = tide.src;
    }
  ];
}
