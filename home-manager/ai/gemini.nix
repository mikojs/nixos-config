{
  mcpServers,
  ...
}:
{
  pkgs,
  ...
}:
{
  home = {
    packages = with pkgs; [
      gemini-cli
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
