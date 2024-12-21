{ pkgs
, languages
, ...
}:
let
  configs = map
    (m: import ./${m} {
      inherit pkgs languages;
    })
    ([
      "nvim-treesitter.nix"
      "nvim-cmp"
      "tokyonight-nvim.nix"
      "mini-nvim.nix"
      "which-key-nvim.nix"
      "dressing-nvim.nix"
    ]);

  getConfig = with builtins; (keys: (foldl'
    (result: config:
      let
        data = (foldl'
          (result: key: if result != null && hasAttr "${key}" result then result."${key}" else null)
          config
          keys
        );
      in
      if data != null then result ++ data else result) [ ]
    configs
  ));
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
