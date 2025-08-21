{
  lib,
  pkgs,
  ai,
  ...
}:
{
  programs.neovim.plugins =
    with lib;
    with pkgs.vimPlugins;
    [
      {
        plugin = avante-nvim;
        type = "lua";
        config = ''
          require("avante_lib").load()
          require("avante").setup({
            ${if lists.length ai > 0 then ''provider = "${lists.head ai}",'' else ""}
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

  xdg.configFile = {
    "mcphub/servers.json".text = ''
      {
        "mcpServers": ${import ../ai/mcp-servers.nix { }}
      }
    '';
  };
}
