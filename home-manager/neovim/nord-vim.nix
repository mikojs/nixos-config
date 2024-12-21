{ pkgs
, ...
}: {
  home.packages = [ ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    nord-vim
  ];
}
