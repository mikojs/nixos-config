{ pkgs
, ...
}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    dressing-nvim
  ];
}
