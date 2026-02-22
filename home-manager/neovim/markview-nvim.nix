{
  pkgs,
  ...
}:
{
  home.file =
    with pkgs.miko;
    getDocs [
      {
        filePath = "neovim/markview-nvim";
        docs = ''
          # Neovim markview.nvim

          Markview.nvim is a plugin for Neovim that provides a mark viewer.

          [Repository](https://github.com/OXY2DEV/markview.nvim)

          ```nvim
          // Only in .md files
          :Markview ...
          ```
        '';
      }
    ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    markview-nvim
  ];
}
