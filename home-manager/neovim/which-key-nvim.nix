{
  pkgs,
  ...
}:
{
  home.file = {
    ".docs/neovim/which-key-nvim.md".text = ''
      # Neovim which-key-nvim

      Which-key.nvim is a plugin for Neovim that shows a popup with available keybindings.

      [Repository](https://github.com/folke/which-key.nvim)

    '';
  };

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
