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
      type = "lua";
      config = ''
        local builtin = require("telescope.builtin")

        local single_or_multi_select = function(prompt_bufnr)
          local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
          local has_multi_selection = next(current_picker:get_multi_selection()) ~= nil

          if has_multi_selection then
            local results = {}

            require("telescope.actions.utils").map_selections(prompt_bufnr, function(selection)
              table.insert(results, selection[1]:match("(.-):%d+:%d+") or selection[1])
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

        -- follow: https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#file-and-text-search-in-hidden-files-and-directories
        local telescopeConfig = require("telescope.config")
        local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

        table.insert(vimgrep_arguments, "--hidden")
        table.insert(vimgrep_arguments, "-L")
        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/.git/*")

        -- follow: https://github.com/nvim-telescope/telescope.nvim/issues/416
        require("telescope").setup({
          pickers = {
            find_files = {
              find_command = { "rg", "--files", "--hidden", "-L", "--glob", "!**/.git/*" },
            },
          },
          defaults = {
            vimgrep_arguments = vimgrep_arguments,
            mappings = {
              i = {
                ["<CR>"] = single_or_multi_select,
              },
            },
          },
        })

        require("which-key").add({
          { "<leader>F", builtin.find_files, desc = "Find files" },
          { "<leader>G", builtin.live_grep, desc = "Search with grep" },
          { "<leader>B", builtin.buffers, desc = "Show buffers" },
          { "<leader>?", builtin.help_tags, desc = "Help" },
          { "<leader>K", builtin.keymaps, desc = "Show keymaps" },

          { "<leader>dS", builtin.diagnostics, desc = "Show diagnostics" },

          { "<leader>gT", builtin.git_status, desc = "Show git status" },
          { "<leader>gA", builtin.git_stash, desc = "Show git stash" },
          { "<leader>gC", builtin.git_commits, desc = "Show git commit" },

          { "<leader>lD", builtin.lsp_definitions, desc = "Go to definitions" },
          { "<leader>lT", builtin.lsp_type_definitions, desc = "Go to type definitions" },
          { "<leader>lR", builtin.lsp_references, desc = "Show references" },
          { "<leader>lI", builtin.lsp_implementations, desc = "Go to implementations" },

          { "<leader>DF", function() builtin.find_files({ cwd = "~/.docs" }) end, desc = "Find files in the docs directory" },
          { "<leader>DG", function() builtin.live_grep({ cwd = "~/.docs" }) end, desc = "Search with grep in the docs directory" },
        })
      '';
    }
  ];
}
