{
  pkgs,
  ...
}:
{
  home = {
    file.".docs/ai/mcp/github.md".text = ''
      # MCP github

      A Model Context Protocol server for GitHub. This server provides access to GitHub repositories and issues, allowing LLMs to interact with GitHub content.

      [Repositories](https://github.com/github/github-mcp-server)

    '';

    packages = with pkgs; [
      github-mcp-server
    ];
  };
}
