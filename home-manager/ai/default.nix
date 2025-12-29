{
  ai,
  mcpServers ? { },
  languages,
  ...
}:
{
  lib,
  pkgs,
  ...
}:
with lib;
with builtins;
let
  getConfig =
    (import ../../lib.nix).getConfig
      (
        (optionals (lists.length ai > 0) [
          ./uv.nix
          ./github.nix
        ])
        ++ (optionals (!(elem "nodejs" (map (a: a.language) languages))) [
          ./npx.nix
        ])
        ++ (map (a: ./${a}.nix) ai)
      )
      {
        inherit pkgs mcpServers;
      };

in
{
  home = {
    file =
      getConfig
        [
          "home"
          "file"
        ]
        {
          ".docs/ai/mcp/memory.md".text = ''
            # MCP memory

            A basic implementation of persistent memory using a local knowledge graph. This lets Claude remember information about the user across chats.

            [Repository](https://github.com/modelcontextprotocol/servers/tree/main/src/memory)

          '';

          ".docs/ai/mcp/sequentialthinking.md".text = ''
            # MCP sequentialthinking

            An MCP server implementation that provides a tool for dynamic and reflective problem-solving through a structured thinking process.

            [Repository](https://github.com/modelcontextprotocol/servers/tree/main/src/sequentialthinking)

          '';

          ".docs/ai/mcp/fetch.md".text = ''
            # MCP fetch

            A Model Context Protocol server that provides web content fetching capabilities.
            This server enables LLMs to retrieve and process content from web pages, converting HTML to markdown for easier consumption.

            [Repository](https://github.com/modelcontextprotocol/servers/tree/main/src/fetch)

          '';

          ".docs/ai/mcp/n8n.md".text = ''
            # MCP n8n

            A Model Context Protocol server for N8N. This server provides access to N8N workflows, allowing LLMs to interact with N8N content.

            [Repository](https://github.com/czlonkowski/n8n-mcp)

          '';

        };

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
