{
  mcpServers,
}:
{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    gemini-cli
  ];

  home.file = {
    ".gemini/settings.json".text = ''
      {
        "selectedAuthType": "oauth-personal",
        "mcpServers": ${import ./mcp-servers.nix { inherit mcpServers; }}
      }
    '';
  };
}
