{
  ...
}:
{
  specialisation.i3.configuration = {
    services.xserver = {
      enable = true;
      # macbook 16 inch
      dpi = 257;

      desktopManager = {
        xterm.enable = false;
        wallpaper.mode = "fill";
      };

      displayManager.defaultSession = "none+i3";
      windowManager.i3.enable = true;
    };
  };
}
