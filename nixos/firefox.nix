{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    firefox
  ];

  programs.firefox.preferences = {
    "layout.css.devPixelsPerPx" = "0.3";
  };
}
