{
  ...
}:
{
  services.xserver.xrandrHeads = [
    {
      output = "Virtual-1";
      primary = true;
    }
  ];

  specialisation.i3.configuration = {
    services = {
      displayManager.defaultSession = "none+i3";

      xserver = {
        enable = true;
        # macbook 16 inch
        virtualScreen = {
          x = 3456;
          y = 2160;
        };
        dpi = 226;

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
