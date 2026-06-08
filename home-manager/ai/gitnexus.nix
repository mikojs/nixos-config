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
    function ga --description "ga (-c|--claude) (-g|--gemini) (-a|--all)"
      # 1. Parse arguments
      argparse 'c/claude' 'g/gemini' 'a/all' -- $argv
      or return

      # 2. Determine enabled scope and analysis flags
      set -l enable_claude false
      set -l enable_gemini false
      set -l analyze_flags

      if set -q _flag_all; or not set -q _flag_claude; and not set -q _flag_gemini
        set enable_claude true
        set enable_gemini true
      else
        if set -q _flag_claude
          set enable_claude true
        end
        if set -q _flag_gemini
          set enable_gemini true
          if not test "$enable_claude" = "true"
            set -a analyze_flags "--skip-skills"
          end
        end
      end

      # 3. Run analysis
      echo "🔍 Step 1: Running GitNexus analysis..."
      gitnexus analyze $analyze_flags
      or return 1

      # 4. Smart Markdown file handling
      if test "$enable_gemini" = "true"; and test -f CLAUDE.md
        set -l src "CLAUDE.md"
        set -l dst "GEMINI.md"
        set -l start_marker "<!-- GITNEXUS_START -->"
        set -l end_marker "<!-- GITNEXUS_END -->"

        if not test -f $dst
          echo "📝 Step 2: Creating GEMINI.md with markers..."
          echo $start_marker > $dst
          cat $src >> $dst
          echo $end_marker >> $dst
          echo "" >> $dst
          echo "# Project Rules" >> $dst
          echo "- Add your custom rules here..." >> $dst
        else
          if grep -q "$start_marker" $dst
            echo "🔄 Step 2: Syncing GitNexus section in GEMINI.md..."
            set -l tmp (mktemp)
            sed -n "1,/$start_marker/p" $dst > $tmp
            cat $src >> $tmp
            sed -n "/$end_marker/,\$p" $dst >> $tmp
            mv $tmp $dst
          else
            echo "⚠️  Step 2: GEMINI.md exists but no markers found. Wrapping content..."
            set -l tmp (mktemp)
            echo $start_marker > $tmp
            cat $src >> $tmp
            echo $end_marker >> $tmp
            echo "" >> $tmp
            echo "---" >> $tmp
            cat $dst >> $tmp
            mv $tmp $dst
          end
        end

        if not test "$enable_claude" = "true"
          rm -f CLAUDE.md AGENTS.md
        end
      end

      # 5. Configure Claude MCP
      if test "$enable_claude" = "true"
        echo "🔧 Step 3: Configuring Claude MCP (Project Scope)..."
        claude mcp add -s project gitnexus -- gitnexus mcp
      end

      # 6. Configure Gemini MCP
      if test "$enable_gemini" = "true"
        echo "🔧 Step 4: Configuring Gemini MCP (Project Scope)..."
        mkdir -p .gemini
        set -l gemini_file ".gemini/settings.json"
        set -l nexus_config '{"mcpServers": {"gitnexus": {"command": "gitnexus", "args": ["mcp"]}}}'

        if test -f $gemini_file
          jq -s '.[0] * .[1]' $gemini_file (echo $nexus_config | psub) > $gemini_file.tmp
          mv $gemini_file.tmp $gemini_file
        else
          echo $nexus_config > $gemini_file
        end
      end

      echo "✨ GitNexus is now ready for: "(test "$enable_claude" = "true" && echo "Claude ")(test "$enable_gemini" = "true" && echo "Gemini")
    end
  '';
}
