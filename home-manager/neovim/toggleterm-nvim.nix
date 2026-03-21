{
  pkgs,
  miko,
  ...
}:
{
  home.file = miko.getDocs [
    {
      filePath = "neovim/toggleterm-nvim";
      docs = ''
        # Neovim toggleterm.nvim

        Toggleterm.nvim is a terminal plugin for Neovim.

        [Repository](https://github.com/akinsho/toggleterm.nvim)

        ## Keybindings

        | Description                            | Key          |
        | ---                                    | ---          |
        | Toggle terminal                        | `<leader>Tn` |
        | Toggle vertical terminal               | `<leader>Tv` |
        | Toggle horizontal terminal             | `<leader>Th` |
        | Toggle tab terminal                    | `<leader>Tt` |
        | Send selection to terminal             | `<leader>st` |
        | Send file ref (path:lines) to terminal | `<leader>sl` |
      '';
    }
  ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = toggleterm-nvim;
      type = "lua";
      config = ''
        local toggleterm = require("toggleterm")

        local send_selection_to_terminal = function()
          toggleterm.send_lines_to_terminal("visual_selection", true, { args = vim.v.count })
        end

        vim.api.nvim_create_user_command("SendFileRef", function(opts)
          local start_line = opts.line1
          local end_line = opts.line2
          local rel_path = vim.fn.expand('%')
          local ref = rel_path .. ":" .. start_line

          if end_line ~= start_line then
            ref = ref .. "-" .. end_line
          end

          local terminals = require("toggleterm.terminal").get_all()

          if #terminals > 0 then
            local term = terminals[#terminals]

            vim.api.nvim_chan_send(term.job_id, ref)
            term:focus()
          end
        end, { range = true })

        toggleterm.setup()
        require("which-key").add({
          { "<leader>Tn", "<Cmd>ToggleTerm direction=float<CR>", desc = "Toggle terminal" },
          { "<leader>Tv", "<Cmd>ToggleTerm direction=vertical size=80<CR>", desc = "Toggle vertical terminal" },
          { "<leader>Th", "<Cmd>ToggleTerm direction=horizontal size=30<CR>", desc = "Toggle horizontal terminal" },
          { "<leader>Tt", "<Cmd>ToggleTerm direction=tab<CR>", desc = "Toggle tab terminal" },
          { "<leader>st", send_selection_to_terminal, desc = "Send selection to terminal", mode = "v" },
          { "<leader>sl", ":SendFileRef<CR>", desc = "Send file ref (path:lines) to terminal", mode = "v" },
          { "<Esc>", "<C-\\><C-n>", desc = "Exit terminal mode", mode = "t" },
        })
      '';
    }
  ];
}
