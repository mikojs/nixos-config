{
  pkgs,
  ...
}:
{
  home = {
    home.file = (import ../../lib.nix).getDocs pkgs [
      {
        filePath = "neovim/vim-rzip";
        docs = ''
          # Neovim vim-rzip

          Vim-rzip is a plugin for Neovim that provides a wrapper for zip files.

          [Repository](https://github.com/lbrayner/vim-rzip)
        '';
      }
    ];

    packages = with pkgs; [
      unzip
    ];
  };

  programs.neovim.plugins = with pkgs.vimPlugins; [
    vim-rzip
  ];
}
