{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    miko-initialize
    miko-coder
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = with pkgs; ''
      # Disable Greeting
      set fish_greeting

      # Nord Theme
      # https://github.com/nordtheme/nord/issues/102
      set nord0 2e3440
      set nord1 3b4252
      set nord2 434c5e
      set nord3 4c566a
      set nord4 d8dee9
      set nord5 e5e9f0
      set nord6 eceff4
      set nord7 8fbcbb
      set nord8 88c0d0
      set nord9 81a1c1
      set nord10 5e81ac
      set nord11 bf616a
      set nord12 d08770
      set nord13 ebcb8b
      set nord14 a3be8c
      set nord15 b48ead

      set fish_color_normal $nord4
      set fish_color_command $nord9
      set fish_color_quote $nord14
      set fish_color_redirection $nord9
      set fish_color_end $nord6
      set fish_color_error $nord11
      set fish_color_param $nord4
      set fish_color_comment $nord3
      set fish_color_match $nord8
      set fish_color_search_match $nord8
      set fish_color_operator $nord9
      set fish_color_escape $nord13
      set fish_color_cwd $nord8
      set fish_color_autosuggestion $nord6
      set fish_color_user $nord4
      set fish_color_host $nord9
      set fish_color_cancel $nord15
      set fish_pager_color_prefix $nord13
      set fish_pager_color_completion $nord6
      set fish_pager_color_description $nord10
      set fish_pager_color_progress $nord12
      set fish_pager_color_secondary $nord1

      ${miko-fish.interactiveShellInit}
    '';

    plugins = with pkgs.fishPlugins; [
      {
        name = "tide";
        src = tide.src;
      }
    ];

    shellAliases = {
      nsf = ''nix-shell --run "SHELL=$SHELL; fish"'';
    };
  };
}
