{
  pkgs,
  ...
}:
{
  home.file = (import ../../../lib.nix).getDocs pkgs [
    {
      filePath = "neovim/windsurf-nvim";
      docs = ''
        # Neovim windsurf.nvim

        Windsurf.nvim is a plugin for Neovim that provides AI code completion.

        [Repository](https://github.com/Exafunction/windsurf.vim)

      '';
    }
  ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    plenary-nvim

    {
      plugin = windsurf-nvim;
      type = "lua";
      config = ''
        require("codeium").setup({
          enable_cmp_source = false,
          virtual_text = {
            enabled = true,
            key_bindings = {
              accept = "<A-CR>",
            },
          },
        })
      '';
    }
  ];
}
