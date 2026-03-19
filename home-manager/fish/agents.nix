{
  ai,
  ...
}:
with builtins;
{
  fish-alias = [
    "- `aa`: Run the agent in the agent folder."
    "- `ac`: Copy the agent file to the target folder."
  ];

  programs.fish.interactiveShellInit = ''
    set -g agents

    if test -d ~/.agents
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

      set -l root_dir $(realpath ~/.agents)

      for file_path in $(find_files ~/.agents)
        set -l relative_path (string replace "$root_dir/" "" $file_path)

        complete -c ac -f -n "__fish_use_subcommand" -a $relative_path
      end
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

    function ac --description "ac <source> <target folder>"
      set -l source_path ~/.agents/$argv[1]
      set -l target_path argv[2]

      set -l file_name (string split '/' $source_path)[-1]
      set -l file_extension (string split '.' $file_name)[-1]

      switch $file_extension
        case "md"
          cat $source_path > $target_path/$file_name
        case "json"
          cat $source_path | jq . > $target_path/$file_name
      end
    end
  '';
}
