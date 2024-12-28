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
            { "<leader>s", group = "Session" },
            { "<leader>sl", function() require("persistence").load({ last = true }) end, desc ="Load last session" },
            { "<leader>ss", function() require("persistence").stop() end, desc = "Stop auto-save session" },
          })
        END
      '';
    }
  ];
}
