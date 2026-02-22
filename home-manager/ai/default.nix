{
  ai,
  mcpServers ? { },
  languages,
  ...
}:
{
  lib,
  pkgs,
  miko,
  ...
}:
with lib;
with builtins;
let
  useAI = lists.length ai > 0;

  newMcpServers = builtins.toJSON (
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
  );

  getConfig =
    miko.getConfig
      (
        (optionals useAI [
          ./uv.nix
          ./github.nix
        ])
        ++ (optionals (!(elem "nodejs" (map (a: a.language) languages))) [
          ./npx.nix
        ])
        ++ (map (a: ./${a}.nix) ai)
      )
      {
        inherit pkgs miko;
        mcpServers = newMcpServers;
      };

in
if !useAI then
  { }
else
  {
    home = {
      file =
        getConfig
          [
            "home"
            "file"
          ]
          (
            miko.getDocs [
              {
                filePath = "ai/mcp/memory";
                docs = ''
                  # MCP memory

                  A basic implementation of persistent memory using a local knowledge graph. This lets Claude remember information about the user across chats.

                  [Repository](https://github.com/modelcontextprotocol/servers/tree/main/src/memory)
                '';
              }
              {
                filePath = "ai/mcp/sequentialthinking";
                docs = ''
                  # MCP sequentialthinking

                  An MCP server implementation that provides a tool for dynamic and reflective problem-solving through a structured thinking process.

                  [Repository](https://github.com/modelcontextprotocol/servers/tree/main/src/sequentialthinking)
                '';
              }
              {
                filePath = "ai/mcp/fetch";
                docs = ''
                  # MCP fetch

                  A Model Context Protocol server that provides web content fetching capabilities.
                  This server enables LLMs to retrieve and process content from web pages, converting HTML to markdown for easier consumption.

                  [Repository](https://github.com/modelcontextprotocol/servers/tree/main/src/fetch)
                '';
              }
              {
                filePath = "ai/mcp/n8n";
                docs = ''
                  # MCP n8n

                  A Model Context Protocol server for N8N. This server provides access to N8N workflows, allowing LLMs to interact with N8N content.

                  [Repository](https://github.com/czlonkowski/n8n-mcp)
                '';
              }
            ]
          );

      packages =
        getConfig
          [
            "home"
            "packages"
          ]
          [ ];
    };

    programs.fish = {
      interactiveShellInit = "
        if not set -q GITHUB_PERSONAL_ACCESS_TOKEN and type -q gh and gh status &> /dev/null
          set -Ux GITHUB_PERSONAL_ACCESS_TOKEN $(gh auth token)
        end
      ";

      shellAliases = getConfig [
        "programs"
        "fish"
        "shellAliases"
      ] { };
    };
  }
