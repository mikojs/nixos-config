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

          ## Gotcha

          - Needs `AGENT_BROWSER_EXECUTABLE_PATH` set to a browser binary — not set by
            this package itself. NixOS browser paths differ from upstream's defaults,
            so this must be set manually (e.g. in `programs.fish.interactiveShellInit`
            or `home.sessionVariables`).
        '';
      }
    ];

    packages = with pkgs; [
      agent-browser
    ];
  };
}
