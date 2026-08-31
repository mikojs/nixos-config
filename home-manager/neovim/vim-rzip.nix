{
  pkgs,
  miko,
  ...
}:
{
  home = {
    file = miko.getDocs [
      {
        filePath = "neovim/vim-rzip";
        docs = ''
          # Neovim vim-rzip

          Vim-rzip is a plugin for Neovim that provides a wrapper for zip files.

          [Repository](https://github.com/lbrayner/vim-rzip)

          ## Support packages

          - `unzip`: Vim-rzip calls it to browse the contents of a zip file.
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
