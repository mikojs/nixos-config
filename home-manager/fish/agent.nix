{
  ai,
  ...
}:
with builtins;
{
  fish-alias = [
    "- `aa`: Run the agent in the agent folder."
  ];

  programs.fish.interactiveShellInit = ''
    set -g agents

    for agent in $(ls ~/.agents)
      for ai in ${concatStringsSep " " ai}
        if not test -e ~/.agents/$agent/$(string upper $ai).md
          continue
        end

        set -a agents "$ai@$agent"
      end
    end

    for agent in $agents
      set -l info (string split '@' $agent)

      complete -c aa -f -n "__fish_use_subcommand" -a $agent -d "Run the $info[1] as $info[2] agent."
    end

    function aa --description "aa <ai@agent> [...argv]"
      if not contains $argv[1] $agents
        echo "Unknown agent: $argv[1], Available agents:"
        echo ""

        for agent in $agents
          echo "- $agent"
        end

        echo ""

        return
      end

      set -l current $(pwd)
      set -l info (string split '@' $argv[1])

      cd ~/.agents/$info[2]
      $info[1] $argv[2..-1]
      cd $current
    end
  '';
}
