{
  ...
}:
let
  check_pattern = command: ''
    if not string match -q "*@*" $argv[1]
      echo "usage: ${command} <username>@<hostname> [...argv]"

      return
    end
  '';
in
{
  programs.fish.interactiveShellInit = ''
    function tssh --description "tssh <username>@<hostname> [...argv]"
      ${check_pattern "tssh"}

      set -l info (string split '@' $argv[1])
      ssh $info[1]@$(tailscale ip -4 $info[2]) -t fish $argv[2..-1]
    end

    function tdocker --description "tdocker <username>@<hostname> [...argv]"
      ${check_pattern "tdocker"}

      set -l info (string split '@' $argv[1])
      docker context ls -q | grep $info[2] &> /dev/null

      if test $status -eq 1
        docker context create $info[2] --docker host=ssh://$info[1]@$(tailscale ip -4 $info[2])
      end

      docker -c $info[2] $argv[2..-1]
    end

    function tcoder --description "tcoder <username>@<hostname> <push|pull> <directory>"
      ${check_pattern "tcoder"}

      if not contains $argv[2] push pull
        echo "usage: tcoder <username>@<hostname> <push|pull> <directory>"
        return
      end

      set -l info (string split '@' $argv[1])
      coder $argv[2] ssh://$info[1]@$(tailscale ip -4 $info[2]) $argv[3]
    end
  '';
}
