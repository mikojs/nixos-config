{
  pkgs,
  ...
}:
{
  home.file = {
    ".docs/neovim/markview-nvim.md".text = ''
      # Neovim markview.nvim

      Markview.nvim is a plugin for Neovim that provides a mark viewer.

      [Repository](https://github.com/OXY2DEV/markview.nvim)

      ```nvim
      :Markview ...
      ```

    '';
  };

  programs.neovim.plugins = with pkgs.vimPlugins; [
    markview-nvim
  ];
}
