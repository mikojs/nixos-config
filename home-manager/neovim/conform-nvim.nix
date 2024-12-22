{
  pkgs, ...
}:
{
  home.packages = with pkgs; [
    nixfmt-rfc-style
  ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = conform-nvim;
      config = ''
        lua << END
          require("conform").setup({
            formatters_by_ft = {
              nix = { "nixfmt" },
            },
          })
        END
      '';
    }
  ];
}
