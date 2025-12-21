{
  pkgs,
  mcpServers,
  ...
}:
{
  home = {
    packages = with pkgs; [
      gemini-cli-bin
    ];

    file = {
      ".gemini/settings.json".text = ''
        {
          "general": {
            "disableUpdateNag": true
          },
          "security": {
            "auth": {
              "selectedType": "oauth-personal"
            }
          },
          "mcpServers": ${import ./mcp-servers.nix { inherit pkgs mcpServers; }}
        }
      '';
    };
  };
}
