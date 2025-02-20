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
      copy-on-select = false;
      clipboard-read = "allow";
    };
  };
}
