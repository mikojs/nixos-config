{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    claude-code
  ];

  home.file = {
    ".claude/mcp.json".text = ''
      {
        "mcpServers": ${import ./mcp-servers.nix { }}
      }
    '';
  };
}
