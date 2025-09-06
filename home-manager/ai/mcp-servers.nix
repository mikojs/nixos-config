{
  pkgs,
  mcpServers,
  ...
}:
builtins.toJSON (
  {
    memory = {
      command = "npx";
      args = [
        "-y"
        "@modelcontextprotocol/server-memory"
      ];
    };
    sequentialthinking = {
      command = "npx";
      args = [
        "-y"
        "@modelcontextprotocol/server-sequential-thinking"
      ];
    };
    fetch = {
      command = "uvx";
      args = [ "mcp-server-fetch" ];
    };
    github = {
      command = "${pkgs.github-mcp-server}/bin/github-mcp-server";
      args = [ "stdio" ];
    };
  }
  // mcpServers
)
