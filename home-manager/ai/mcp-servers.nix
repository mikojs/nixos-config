{
  mcpServers,
  ...
}:
builtins.toJSON (
  {
    "memory" = {
      "args" = [
        "-y"
        "@modelcontextprotocol/server-memory"
      ];
      "command" = "npx";
    };
    "sequentialthinking" = {
      "args" = [
        "-y"
        "@modelcontextprotocol/server-sequential-thinking"
      ];
      "command" = "npx";
    };
  }
  // mcpServers
)
