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
          local toggleterm = require("toggleterm")

          local send_selection_to_terminal = function()
            toggleterm.send_lines_to_terminal("visual_selection", true, { args = vim.v.count })
          end

          toggleterm.setup()
          wk.add({
            { "<leader>T", group = "Terminal (Toggleterm)" },
            { "<leader>Tt", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle terminal" },
            { "<leader>Tv", "<cmd>ToggleTerm direction=vertical size=60<cr>", desc = "Toggle vertical terminal" },
            { "<leader>Th", "<cmd>ToggleTerm<cr>", desc = "Toggle horizontal terminal" },
            { "<leader>Tn", "<cmd>ToggleTerm direction=tab<cr>", desc = "Toggle tab terminal" },
            { "<leader>s", send_selection_to_terminal, desc = "Send selection to terminal", mode = "v" },
            { "<esc>", "<C-\\><C-n>", desc = "Exit terminal mode", mode = "t" },
          })
        END
      '';
    }
  ];
}
