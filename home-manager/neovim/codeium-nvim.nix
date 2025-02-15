{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    plenary-nvim

    {
      plugin = codeium-nvim;
      config = ''
        lua << END
          require("codeium").setup({})
        END
      '';
    }
  ];
}
