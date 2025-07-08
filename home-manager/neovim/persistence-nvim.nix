{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = persistence-nvim;
      config = ''
        lua << END
          local persistence = require("persistence")

          persistence.setup({
            need = 1,
            branch = true,
          })

          require("which-key").add({
            { "<leader>s", group = "Session" },
            { "<leader>sl", function() persistence.load({ last = true }) end, desc ="Load last session" },
            { "<leader>ss", function() persistence.stop() end, desc = "Stop auto-save session" },
          })
        END
      '';
    }
  ];
}
