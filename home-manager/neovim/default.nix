{ pkgs
, ...
}:
let
  nvim-cmp = import ./nvim-cmp.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    nil
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      /* cmp */
      vim-vsnip
      cmp-vsnip

      nvim-lspconfig
      cmp-nvim-lsp

      cmp-buffer
      cmp-path
      cmp-cmdline

      nvim-cmp
      /* cmp */
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
