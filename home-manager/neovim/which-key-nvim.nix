{
  pkgs,
  ...
}:
{
  home.file =
    with pkgs.miko;
    getDocs [
      {
        filePath = "neovim/which-key-nvim";
        docs = ''
          # Neovim which-key.nvim

          Which-key.nvim is a plugin for Neovim that shows a popup with available keybindings.

          [Repository](https://github.com/folke/which-key.nvim)
        '';
      }
    ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = which-key-nvim;
      type = "lua";
      config = ''
        require("which-key").setup({
          icons = {
            mappings = false,
            keys = {
              Space = "Space",
              Esc = "Esc",
              BS = "Backspace",
              C = "Ctrl-",
            },
          },
        })
      '';
    }
  ];
}
