{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = persistence-nvim;
      type = "lua";
      config = ''
        local persistence = require("persistence")

        persistence.setup({
          need = 1,
          branch = true,
        })

        require("which-key").add({
          { "<leader>sl", function() persistence.load() end, desc ="Load session" },
          { "<leader>sc", function() persistence.select() end, desc = "Select session" },
          { "<leader>ss", function() persistence.stop() end, desc = "Stop auto-save session" },
        })
      '';
    }
  ];
}
