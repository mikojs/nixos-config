{
  pkgs,
  miko,
  ...
}:
{
  home.file =
    miko.getDocs [
      {
        filePath = "tmux-powerline";
        docs = ''
          # Tmux Powerline

          A tmux status bar plugin with extensible segments.

          [Repository](https://github.com/erikw/tmux-powerline)

          ## Customize

          - Nord color theme (`~/.config/tmux-powerline/themes/nord.sh`)
        '';
      }
    ]
    // {
      ".config/tmux-powerline/config.sh".source = ./config.sh;
      ".config/tmux-powerline/themes/nord.sh".source = ./nord.sh;
    };

  programs.tmux.plugins = with pkgs.tmuxPlugins; [
    tmux-powerline
  ];
}
