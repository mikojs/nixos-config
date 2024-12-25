{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = toggleterm-nvim;
      config = ''
        lua << END
          local wk = require("which-key")

          require("toggleterm").setup()
          wk.add({
            { "<leader>T", group = "Toggleterm" },
            { "<leader>Tt", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle terminal" },
            { "<leader>Tv", "<cmd>ToggleTerm direction=vertical size=60<cr>", desc = "Toggle vertical terminal" },
            { "<leader>Th", "<cmd>ToggleTerm<cr>", desc = "Toggle horizontal terminal" },
            { "<leader>Tn", "<cmd>ToggleTerm direction=tab<cr>", desc = "Toggle tab terminal" },
            { "<esc>", "<C-\\><C-n>", desc = "Exit terminal mode", mode = "t" },
          })
        END
      '';
    }
  ];
}
