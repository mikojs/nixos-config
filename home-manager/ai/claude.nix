{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    claude-code
  ];

  home.file = with builtins; {
    ".claude/mcp.json".text = ''
      {
        "mcpServers": ${readFile ./mcpServers.json}
      }
    '';
  };
}
