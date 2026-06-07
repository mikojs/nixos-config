{
  pkgs,
  miko,
  ...
}:
{
  home = {
    file = miko.getDocs [
      {
        filePath = "ai/gitnexus";
        docs = ''
          # GitNexus

          Graph-powered code intelligence for AI agents. Index any codebase and query via MCP or CLI.

          [Repository](https://github.com/abhigyanpatwari/GitNexus)
        '';
      }
    ];

    packages = [
      pkgs.llm-agents.gitnexus
    ];
  };
}
