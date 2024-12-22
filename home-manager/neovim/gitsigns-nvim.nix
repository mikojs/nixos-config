{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = gitsigns-nvim;
      config = ''
        lua << END
          require('gitsigns').setup({
            numhl = true,
            current_line_blame = true,
            current_line_blame_opts = {
              delay = 100,
            },
          })
        END
      '';
    }
  ];
}
