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
      claude-code
    ];

    file = {
      ".claude/mcp.json".text = ''
        {
          "mcpServers": ${import ./mcp-servers.nix { inherit pkgs mcpServers; }}
        }
      '';
    };
  };

  programs.fish.shellAliases = {
    ccm = "claude-code --mcp ~/.claude/mcp.json";
  };
}
