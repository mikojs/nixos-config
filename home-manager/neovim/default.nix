{ pkgs
, ...
}:
let
  getConfig = (key: (builtins.foldl' (result: config: if builtins.hasAttr "${key}" config then result ++ config."${key}" else result) [ ] (
    map (m: import ./${m}.nix { inherit pkgs; }) ([
      "nvim-cmp"
    ])
  )));
in
{
  home.packages = getConfig ("packages");

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = getConfig ("plugins");

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
