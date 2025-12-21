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
          "selectedAuthType": "oauth-personal",
          "disableUpdateNag": true,
          "mcpServers": ${import ./mcp-servers.nix { inherit pkgs mcpServers; }}
        }
      '';
    };
  };
}
