{ pkgs
, ...
}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      test -f ~/init.fish && source ~/init.fish 2> /dev/null
    '';

    plugins = [
      {
        name = "agnoster";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "theme-agnoster";
          rev = "master";
          sha256 = "OFESuesnfqhXM0aij+79kdxjp4xgCt28YwTrcwQhFMU=";
        };
      }
    ];
  };
}
