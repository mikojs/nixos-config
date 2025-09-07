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
    n8n-mcp = {
      command = "npx";
      args = [ "n8n-mcp" ];
      env = {
        MCP_MODE = "stdio";
        LOG_LEVEL = "error";
        DISABLE_CONSOLE_OUTPUT = "true";
      };
    };
  }
  // mcpServers
)
