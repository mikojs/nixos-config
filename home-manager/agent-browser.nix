{
  pkgs,
  miko,
  ...
}:
{
  home = {
    file = miko.getDocs [
      {
        filePath = "agent-browser";
        docs = ''
          # agent-browser

          Browser automation CLI for AI agents.

          [Repository](https://github.com/vercel-labs/agent-browser)
        '';
      }
    ];

    packages = with pkgs; [
      agent-browser
    ];
  };
}
