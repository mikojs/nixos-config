{
  pkgs,
  ...
}:
{
  home = {
    file =
      with pkgs.miko;
      getDocs [
        {
          filePath = "ai/mcp/github";
          docs = ''
            # MCP github

            A Model Context Protocol server for GitHub. This server provides access to GitHub repositories and issues, allowing LLMs to interact with GitHub content.

            [Repositories](https://github.com/github/github-mcp-server)
          '';
        }
      ];

    packages = with pkgs; [
      github-mcp-server
    ];
  };
}
