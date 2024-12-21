{ pkgs
, ...
}: {
  # follow: https://github.com/orgs/community/discussions/50263
  home.packages = with pkgs; [ firefox ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    copilot-vim
  ];
}
