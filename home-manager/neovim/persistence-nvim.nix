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
          require("persistence").setup({
            need = 0,
          })

          require("which-key").add({
            { "<leader>q", group = "Session (Persistence)" },
            { "<leader>ql", function() require("persistence").load({ last = true }) end, desc ="Load last session" },
            { "<leader>qd", function() require("persistence").stop() end, desc = "Stop Persistence" },
          })
        END
      '';
    }
  ];
}
