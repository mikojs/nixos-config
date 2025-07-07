{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    plenary-nvim

    {
      plugin = windsurf-nvim;
      config = ''
        lua << END
          require("windsurf").setup({
            enable_cmp_source = false,
            virtual_text = {
              enabled = true,
              key_bindings = {
                accept = "<A-CR>",
              },
            },
          })
        END
      '';
    }
  ];
}
