{
  pkgs,
  ...
}:
{
  home.file = {
    ".docs/neovim/onenord-nvim.md".text = ''
      # Neovim onenord.nvim

      Onenord.nvim is a colorscheme plugin for Neovim.

      [Repository](https://github.com/rmehri01/onenord.nvim)

    '';
  };

  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = onenord-nvim;
      config = ''
        colorscheme onenord
      '';
    }
  ];
}
