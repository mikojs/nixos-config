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

          Graph-powered code intelligence for AI agents, indexing any codebase and queryable via MCP or CLI.

          [Repository](https://github.com/abhigyanpatwari/GitNexus)

          ## Alias

          - `ga (-c|--claude) (-v|--antigravity) (-a|--all)`: Analyze the repo and
            configure the GitNexus MCP server for Claude and/or Antigravity. With no
            flag, both are configured.
        '';
      }
    ];

    packages = [
      pkgs.llm-agents.gitnexus

      (pkgs.writeShellScriptBin "ga" ''
        flag_claude=false
        flag_antigravity=false
        flag_all=false

        while [[ $# -gt 0 ]]; do
          case "$1" in
            -c|--claude)
              flag_claude=true
              shift
              ;;
            -v|--antigravity)
              flag_antigravity=true
              shift
              ;;
            -a|--all)
              flag_all=true
              shift
              ;;
            *)
              echo "ga: unknown flag: $1" >&2
              exit 1
              ;;
          esac
        done

        enable_claude=false
        enable_antigravity=false

        if [[ "$flag_all" == true || ( "$flag_claude" == false && "$flag_antigravity" == false ) ]]; then
          enable_claude=true
          enable_antigravity=true
        else
          [[ "$flag_claude" == true ]] && enable_claude=true
          [[ "$flag_antigravity" == true ]] && enable_antigravity=true
        fi

        echo "Running GitNexus analysis..."
        ${pkgs.llm-agents.gitnexus}/bin/gitnexus analyze || exit 1

        if [[ "$enable_claude" == true ]]; then
          echo "Configuring Claude MCP (Project Scope)..."

          ${pkgs.claude-code}/bin/claude mcp add -s project gitnexus -- gitnexus mcp
        fi

        if [[ "$enable_antigravity" == true ]]; then
          echo "Configuring Antigravity MCP (Project Scope)..."

          mkdir -p .agents
          antigravity_file=".agents/mcp_config.json"
          nexus_config='{"mcpServers": {"gitnexus": {"command": "gitnexus", "args": ["mcp"]}}}'

          if [[ -f "$antigravity_file" ]]; then
            ${pkgs.jq}/bin/jq -s '.[0] * .[1]' "$antigravity_file" <(echo "$nexus_config") > "$antigravity_file.tmp"
            mv "$antigravity_file.tmp" "$antigravity_file"
          else
            echo "$nexus_config" > "$antigravity_file"
          fi
        fi

        message="✨ GitNexus is now ready for: "
        [[ "$enable_claude" == true ]] && message="''${message}Claude "
        [[ "$enable_antigravity" == true ]] && message="''${message}Antigravity"
        echo "$message"
      '')
    ];
  };
}
