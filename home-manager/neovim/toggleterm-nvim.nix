{
  pkgs,
  ...
}:
{
  home.file.".docs/neovim/toggleterm-nvim.md".text = ''
    # Neovim toggleterm.nvim

    Toggleterm.nvim is a terminal plugin for Neovim.

    [Repository](https://github.com/akinsho/toggleterm.nvim)

    ## Keybindings

    | Description                    | Key           |
    | ---                            | ---           |
    | Toggle terminal                | `<leader>Tn`  |
    | Toggle vertical terminal       | `<leader>Tv`  |
    | Toggle horizontal terminal     | `<leader>Th`  |
    | Toggle tab terminal            | `<leader>Tt`  |
    | Toggle new terminal            | `<leader>Tan` |
    | Toggle new vertical terminal   | `<leader>Tav` |
    | Toggle new horizontal terminal | `<leader>Tah` |
    | Toggle new tab terminal        | `<leader>Tat` |
    | Select terminal                | `<leader>Ts`  |
    | Send selection to terminal     | `<leader>st`  |

  '';

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
          { "<leader>Tan", "<Cmd>TermNew direction=float<CR>", desc = "Toggle new terminal" },
          { "<leader>Tav", "<Cmd>TermNew direction=vertical size=60<CR>", desc = "Toggle new vertical terminal" },
          { "<leader>Tah", "<Cmd>TermNew direction=horizontal size=10<CR>", desc = "Toggle new horizontal terminal" },
          { "<leader>Tat", "<Cmd>TermNew direction=tab<CR>", desc = "Toggle new tab terminal" },
          { "<leader>Ts", "<Cmd>TermSelect<CR>", desc = "Select terminal" },
          { "<leader>st", send_selection_to_terminal, desc = "Send selection to terminal", mode = "v" },
          { "<Esc>", "<C-\\><C-n>", desc = "Exit terminal mode", mode = "t" },
        })
      '';
    }
  ];
}
