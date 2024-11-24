{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      test -f ~/init.fish && source ~/init.fish 2> /dev/null
    '';
  };
}
