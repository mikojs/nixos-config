{
  ...
}:
{
  specialisation.i3.configuration = {
    services = {
      displayManager.defaultSession = "none+i3";

      xserver = {
        enable = true;
        # macbook 16 inch
        dpi = 257;

        desktopManager = {
          xterm.enable = false;
          wallpaper.mode = "fill";
        };

        windowManager.i3 = {
          enable = true;
          configFile = ./i3;
        };
      };
    };
  };
}
