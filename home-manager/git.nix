{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    cz-cli
  ];

  programs.git = {
    enable = true;

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };

    aliases.gr = "log --date=short --graph --pretty=format:'%C(yellow)%h%Creset %ad %C(bold green)%an%Creset %s%C(yellow)%d%Creset'";
  };
}
