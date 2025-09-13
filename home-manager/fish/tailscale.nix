{
  ...
}:
let
  check_pattern = ''
    if not string match -q "*@*" $argv[1]
      echo "usage: tssh <username>@<hostname> [...argv]"

      return
    end
  '';
in
{
  programs.fish.interactiveShellInit = ''
    function tssh --description "tssh <username>@<hostname> [...argv]"
      ${check_pattern}

      set -l info (string split '@' $argv[1])
      ssh $info[1]@$(tailscale ip -4 $info[2]) -t fish $argv[2..-1]
    end

    function tdocker --description "tdocker <username>@<hostname> [...argv]"
      ${check_pattern}

      set -l info (string split '@' $argv[1])
      docker context ls -q | grep $info[2] &> /dev/null

      if test $status -eq 1
        docker context create $info[2] --docker host=ssh://$info[1]@$(tailscale ip -4 $info[2])
      end

      docker -c $info[2] $argv[2..-1]
    end
  '';
}
