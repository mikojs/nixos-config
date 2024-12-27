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
          local toggleterm = require("toggleterm")

          local send_selection_to_terminal = function()
            toggleterm.send_lines_to_terminal("visual_selection", true, { args = vim.v.count })
          end

          toggleterm.setup()
          require("which-key").add({
            { "<leader>t", group = "Terminal (Toggleterm)" },
            { "<leader>tn", "<Cmd>ToggleTerm direction=float<CR>", desc = "Toggle terminal" },
            { "<leader>tv", "<Cmd>ToggleTerm direction=vertical size=60<CR>", desc = "Toggle vertical terminal" },
            { "<leader>th", "<Cmd>ToggleTerm<CR>", desc = "Toggle horizontal terminal" },
            { "<leader>tt", "<Cmd>ToggleTerm direction=tab<CR>", desc = "Toggle tab terminal" },
            { "<leader>s", send_selection_to_terminal, desc = "Send selection to terminal", mode = "v" },
            { "<Esc>", "<C-\\><C-n>", desc = "Exit terminal mode", mode = "t" },
          })
        END
      '';
    }
  ];
}
