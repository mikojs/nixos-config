{
  ...
}:
let
  checkCommandStr = command: ''
    if not string match -q "*@*" $argv[1]
      echo "usage: ${command} <username>@<hostname> [...argv]"

      return
    end
  '';
in
{
  fish-alias = [
    "- `tssh`: Run `ssh` with tailscale."
    "  - `forward [...ports]`: Forward remote ports to local."
    "  - `exec [...commands]`: Run commands on remote."
    "- `tdocker`: Run `docker` with tailscale."
    "- `tcoder`: Run `coder` with tailscale."
  ];

  programs.fish.interactiveShellInit = ''
    function tssh --description "tssh <username>@<hostname> (forward|exec|*) [...argv]"
      ${checkCommandStr "tssh"}

      set -l info (string split '@' $argv[1])

      switch $argv[2]
        case forward
          set -l ports

          for port in $argv[3..-1]
            set -a ports "-L"
            set -a ports "$port:localhost:$port"
          end

          ssh $info[1]@$(tailscale ip -4 $info[2]) $ports -t fish

        case exec
          set -l commands (string join "; " $argv[3..-1])
          ssh $info[1]@$(tailscale ip -4 $info[2]) "fish -c \"$commands\""

        case '*'
          ssh $info[1]@$(tailscale ip -4 $info[2]) -t fish
      end
    end

    function tdocker --description "tdocker <username>@<hostname> [...argv]"
      ${checkCommandStr "tdocker"}

      set -l info (string split '@' $argv[1])
      docker context ls -q | grep $info[2] &> /dev/null

      if test $status -eq 1
        docker context create $info[2] --docker host=ssh://$info[1]@$(tailscale ip -4 $info[2])
      end

      docker -c $info[2] $argv[2..-1]
    end

    function tcoder --description "tcoder <username>@<hostname> <push|pull> <directory>"
      ${checkCommandStr "tcoder"}

      if not contains $argv[2] push pull
        echo "usage: tcoder <username>@<hostname> <push|pull> <directory>"
        return
      end

      set -l info (string split '@' $argv[1])
      coder $argv[2] ssh://$info[1]@$(tailscale ip -4 $info[2]) $argv[3]
    end
  '';
}
