{
  mcpServers,
  ...
}:
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
        "mcpServers": ${import ./mcp-servers.nix { inherit mcpServers; }}
      }
    '';
  };

  programs.fish.shellAliases = {
    ccm = "claude-code --mcp ~/.claude/mcp.json";
  };
}
