{
  pkgs,
  miko,
  ...
}:
{
  home.file = miko.getDocs [
    {
      filePath = "neovim/octo-nvim";
      docs = ''
        # Neovim octo.nvim

        Octo.nvim is a GitHub plugin for Neovim.

        [Repository](https://github.com/pwntester/octo.nvim)

        ```nvim
        :Octo ...
        ```
      '';
    }
  ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = octo-nvim;
      type = "lua";
      config = ''
        require("octo").setup()
      '';
    }
  ];
}
