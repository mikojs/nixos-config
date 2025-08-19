{
  pkgs,
  ...
}:
{
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
