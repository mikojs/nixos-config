{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    ripgrep
    fd
  ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = telescope-nvim;
      config = ''
        lua << END
          local builtin = require("telescope.builtin")

          local single_or_multi_select = function(prompt_bufnr)
            local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            local has_multi_selection = next(current_picker:get_multi_selection()) ~= nil

            if has_multi_selection then
              local results = {}

              require("telescope.actions.utils").map_selections(prompt_bufnr, function(selection)
                table.insert(results, selection[1])
              end)

              for _, filepath in ipairs(results) do
                vim.cmd.badd({ args = { filepath } })
              end

              require("telescope.pickers").on_close_prompt(prompt_bufnr)

              if vim.fn.bufname() == "" and not vim.bo.modified then
                vim.cmd.bwipeout()
                vim.cmd.buffer(results[1])
              end

              return
            end

            require("telescope.actions").file_edit(prompt_bufnr)
          end

          require("telescope").setup({
            defaults = {
              mappings = {
                i = {
                  ["<cr>"] = single_or_multi_select,
                },
              },
            },
          })

          require("which-key").add({
            { "<leader>T", group = "Telescope" },
            { "<leader>Tf", builtin.find_files, desc = "Telescope find files" },
            { "<leader>Tl", builtin.live_grep, desc = "Telescope live grep" },
            { "<leader>Tb", builtin.buffers, desc = "Telescope buffers" },
            { "<leader>Th", builtin.help_tags, desc = "Telescope help tags" },
            { "<leader>Tk", builtin.keymaps, desc = "Telescope keymaps" },

            { "<leader>Tg", group = "Telescope git" },
            { "<leader>Tgs", builtin.git_status, desc = "Telescope git status" },
            { "<leader>Tgh", builtin.git_stash, desc = "Telescope git stash" },
            { "<leader>Tgc", builtin.git_commits, desc = "Telescope git commit" },

            { "<leader>Tl", group = "Telescope lsp" },
            { "<leader>Tld", builtin.lsp_definitions, desc = "Telescope lsp definitions" },
            { "<leader>Tlt", builtin.lsp_type_definitions, desc = "Telescope lsp type definitions" },
            { "<leader>Tlr", builtin.lsp_references, desc = "Telescope lsp references" },
            { "<leader>Tla", builtin.lsp_implementations, desc = "Telescope lsp implementations" },
            { "<leader>Tli", builtin.lsp_incoming_calls, desc = "Telescope lsp incoming calls" },
            { "<leader>Tlo", builtin.lsp_outgoing_calls, desc = "Telescope lsp outgoing calls" },
            { "<leader>Tlc", builtin.lsp_document_symbols, desc = "Telescope lsp document symbols" },
          })
        END
      '';
    }
  ];
}
