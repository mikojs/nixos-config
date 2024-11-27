{
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      nvim-cmp
    ];

    extraConfig = ''
      set encoding=utf-8
      set nu
      set ruler

      " tab setting
      set expandtab
      set tabstop=2
      set shiftwidth=2
      retab

      " set backspace
      set backspace=indent,eol,start

      set nocompatible
    '';
  };
}