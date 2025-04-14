{
  pkgs,
  gitconfig,
  ...
}:
{
  home = {
    packages = with pkgs; [
      cz-cli
      delta
    ];

    file.".czrc".text = ''
      {
        "path": "cz-conventional-changelog"
      }
    '';
  };

  programs.git = gitconfig // {
    enable = true;

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;

      # delta
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      delta.side-by-side = true;
      delta.navigate = true;
      delta.dark = true;
      mege.conflictStyle = "zdiff3";
    };

    aliases.gr = "log --date=short --graph --pretty=format:'%C(yellow)%h%Creset %ad %C(bold green)%an%Creset %s%C(yellow)%d%Creset'";
  };
}
