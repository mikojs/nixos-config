{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = mini-icons;
      type = "lua";
      config = ''
        require("mini.icons").setup()
      '';
    }

    {
      plugin = mini-notify;
      type = "lua";
      config = ''
        require("mini.notify").setup()
      '';
    }

    {
      plugin = mini-trailspace;
      type = "lua";
      config = ''
        require("mini.trailspace").setup()
      '';
    }

    {
      plugin = mini-files;
      type = "lua";
      config = ''
        local mini_files = require("mini.files")

        mini_files.setup({
          mappings = {
            mark_goto = "",
            mark_set = "",
            reveal_cwd = "",
          },
        })
        require("which-key").add({
          { "<leader>f", mini_files.open, desc = "Manipulate files" },
        })
      '';
    }

    {
      plugin = mini-ai;
      type = "lua";
      config = ''
        require("mini.ai").setup({
          n_lines = 200,
          mappings = {
            around_next = "",
            inside_next = "",
            around_last = "",
            inside_next = "",
          },
        })
      '';
    }

    {
      plugin = mini-surround;
      type = "lua";
      config = ''
        require("mini.surround").setup({
          n_lines = 200,
        })
      '';
    }

    {
      plugin = mini-bracketed;
      type = "lua";
      config = ''
        require("mini.bracketed").setup()
      '';
    }

    {
      plugin = mini-comment;
      type = "lua";
      config = ''
        require("mini.comment").setup()
      '';
    }

    {
      plugin = mini-move;
      type = "lua";
      config = ''
        require("mini.move").setup()
      '';
    }

    {
      plugin = mini-align;
      type = "lua";
      config = ''
        require("mini.align").setup()
      '';
    }
  ];
}
