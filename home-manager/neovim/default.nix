{ nixpkgs
, pkgs
, ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
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

    extraLuaConfig = with pkgs.vimPlugins;
      # Lua
      ''
        require("lazy").setup({
          -- disable all update / install features
          -- this is handled by nix
          rocks = { enabled = false },
          pkg = { enabled = false },
          install = { missing = false },
          change_detection = { enabled = false },
          spec = {
            ${nixpkgs.lib.concatStrings (map(m: import ./${m}.nix { inherit pkgs; }) ([
              "nvim-cmp"
            ] ++ (import ./lsp)))}
          },
        })
      '';
  };
}
