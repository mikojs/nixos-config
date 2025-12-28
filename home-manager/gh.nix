{
  pkgs,
  ...
}:
{
  home.file = {
    ".docs/gh.md".text = ''
      # GH

      GitHub CLI is used to login to GitHub and control repositories.

      [Repository](https://github.com/cli/cli)

    '';

    ".docs/gh/poi.md".text = ''
      # GH-poi

      Safely clean up your local branches.

      [Repository](https://github.com/seachicken/gh-poi)

    '';
  };

  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-poi
    ];
  };
}
