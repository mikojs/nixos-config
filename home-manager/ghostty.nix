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
  };
}
