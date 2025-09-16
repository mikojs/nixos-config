{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = toggleterm-nvim;
      type = "lua";
      config = ''
        local toggleterm = require("toggleterm")

        local send_selection_to_terminal = function()
          toggleterm.send_lines_to_terminal("visual_selection", true, { args = vim.v.count })
        end

        toggleterm.setup()
        require("which-key").add({
          { "<leader>Tn", "<Cmd>ToggleTerm direction=float<CR>", desc = "Toggle terminal" },
          { "<leader>Tv", "<Cmd>ToggleTerm direction=vertical size=60<CR>", desc = "Toggle vertical terminal" },
          { "<leader>Th", "<Cmd>ToggleTerm direction=horizontal size=10<CR>", desc = "Toggle horizontal terminal" },
          { "<leader>Tt", "<Cmd>ToggleTerm direction=tab<CR>", desc = "Toggle tab terminal" },
          { "<leader>st", send_selection_to_terminal, desc = "Send selection to terminal", mode = "v" },
          { "<Esc>", "<C-\\><C-n>", desc = "Exit terminal mode", mode = "t" },
        })
      '';
    }
  ];
}
