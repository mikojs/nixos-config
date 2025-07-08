{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    unzip
  ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    vim-rzip
  ];
}
