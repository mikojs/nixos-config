{
  pkgs,
  languages,
  ...
}:
let
  configs =
    map
      (
        m:
        import ./${m} {
          inherit pkgs languages;
        }
      )
      ([
        # Colorschema
        "tokyonight-nvim.nix"
        # UI
        "lualine-nvim.nix"
        "dressing-nvim.nix"
        # Lsp
        "nvim-treesitter.nix"
        "nvim-cmp"
        # Editor
        "which-key-nvim.nix"
        "telescope-nvim.nix"
        "gitsigns-nvim.nix"
        "toggleterm-nvim.nix"
        "barbar-nvim.nix"
        # Coding
        "mini-nvim.nix"
        # Formatting
        "conform-nvim"
        # AI
        "copilot-vim.nix"
      ]);

  getConfig =
    with builtins;
    (
      keys:
      (foldl' (
        result: config:
        let
          data = (
            foldl' (
              result: key: if result != null && hasAttr "${key}" result then result."${key}" else null
            ) config keys
          );
        in
        if data != null then result ++ data else result
      ) [ ] configs)
    );
in
{
  home.packages = getConfig ([
    "home"
    "packages"
  ]);

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = getConfig ([
      "programs"
      "neovim"
      "plugins"
    ]);

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
