{
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
  }
  // mcpServers
)
