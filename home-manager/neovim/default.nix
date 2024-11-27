{ pkgs
, ...
}:
let
  nvim-cmp = import ./nvim-cmp.nix { inherit pkgs; };
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      /* cmp */
      cmp-nvim-lsp
      nvim-lspconfig
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
