{
  pkgs,
  mcpServers,
  ...
}:
{
  home = {
    file = {
      ".docs/ai/claude-code.md".text = ''
        # Claude Code

        Claude Code is an AI agent that brings the power of Claude directly into your code.

        [Repository](https://github.com/anthropics/claude-code)

        ## Alias

        - `ccm`: Run `claude-code` with `mcp` servers.

      '';

      ".claude/mcp.json".text = ''
        {
          "mcpServers": ${import ./mcp-servers.nix { inherit pkgs mcpServers; }}
        }
      '';
    };

    packages = with pkgs; [
      claude-code
    ];
  };

  programs.fish.shellAliases = {
    ccm = "claude --mcp-config ~/.claude/mcp.json";
  };
}
