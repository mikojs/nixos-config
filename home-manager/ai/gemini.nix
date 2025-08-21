{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    gemini-cli
  ];

  home.file = with builtins; {
    ".gemini/settings.json".text = ''
      {
        "selectedAuthType": "oauth-personal",
        "mcpServers": ${readFile ./mcpServers.json}
      }
    '';
  };
}
