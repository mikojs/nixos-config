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

  programs.fish.interactiveShellInit = ''
    function ga --description "ga (-c|--claude) (-v|--antigravity) (-a|--all)"
      # 1. Parse arguments
      argparse 'c/claude' 'v/antigravity' 'a/all' -- $argv
      or return

      # 2. Determine enabled scope and analysis flags
      set -l enable_claude false
      set -l enable_antigravity false

      if set -q _flag_all; or not set -q _flag_claude; and not set -q _flag_antigravity
        set enable_claude true
        set enable_antigravity true
      else
        if set -q _flag_claude
          set enable_claude true
        end

        if set -q _flag_antigravity
          set enable_antigravity true
        end
      end

      # 3. Run analysis
      echo "Running GitNexus analysis..."
      gitnexus analyze
      or return 1

      # 4. Configure Claude MCP
      if test "$enable_claude" = "true"
        echo "Configuring Claude MCP (Project Scope)..."

        claude mcp add -s project gitnexus -- gitnexus mcp
      end

      # 5. Configure Antigravity MCP
      if test "$enable_antigravity" = "true"
        echo "Configuring Antigravity MCP (Project Scope)..."

        mkdir -p .agents
        set -l antigravity_file ".agents/mcp_config.json"
        set -l nexus_config '{"mcpServers": {"gitnexus": {"command": "gitnexus", "args": ["mcp"]}}}'

        if test -f $antigravity_file
          jq -s '.[0] * .[1]' $antigravity_file (echo $nexus_config | psub) > $antigravity_file.tmp
          mv $antigravity_file.tmp $antigravity_file
        else
          echo $nexus_config > $antigravity_file
        end
      end

      echo "✨ GitNexus is now ready for: "(test "$enable_claude" = "true" && echo "Claude ")(test "$enable_antigravity" = "true" && echo "Antigravity")
    end
  '';
}
