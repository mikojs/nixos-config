{
  pkgs,
  ...
}:
{
  programs.fish.plugins = with pkgs.fishPlugins; [
    {
      name = "tide";
      src = tide.src;
    }
  ];
}
