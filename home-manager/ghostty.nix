{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    xclip
  ];

  programs.ghostty = {
    enable = true;
    settings = {
      app-notifications = false;
      clipboard-read = "allow";
      copy-on-select = false;
      gtk-titlebar = false;
    };
  };
}
