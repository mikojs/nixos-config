{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = mcphub-nvim;
      type = "lua";
      config = ''
        require("mcphub").setup({
          system_prompt = function()
            local hub = require("mcphub").get_hub_instance()
            return hub and hub:get_active_servers_prompt() or ""
          end,

          custom_tools = function()
            return {
              require("mcphub.extensions.avante").mcp_tool(),
            }
          end,
        })
      '';
    }
  ];
}
