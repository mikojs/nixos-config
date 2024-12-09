{ pkgs
, languages
, ...
}:
let
  getConfig = (keys: (builtins.foldl'
    (result: config:
      let
        data = (builtins.foldl' (result: key: if result != null && builtins.hasAttr "${key}" result then result."${key}" else null) config keys);
      in
      if data != null then result ++ data else result) [ ]
    (
      map
        (m: import ./${m}.nix {
          inherit pkgs languages;
        })
        ([
          "nvim-cmp"
          "nvim-treesitter"
        ])
    )));
in
{
  home.packages = getConfig ([ "home" "packages" ]);

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = getConfig ([ "programs" "neovim" "plugins" ]);

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
